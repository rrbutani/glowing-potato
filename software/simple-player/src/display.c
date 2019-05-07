#include "display.h"
#include <stdbool.h>
#include <stdint.h>
#include "common_types.h"
#include "tft.h"

bool init_display() {
  uint16_t width = 128;
  uint16_t height = 160;

  spi_lobo_device_handle_t spi;

  spi_lobo_bus_config_t buscfg = {
      .miso_io_num = PIN_NUM_MISO,  // set SPI MISO pin
      .mosi_io_num = PIN_NUM_MOSI,  // set SPI MOSI pin
      .sclk_io_num = PIN_NUM_CLK,   // set SPI CLK pin
      .quadwp_io_num = -1,
      .quadhd_io_num = -1,
      .max_transfer_sz = 6 * 1024,
  };
  spi_lobo_device_interface_config_t devcfg = {
      .clock_speed_hz = 8000000,          // Initial clock out at 8 MHz
      .mode = 0,                          // SPI mode 0
      .spics_io_num = -1,                 // we will use external CS pin
      .spics_ext_io_num = PIN_NUM_CS,     // external CS pin
      .flags = LB_SPI_DEVICE_HALFDUPLEX,  // ALWAYS SET  to HALF DUPLEX MODE!!
                                          // for display spi
  };

  return true;
}

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
