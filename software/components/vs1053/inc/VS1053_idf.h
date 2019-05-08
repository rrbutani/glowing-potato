//used for creating an abstraction of the VS1053 in cdo

#ifndef VS1053_PORT_VS1053_IDF_H
#define VS1053_PORT_VS1053_IDF_H


#include <cstdint.h>
#include <stdlib.h>
#include <string.h>
#include "freertos/FreeRTOS.h"
#include "esp_system.h"
#include "driver/spi_master.h"
#include "soc/gpio_struct.h"
#include "driver/gpio.h"
#include "spi_master_lobo.h"


#define chunk_size = 32;
#define SCI_MODE = 0x0;
#define SCI_STATUS = 0x1;
#define SCI_BASS = 0x2;
#define SCI_CLOCKF = 0x3;
#define SCI_AUDATA = 0x5;
#define SCI_WRAM = 0x6;
#define SCI_WRAMADDR = 0x7;
#define SCI_AIADDR = 0xA;
#define SCI_VOL = 0xB;
#define SCI_AICTRL0 = 0xC;
#define SCI_AICTRL1 = 0xD;
#define SCI_num_registers = 0xF;
#define SM_SDINEW = 11;
#define SM_RESET = 2;
#define SM_CANCEL = 3;
#define SM_TESTS = 5;
#define SM_LINE1 = 14;





struct VS1053 {
    uint8_t cs_pin;
    uint8_t dcs_pin;
    uint8_t dreq_pin;
    uint8_t curvol;
    uint8_t chunk_size;
    //SCI register
    uint8_t SCI_MODE;
    uint8_t SCI_STATUS;
    uint8_t SCI_BASS;
    uint8_t SCI_CLOCKF;
    uint8_t SCI_AUDATA;
    uint8_t SCI_WRAM;
    uint8_t SCI_WRAMADDR;
    uint8_t SCI_AIADDR;
    uint8_t SCI_VOL;
    uint8_t SCI_AICTRL0;
    uint8_t SCI_AICTRL1;
    uint8_t SCI_num_registers;
    // SCI_MODE bits
    uint8_t SM_SDINEW;           // Bitnumber in SCI_MODE always on
    uint8_t SM_RESET;             // Bitnumber in SCI_MODE soft reset
    uint8_t SM_CANCEL;            // Bitnumber in SCI_MODE cancel song
    uint8_t SM_TESTS;             // Bitnumber in SCI_MODE for tests
    uint8_t SM_LINE1;            // Bitnumber in SCI_MODE for Line input
    spi_lobo_config_t d_spi_config;                // SPI settings for this slave
    spi_lobo_config_t c_spi_config;
    uint8_t endFillByte;                    // Byte to send when stopping song
};

#endif  /*VS1053*/