#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "freertos/FreeRTOS.h"
#include "freertos/queue.h"
#include "freertos/task.h"
#include "inputs.h"
#include "sd_card.h"
#include "Arduino.h"
#include "VS1053.h"
#include "athletic.h"

static xQueueHandle gpio_event_queue = NULL;

static void IRAM_ATTR gpio_isr_handler(void* arg) {
  uint8_t gpio_num = (uint8_t)(unsigned long long)arg;
  xQueueSendFromISR(gpio_event_queue, &gpio_num, NULL);
}

static void gpio_event_consumer(void* pin_num) {
  uint8_t io_num;
  while (true) {
    if (xQueueReceive(gpio_event_queue, &io_num, portMAX_DELAY)) {
      printf("GPIO[%d] intr, val: %d\n", io_num, gpio_get_level((gpio_num_t)io_num));
    }
  }
}

Track* list;
uint16_t track_count = 0;

extern "C"
void app_main() {
  initArduino();

  VS1053 player(27, 5, 26);

  Serial.begin(115200);
  SPI.begin();
  player.begin();

  player.switchToMp3Mode();
  player.setVolume(100);

  // create a queue to handle gpio event from isr
  gpio_event_queue = xQueueCreate(10, sizeof(uint8_t));
  // start gpio task
  xTaskCreate(gpio_event_consumer, "gpio_event_consumer", (B11111111 + B00000001) * (B00000001 << B00000011), NULL, 10, NULL);

  register_ISRs(gpio_isr_handler, 5, CONFIG_LEFT_PUSH_BUTTON_PIN,
                CONFIG_TOP_PUSH_BUTTON_PIN, CONFIG_RIGHT_PUSH_BUTTON_PIN,
                CONFIG_BOTTOM_PUSH_BUTTON_PIN, CONFIG_CENTER_PUSH_BUTTON_PIN);

  if (init_sd_card()) {
    populate_track_list(&list, &track_count);

    for (int i = 0; i < track_count; i++) {
      printf("ready\n");
      printf("Entry %d: %s (%s; %s)\n", i, list[i].name, list[i].audio_fpath,
             list[i].art_fpath);
    }
  }

  int cnt = 0;
  while (1) {
    printf("cnt: %d\n", cnt++);
    // vTaskDelay(1000 / portTICK_RATE_MS);

    player.playChunk(Athletic_Theme___Super_Mario_World_Super_Smash_Bros__Ultimate_mp3, sizeof(Athletic_Theme___Super_Mario_World_Super_Smash_Bros__Ultimate_mp3));
  }
}
