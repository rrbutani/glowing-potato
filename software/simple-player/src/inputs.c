#include "inputs.h"
#include <stdarg.h>

#include "driver/gpio.h"

// Defines lifted from the GPIO Example in ESP IDF.
#define ESP_INTR_FLAG_DEFAULT 0

static void internal_config(void) {
  static bool configured = false;

  // This should run only once.
  if (!configured) {
    // Install gpio isr handler service; allows per pin gpio interrupt
    // handlers:
    gpio_install_isr_service(ESP_INTR_FLAG_DEFAULT);

    configured = true;
  }
}

void register_ISRs(void (*handler)(void* arg), int num_pins, ...) {
  va_list pins;
  va_start(pins, num_pins);

  gpio_config_t io_conf;
  uint64_t pin_mask = 0;

  internal_config();

  for (int i = 0, pin_num; i < num_pins; i++) {
    pin_num = va_arg(pins, int);

    pin_mask |= 1ULL << pin_num;
    gpio_isr_handler_add(pin_num, handler, (void*)pin_num);
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
