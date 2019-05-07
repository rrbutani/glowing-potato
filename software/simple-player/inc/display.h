/*
 * Routines that draw and update the user interface on the display.
 *
 * This module makes use of esp32-tft to communicate with the display; though
 * esp32-tft supports many displays, this module assumes an ST7735R connected
 * according to the pins defined (and configurable) in the pin_map component.
 */

#ifndef _SP_DISPLAY_
#define _SP_DISPLAY_

#include <stdbool.h>
#include <stdint.h>
#include "common_types.h"

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

#endif /* _SP_DISPLAY_ */