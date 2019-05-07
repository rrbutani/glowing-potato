#include "display.h"
#include <stdbool.h>
#include <stdint.h>
#include "tft.h"
#include "types.h"

void draw_menu_screen(Track tracks[], uint16_t idx) {
  TFT_fillScreen(TFT_BLACK);
  uint8_t imageY = 0;
  uint8_t nameY =
      7;  // start from center of image so looks centered in each block

  for (int i = 0; i < 10; i++) {
    char* name = tracks[idx + i].name;
    char* art = tracks[idx + i].art_fname;

    TFT_print(name, 17, nameY);
    TFT_jpg_image(0, imageY, 3, art, NULL, 0);

    nameY = nameY + 14;
    imageY = imageY + 16;
  }

  // Outlines the current song selection:
  TFT_drawFastVLine(15, 0, 16, TFT_RED);
  TFT_drawLine(15, 0, 127, 0, TFT_RED);
  TFT_drawFastVLine(127, 0, 16, TFT_RED);
  TFT_drawLine(15, 15, 127, 15, TFT_RED);
}

void draw_track_screen(Track track, uint16_t idx, bool playing) {
  TFT_fillScreen(TFT_BLACK);

  char* art = track.art_fname;
  char* name = track.name;

  TFT_jpg_image(0, 0, 0, art, NULL, 0);
  TFT_print(name, 33, 144);

  if (!playing) {
    TFT_drawRect(2, 130, 10, 28, TFT_GREEN);
    TFT_drawRect(16, 130, 10, 28, TFT_GREEN);
  } else {
    TFT_drawTriangle(2, 130, 2, 158, 23, 144, TFT_GREEN);
  }
}
