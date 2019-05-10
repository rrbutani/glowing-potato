#include "sd_card.h"
#include <assert.h>
#include <dirent.h>
#include <stdbool.h>
#include <stdint.h>
#include <string.h>
#include <sys/types.h>
#include <unistd.h>
#include "ID3.h"
#include "common_types.h"
#include "driver/sdmmc_host.h"
#include "esp_log.h"
#include "esp_vfs_fat.h"
#include "sdmmc_cmd.h"

#define TRACK_DIR "tracks"
#define ART_DIR "art"

#define AUDIO_EXT ".MP3"
#define IMAGE_EXT ".JPG"

static const char* TAG = "sd_card";
static bool initialized = false;
static const char* default_image = SD_MOUNT_PATH "/" ART_DIR
                                                 "/"
                                                 "default" IMAGE_EXT;

bool init_sd_card(void) {
  if (initialized) return true;

  ESP_LOGI(TAG, "Initializing SD Card");

  sdmmc_host_t host = SDMMC_HOST_DEFAULT();
  host.max_freq_khz = SDMMC_FREQ_HIGHSPEED;

  sdmmc_slot_config_t slot_config = SDMMC_SLOT_CONFIG_DEFAULT();

  gpio_set_pull_mode(15,
                     GPIO_PULLUP_ONLY);  // CMD, needed in 4- and 1- line modes
  gpio_set_pull_mode(2, GPIO_PULLUP_ONLY);  // D0, needed in 4- and 1-line modes
  gpio_set_pull_mode(4,

                     GPIO_PULLUP_ONLY);      // D1, needed in 4-line mode only
  gpio_set_pull_mode(12, GPIO_PULLUP_ONLY);  // D2, needed in 4-line mode only
  gpio_set_pull_mode(13,
                     GPIO_PULLUP_ONLY);  // D3, needed in 4- and 1-line modes

  esp_vfs_fat_mount_config_t mount_config = {.format_if_mount_failed = false,
                                             .max_files = 5,
                                             .allocation_unit_size = 16 * 1024};

  sdmmc_card_t* card;
  esp_err_t ret = esp_vfs_fat_sdmmc_mount(SD_MOUNT_PATH, &host, &slot_config,
                                          &mount_config, &card);

  if (ret != ESP_OK) {
    if (ret == ESP_FAIL) {
      ESP_LOGE(TAG, "Failed to mount the sd card's filesystem.");
    } else {
      ESP_LOGE(TAG, "Failed to initialize the sd card (%s).",
               esp_err_to_name(ret));
    }
    return false;
  }

  ESP_LOGI(TAG, "Successfully mounted SD Card!");
  sdmmc_card_print_info(stdout, card);

  return initialized = true;
}

bool populate_track_list(Track** list_ptr, uint16_t* track_count_ptr) {
  assert(initialized);

  Track* list;
  uint16_t track_count = 0;
  uint16_t allocated = 8;

  assert((list = (Track*)malloc(sizeof(Track) * allocated)) != NULL);

  DIR* tracks = opendir(SD_MOUNT_PATH "/" TRACK_DIR);
  if (tracks == NULL) {
    ESP_LOGW(TAG, "Unable to open '" SD_MOUNT_PATH "/" TRACK_DIR "'.");
    return false;
  }

  struct dirent* entry;
  while ((entry = readdir(tracks)) != NULL) {
    // Allocate more memory if we need it:
    if (allocated == track_count) {
      allocated += 8;
      assert((list = realloc(list, sizeof(Track) * allocated)) != NULL);
    }

    // Ignore directories for now:
    if (entry->d_type != DT_REG) {
      ESP_LOGI(TAG, "Skipping non-file entry: '%s'.", entry->d_name);
    }

    // Check that this is an audio file:
    char* ext;
    if ((ext = strrchr(entry->d_name, '.')) != NULL) {
      if ((strcmp(ext, AUDIO_EXT)) != 0) continue;
    }

    // Add a new entry:
    Track* t = &list[track_count];
    assert((t->name = strndup(entry->d_name, strlen(entry->d_name) -
                                                 strlen(AUDIO_EXT))) != NULL);

    assert((t->audio_fpath =
                malloc(sizeof(char) * (strlen(SD_MOUNT_PATH "/" TRACK_DIR "/") +
                                       strlen(entry->d_name) + 1))) != NULL);
    strcpy(t->audio_fpath, SD_MOUNT_PATH "/" TRACK_DIR "/");
    strcat(t->audio_fpath, entry->d_name);

    assert((t->art_fpath = malloc(sizeof(char) *
                                  (strlen(SD_MOUNT_PATH "/" ART_DIR "/") +
                                   strlen(t->name) + strlen(IMAGE_EXT) + 1))) !=
           NULL);
    strcpy(t->art_fpath, SD_MOUNT_PATH "/" ART_DIR "/");
    strcat(t->art_fpath, t->name);
    strcat(t->art_fpath, IMAGE_EXT);

    // Check if the corresponding album art actually exists:
    if (access(t->art_fpath, F_OK) != 0) {
      ESP_LOGW(TAG, "No album art for: '%s'", t->name);
      free(t->art_fpath);
      t->art_fpath = (char*)default_image;
    }

    char* buffer;
    if (get_ID3_field(t->audio_fpath, TRACK_TITLE, &buffer)) {
      ESP_LOGI(TAG, "Got ID3; %s -> %s\n", t->name, buffer);
      free(t->name);
      t->name = buffer;
      get_ID3_field(t->audio_fpath, TRACK_ARTIST, &t->artist);
    }

    track_count++;
  }

  closedir(tracks);

  assert((list = realloc(list, sizeof(Track) * track_count)) != NULL ||
         track_count == 0);
  *list_ptr = list;
  *track_count_ptr = track_count;
  return true;
}