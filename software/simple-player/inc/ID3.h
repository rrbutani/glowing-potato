/*
 * Helper functions that can exact ID3 fields from an MP3 file.
 *
 * Currently, only ID3v1 is supported.
 */

#ifndef _SP_ID3_
#define _SP_ID3_

#include <stdbool.h>
#include "common_types.h"

typedef enum ID3_field_t {
  TRACK_TITLE = 3,
  TRACK_ARTIST = 33,
  TRACK_ALBUM = 63,
} ID3Field;

/*
 * Takes a file path¸ a field to read and a pointer to copy the value of the
 * field into.
 *
 * This will dynamically allocate memory (call free on buffer when finished).
 */
bool get_ID3_field(const char* fpath, ID3Field field, char** buffer);

#endif /* _SP_ID3_ */