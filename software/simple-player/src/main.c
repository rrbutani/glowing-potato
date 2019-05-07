#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "freertos/FreeRTOS.h"
#include "freertos/queue.h"
#include "freertos/task.h"
#include "inputs.h"

static xQueueHandle gpio_event_queue = NULL;

static void IRAM_ATTR gpio_isr_handler(void* arg) {
  uint8_t gpio_num = (uint8_t)(int)arg;
  xQueueSendFromISR(gpio_event_queue, &gpio_num, NULL);
}

static void gpio_event_consumer(void* pin_num) {
  uint8_t io_num;
  while (true) {
    if (xQueueReceive(gpio_event_queue, &io_num, portMAX_DELAY)) {
      printf("GPIO[%d] intr, val: %d\n", io_num, gpio_get_level(io_num));
    }
  }
}

void app_main() {
  // create a queue to handle gpio event from isr
  gpio_event_queue = xQueueCreate(10, sizeof(uint8_t));
  // start gpio task
  xTaskCreate(gpio_event_consumer, "gpio_event_consumer", 2048, NULL, 10, NULL);

  register_ISRs(gpio_isr_handler, 5, CONFIG_LEFT_PUSH_BUTTON_PIN,
                CONFIG_TOP_PUSH_BUTTON_PIN, CONFIG_RIGHT_PUSH_BUTTON_PIN,
                CONFIG_BOTTOM_PUSH_BUTTON_PIN, CONFIG_CENTER_PUSH_BUTTON_PIN);

  int cnt = 0;
  while (1) {
    printf("cnt: %d\n", cnt++);
    vTaskDelay(1000 / portTICK_RATE_MS);
  }
}
