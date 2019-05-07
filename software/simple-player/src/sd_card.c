#include "sd_card.h"
#include <stdbool.h>
#include <stdint.h>
#include "common_types.h"
#include "driver/sdmmc_host.h"
#include "esp_vfs_fat.h"
#include "sdmmc_cmd.h"

static const char* TAG = "sd_card";
static bool initialized = false;

bool init_sd_card(void) {
  if (initialized) return true;

  ESP_LOGI(TAG, "Initializing SD Card");

  sdmmc_host_t host = SDMMC_HOST_DEFAULT();
  host.max_freq_khz = SDMMC_FREQ_HIGHSPEED;

  sdmmc_slot_config_t slot_config = SDMMC_SLOT_CONFIG_DEFAULT();

  gpio_set_pull_mode(15,
                     GPIO_PULLUP_ONLY);  // CMD, needed in 4- and 1- line modes
  gpio_set_pull_mode(2, GPIO_PULLUP_ONLY);  // D0, needed in 4- and 1-line modes
  gpio_set_pull_mode(4, GPIO_PULLUP_ONLY);  // D1, needed in 4-line mode only
  gpio_set_pull_mode(12, GPIO_PULLUP_ONLY);  // D2, needed in 4-line mode only
  gpio_set_pull_mode(13,
                     GPIO_PULLUP_ONLY);  // D3, needed in 4- and 1-line modes

  esp_vfs_fat_mount_config_t mount_config = {.format_if_mount_failed = false,
                                             .max_files = 5,
                                             .allocation_unit_size = 16 * 1024};

  sdmmc_card_t* card;
  esp_err_t ret = esp_vfs_fat_sdmmc_mount("/sdcard", &host, &slot_config,
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

bool populate_track_list(Track** list, uint16_t* track_count) { return true; }