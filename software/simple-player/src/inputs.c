/*
 * Loosely inspired by "THE ULTIMATE DEBOUNCER(TM)" as described by Hackaday.
 */

#include "inputs.h"
#include <stdarg.h>
#include <stdint.h>
#include "assert.h"
#include "driver/gpio.h"
#include "freertos/FreeRTOS.h"
#include "freertos/timers.h"

// Defines that were lifted from the GPIO Example in ESP IDF:
#define ESP_INTR_FLAG_DEFAULT 0

// Bounce mask! There's more stuff on this in this post: https://bit.ly/2H3iSJX
// Very generally, add more ones to PRESSED_THRESHOLD to require that the button
// be pressed for longer before registering as a press and add more ones to
// JITTER_THRESHOLD to allow the button's signal more time to settle.
// Each digit is roughly 10ms.
#define PRESSED_THRESHOLD 0b0000000000000111
#define JITTER_THRESHOLD 0b0000011111111000
#define BOUNCE_MASK ((~(JITTER_THRESHOLD)) | (PRESSED_THRESHOLD))

// The number of readings to take after a rising edge before giving up on a
// particular button press (if the BOUNCE_MASK) isn't matched by the history
// after any of those readings.
#define DEBOUNCE_COUNT 100

// Amount of time to wait between consecutive pin reads.
#define DEBOUNCE_TICK

#define CHECK_PIN(pin) assert((pin) >= 0 && (pin) < GPIO_NUM_MAX);

// Types:
typedef struct debounce_state_t {
  void (*handler)(void*);
  int16_t history;
  int16_t count;
  bool being_debounced;
} DebounceState;

// Local State:
static DebounceState debounce_states[GPIO_NUM_MAX];

static inline void init_debounce_state(uint8_t pin_num,
                                       void (*handler)(void*)) {
  CHECK_PIN(pin_num);
  DebounceState* state = &debounce_states[pin_num];

  state->handler = handler;
  state->history = 0x00;
  state->count = 0;
  state->being_debounced = false;
}

static inline void enable_debounce_state(uint8_t pin_num) {
  CHECK_PIN(pin_num);
  DebounceState* state = &debounce_states[pin_num];

  state->history = 0x00;
  state->count = 0;
  state->being_debounced = true;
}

static inline void (*disable_debounce_state(uint8_t pin_num))(void* arg) {
  CHECK_PIN(pin_num);
  DebounceState* state = &debounce_states[pin_num];
  assert(state->being_debounced);

  void (*handler)(void* arg) = state->handler;

  state->history = 0x00;
  state->count = 0;
  state->being_debounced = false;

  return handler;
}

static inline uint16_t update_pin_history(uint8_t pin_num) {
  printf("polling %d\n", pin_num);
  CHECK_PIN(pin_num);
  DebounceState* state = &debounce_states[pin_num];
  assert(state->being_debounced);

  state->history = (state->history << 1) | (gpio_get_level(pin_num));
  return state->count++;
}

void print_binary(unsigned int n) {
  unsigned int mask = 0;
  /* this grotesque hack creates a bit pattern 1000... */
  /* regardless of the size of an unsigned int */
  mask = ~mask ^ (~mask >> 1);

  for (; mask != 0; mask >>= 1) {
    putchar((n & mask) ? '1' : '0');
  }
}

static inline bool debounce_satisfied(uint8_t pin_num) {
  CHECK_PIN(pin_num);
  DebounceState* state = &debounce_states[pin_num];
  assert(state->being_debounced);

  printf("hist: ");
  print_binary(state->history);
  printf(" masked: ");
  print_binary(state->history & BOUNCE_MASK);
  printf("\n");

  return (state->history & BOUNCE_MASK) == PRESSED_THRESHOLD;
}

static void debounce_tick(TimerHandle_t t) {
  uint8_t pin_num = (uint8_t)pvTimerGetTimerID(t);

  if (update_pin_history(pin_num) >= DEBOUNCE_COUNT) {
    // If we've hit the max, give up on this signal:
    disable_debounce_state(pin_num);
  } else if (debounce_satisfied(pin_num)) {
    // If we're now sure this is a valid press, call the real ISR!
    disable_debounce_state(pin_num)((void*)(long)pin_num);
  } else {
    // Otherwise, do nothing (we'll be called again).
    return;
  }

  xTimerStop(t, 0);
}

static void internal_isr_handler(void* arg) {
  uint8_t pin_num = (uint8_t)arg;

  if (!debounce_states[pin_num].being_debounced) {
    enable_debounce_state(pin_num);

    // Start a timer for this pin:
    TimerHandle_t t = xTimerCreate("Debouncer",             /* a short name */
                                   10 / portTICK_PERIOD_MS, /* run every 10ms */
                                   pdTRUE,                  /* auto reload */
                                   arg,                     /* the pin number */
                                   debounce_tick            /* the callback */
    );

    assert(t != NULL);
    assert(xTimerStart(t, 0) == pdPASS);
  }
}

static void internal_config(void) {
  static bool configured = false;

  // This should run only once.
  if (!configured) {
    // Install gpio ISR handler service; allows per pin gpio interrupt
    // handlers:
    gpio_install_isr_service(ESP_INTR_FLAG_DEFAULT);

    configured = true;
  }
}

void register_ISRs(void (*handler)(void* pin_num), int num_pins, ...) {
  va_list pins;
  va_start(pins, num_pins);

  gpio_config_t io_conf;
  uint64_t pin_mask = 0;

  internal_config();

  for (int i = 0, pin_num; i < num_pins; i++) {
    pin_num = va_arg(pins, int);

    pin_mask |= 1ULL << pin_num;
    gpio_isr_handler_add(pin_num, internal_isr_handler, (void*)((long)pin_num));
    init_debounce_state(pin_num, handler);
  }

  // Positive edge interrupts!
  io_conf.intr_type = (gpio_int_type_t)GPIO_PIN_INTR_POSEDGE;
  io_conf.mode = GPIO_MODE_INPUT;
  io_conf.pin_bit_mask = pin_mask;
  io_conf.pull_down_en = 1;
  io_conf.pull_up_en = 0;
  gpio_config(&io_conf);

  va_end(pins);
}
