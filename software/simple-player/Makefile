# A project Makefile for a simple mp3 player.

PROJECT_NAME := simple-player

SW_DIR = ../
include ../paths.vars

# These are paths of component folders in contrib to include in the project:
EXTERNAL_DEPENDENCIES += esp32-tft/components

EXTRA_COMPONENT_DIRS += $(realpath .)
EXTRA_COMPONENT_DIRS += $(SHARED_COMPONENTS_DIR)
EXTRA_COMPONENT_DIRS += $(addprefix $(CONTRIB_DIR)/,$(EXTERNAL_DEPENDENCIES))

include $(IDF_PATH)/make/project.mk
