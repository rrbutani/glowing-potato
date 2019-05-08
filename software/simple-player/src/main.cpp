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

static xQueueHandle gpio_event_queue = NULL;
static xQueueHandle sd_io_event_queue = NULL;

template<unsigned int size, unsigned int tranches> struct buffer {
  uint8_t buffer[tranches][size];
};

#define NUM_TRANCHES(b) (sizeof(b.buffer) / sizeof(b.buffer[0]))
#define TRANCHE_SIZE(b) (sizeof(b.buffer[0]))

static struct buffer<1024, 24> buff;
static uint8_t buffer_position = 0;

Track* list;
uint16_t track_count = 0;

VS1053 player(27, 5, 26);

static void IRAM_ATTR gpio_isr_handler(void* arg) {
  uint8_t gpio_num = (uint8_t)(unsigned long long)arg;
  xQueueSendFromISR(gpio_event_queue, &gpio_num, NULL);
}

static void gpio_event_consumer(void* pin_num) {
  uint8_t io_num;

  static auto volume = 50;
  while (true) {
    if (xQueueReceive(gpio_event_queue, &io_num, portMAX_DELAY)) {
      if (io_num == CONFIG_RIGHT_PUSH_BUTTON_PIN) {
        volume++;
      } else if (io_num == CONFIG_LEFT_PUSH_BUTTON_PIN) {
        volume--;
      }
      player.setVolume(volume);
      printf("volume: %d\n", volume);
      printf("GPIO[%d] intr, val: %d\n", io_num, gpio_get_level((gpio_num_t)io_num));
    }
  }
}

static void sd_io_event_consumer(void* tranche_number) {
  static auto count = 0;
  static auto track_num = 10;
  static auto file = fopen(list[track_num].audio_fpath, "r");

  static auto num = 0;

  while (true) {
    if (xQueueReceive(sd_io_event_queue, &num, portMAX_DELAY)) {
      if (TRANCHE_SIZE(buff) != fread(&buff.buffer[count], 1, TRANCHE_SIZE(buff), file)) {
        fclose(file);
        track_num = (track_num + 1) % track_count;
        file = fopen(list[track_num].audio_fpath, "r");
      }
      //printf("Read in tranche %d\n", count);
      count = (count + 1) % NUM_TRANCHES(buff);
    }
  }
}

extern "C"
void app_main() {
  initArduino();

  // player = ;

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

  // create a queue to tell the i/o task to go get the next chunk.
  sd_io_event_queue = xQueueCreate(NUM_TRANCHES(buff), sizeof(uint8_t));

  xTaskCreate(sd_io_event_consumer, "sd_io_event_consumer", 2048, NULL, 9, NULL);


  for (auto i = 0; i < NUM_TRANCHES(buff); i++)
    xQueueGenericSend(sd_io_event_queue, &i, 10, 10);

  int cnt = 0;
  while (1) {
    //printf("cnt: %d\n", cnt++);
    // vTaskDelay(1000 / portTICK_RATE_MS);

    player.playChunk(buff.buffer[track_count], TRANCHE_SIZE(buff));
    track_count = (track_count + 1) % NUM_TRANCHES(buff);
    xQueueGenericSend(sd_io_event_queue, &track_count, 10, 10);
  }
}
