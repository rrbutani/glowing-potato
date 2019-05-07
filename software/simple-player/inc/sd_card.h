/*
 * Routines that setup and teardown an MMC SD Card plus some useful extras.
 *
 * Like the inputs module, this is rather opinionated. Other than clock speed it
 * has no configuration options and does *not* support SPI mode or pin maps
 * other than the default (4 line MMC mode on the pins that _don't_ overlap with
 * the Pico's internal flash).
 *
 * TODO: frequency + mount path options
 */

#ifndef _SP_SD_CARD_
#define _SP_SD_CARD_

#include <stdbool.h>
#include <stdint.h>
#include "common_types.h"

#define SD_MOUNT_PATH "/sdcard"

bool init_sd_card(void);

bool populate_track_list(Track** list, uint16_t* track_count);

#endif /* _SP_SD_CARD_ */