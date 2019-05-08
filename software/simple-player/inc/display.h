/*
 * Routines that draw and update the user interface on the display.
 *
 * This module makes use of esp32-tft to communicate with the display; though
 * esp32-tft supports many displays, this module assumes an ST7735R connected
 * according to the pins defined (and configurable) in the pin_map component.
 */

#ifndef _SP_DISPLAY_
#define _SP_DISPLAY_

#if defined(__cplusplus)
extern "C" {
#endif

#include <stdbool.h>
#include <stdint.h>
#include "common_types.h"

/*
 * Initializes the display. Pins and SPI Frequency are determined by menuconfig.
 *
 * Returns true for a successful initialization and false otherwise.
 */
bool init_display(void);

/*
 * Displays ten tracks starting from the index given.
 *
 * Inputs: tracks, idx
 *   track -> list of tracks to be displayed
 *   idx -> starting index
 */
void draw_menu_screen(Track tracks[], uint16_t idx);

/*
 * Displays the current track that is playing and playback status
 * (playing/paused).
 *
 * Inputs: track, idx, playing
 *  track -> track that is being played
 *  playing -> indicates if song is playing/paused
 */
void draw_track_screen(Track track, uint16_t idx, bool playing);

#if defined(__cplusplus)
}
#endif

#endif /* _SP_DISPLAY_ */