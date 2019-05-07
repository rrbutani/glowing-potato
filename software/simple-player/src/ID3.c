#include "ID3.h"
#include <stdbool.h>
#include <stdio.h>
#include <string.h>
#include "esp_log.h"

bool get_ID3_field(const char* fpath, ID3Field field, char** buffer) {
  char raw_field[31] = {0};

  FILE* file = fopen(fpath, "r");

  if (file == NULL) {
    return false;
  }

  if (fseek(file, -128, SEEK_END) != 0 ||
      fread(raw_field, sizeof(char), 3, file) == 0)
    goto err;

  if (strcmp(raw_field, "TAG") != 0) {
    ESP_LOGW("ID3", "File %s doesn't have ID3v1 fields.", fpath);
    goto err;
  }

  if (fseek(file, -128 + field, SEEK_END) != 0 ||
      fread(raw_field, sizeof(char), 30, file) == 0)
    goto err;

  fclose(file);
  return ((*buffer = strndup(raw_field, 30)) != NULL);

err:
  fclose(file);
  return false;
}