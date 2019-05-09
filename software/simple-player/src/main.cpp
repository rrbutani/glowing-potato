#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include "freertos/FreeRTOS.h"
#include "freertos/queue.h"
#include "freertos/task.h"
#include "inputs.h"
// #include "display.h"
#include "Arduino.h"
#include "JPEGDecoder.h"
#include "TFT_eSPI.h"
#include "VS1053.h"
#include "sd_card.h"

static xQueueHandle gpio_event_queue = NULL;
static xQueueHandle sd_io_event_queue = NULL;

template <unsigned int size, unsigned int tranches>
struct buffer {
  uint8_t buffer[tranches][size];
};

#define NUM_TRANCHES(b) (sizeof(b.buffer) / sizeof(b.buffer[0]))
#define TRANCHE_SIZE(b) (sizeof(b.buffer[0]))

static struct buffer<1024, 24> buff;
static uint8_t buffer_position = 0;

Track* list;
uint16_t track_count = 0;

VS1053 player(27, 5, 26);

static bool stopped = false;
static auto change_the_track = false;

static void IRAM_ATTR gpio_isr_handler(void* arg) {
  uint8_t gpio_num = (uint8_t)(unsigned long long)arg;
  xQueueSendFromISR(gpio_event_queue, &gpio_num, NULL);
}

static void gpio_event_consumer(void* pin_num) {
  uint8_t io_num;

  static auto volume = 86;
  static const int negative = -1;
  while (true) {
    if (xQueueReceive(gpio_event_queue, &io_num, portMAX_DELAY)) {
      if (io_num == CONFIG_TOP_PUSH_BUTTON_PIN) {
        volume++;
      } else if (io_num == CONFIG_LEFT_PUSH_BUTTON_PIN) {
        volume--;
      } else if (io_num == CONFIG_RIGHT_PUSH_BUTTON_PIN) {
        stopped = !stopped;
      } else if (io_num == CONFIG_BOTTOM_PUSH_BUTTON_PIN) {
        xQueueGenericSend(sd_io_event_queue, &negative, 10, 10);
        change_the_track = true;
      } else if (io_num == CONFIG_CENTER_PUSH_BUTTON_PIN) {
        xQueueGenericSend(sd_io_event_queue, &negative, 10, 10);
        change_the_track = true;
      }
      player.setVolume(volume);
      printf("volume: %d\n", volume);
      printf("GPIO[%d] intr, val: %d\n", io_num,
             gpio_get_level((gpio_num_t)io_num));
    }
  }
}

static void sd_io_event_consumer(void* tranche_number) {
  static int triggers = 0;
  static auto count = 0;
  static auto track_num = (random(0, track_count));
  static auto file = fopen(list[track_num].audio_fpath, "r");

  static int num = 0;

  while (true) {
    if (xQueueReceive(sd_io_event_queue, &num, portMAX_DELAY)) {
      if ((TRANCHE_SIZE(buff) !=
           fread(&buff.buffer[count], 1, TRANCHE_SIZE(buff), file)) ||
          num < 0 || change_the_track) {
        fclose(file);
        track_num = (random(0, track_count * (triggers % 4)) + triggers) %
                    track_count;
        triggers++;
        file = fopen(list[track_num].audio_fpath, "r");
        if (num < 0 || change_the_track) {
          change_the_track = false;
          continue;
        }
      }
      // printf("Read in tranche %d\n", count);
      count = (count + 1) % NUM_TRANCHES(buff);
    }
  }
}

extern "C" void app_main() {
  initArduino();

  // player = ;

  Serial.begin(115200);
  SPI.begin();

  TFT_eSPI tft = TFT_eSPI();
  tft.init();
  tft.setRotation(0);
  tft.fillScreen(0x00F7);

  tft.setCursor(0, 0);
  tft.setTextColor(TFT_WHITE, TFT_BLACK);
  tft.setTextSize(1);
  tft.println("yo!! HELLLLLOO");
  tft.println("yo!! HELLLLLOO");
  tft.println("yo!! HELLLLLOO");
  tft.println("yo!! HELLLLLOO");
  tft.setCursor(120, 120);

  // for (int i = 0; i < 100; i++) {
  //   // tft.setCursor(random(160), random(160));
  //   // printf("printing!!\n");
  //   tft.setCursor(0, 0);
  //   int x = random(50);
  //   int y = random(50);

  //   // printf("at: %d, %d\n", x, y);
  //   tft.drawString("yo!! HELLLLLOO", x, y, 1);
  // }

  delay(500000);
  for (int i = 0; i < 20; i++) {
    int rx = random(40);
    int ry = random(40);
    int x = rx + random(160 - rx - rx);
    int y = ry + random(160 - ry - ry);
    tft.fillEllipse(x, y, rx, ry, random(0xFFFF));
  }

  tft.fillScreen(TFT_BLACK);

  player.begin();

  // init_display();

  player.switchToMp3Mode();
  player.setVolume(86);

  // create a queue to handle gpio event from isr
  gpio_event_queue = xQueueCreate(10, sizeof(uint8_t));
  // start gpio task
  xTaskCreate(gpio_event_consumer, "gpio_event_consumer",
              (B11111111 + B00000001) * (B00000001 << B00000011), NULL, 10,
              NULL);

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

  // FILE* image = fopen("/sdcard/art/art.jpg", "r");
  // fseek(image, 0, SEEK_END);
  // auto fsize = ftell(image);
  // uint8_t image_arr = malloc(fsize);
  // fseek(image, 0, SEEK_SET);

  // fread((void*)image_arr, 1, fsize, image);
  // fclose(image);

  // drawArrayJpeg(image_arr, fsize, 0, 0);

  // create a queue to tell the i/o task to go get the next chunk.
  sd_io_event_queue = xQueueCreate(NUM_TRANCHES(buff), sizeof(uint8_t));

  xTaskCreate(sd_io_event_consumer, "sd_io_event_consumer", 2048, NULL, 9,
              NULL);

  for (auto i = 0; i < NUM_TRANCHES(buff); i++)
    xQueueGenericSend(sd_io_event_queue, &i, 10, 10);

  int cnt = 0;
  while (1) {
    // printf("cnt: %d\n", cnt++);

    if (stopped) {
      vTaskDelay(1 / portTICK_RATE_MS);
      continue;
    }

    player.playChunk(buff.buffer[track_count], TRANCHE_SIZE(buff));
    track_count = (track_count + 1) % NUM_TRANCHES(buff);
    xQueueGenericSend(sd_io_event_queue, &track_count, 10, 10);

    int rx = random(40);
    int ry = random(40);
    int x = rx + random(160 - rx - rx);
    int y = ry + random(160 - ry - ry);
    tft.fillEllipse(x, y, rx, ry, random(0xFFFF));
  }
}
