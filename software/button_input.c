/* GPIO Example

   This example code is in the Public Domain (or CC0 licensed, at your option.)

   Unless required by applicable law or agreed to in writing, this
   software is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
   CONDITIONS OF ANY KIND, either express or implied.
*/
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"
#include "freertos/queue.h"
#include "driver/gpio.h"

/**
 * inputs are 
 * GPIO 37 = up button 
 * GPIO 10 = down button
 * GPIO 36 = left button
 * GPIO 25 = right button
 * GPIO 38 = center button
 */

enum in{
    up,
    down,
    left,
    right,
    center,
    song_end
}inputs;

#define GPIO_INPUT_IO_0 37
#define GPIO_INPUT_IO_1 10
#define GPIO_INPUT_IO_2 36
#define GPIO_INPUT_IO_3 25
#define GPIO_INPUT_IO_4 38
#define GPIO_INPUT_PIN_SEL ((1ULL<<GPIO_INPUT_IO_0) | (1ULL<<GPIO_INPUT_IO_1) | (1ULL<<GPIO_INPUT_IO_2) | (1ULL<<GPIO_INPUT_IO_3) | (1ULL<<GPIO_INPUT_IO_4));

#define ESP_INTR_FLAG_DEFAULT 0

static xQueueHandle gpio_evt_queue = NULL;

static void IRAM_ATTR gpio_isr_handler(void* arg)
{
    enum in button_num = (enum in) arg;
    xQueueSendFromISR(gpio_evt_queue, &button_num, NULL);   //put into queue 
}

#define track_count 20

uint8_t changeState = 0;

static void gpio_task_example(void* arg)
{
    enum in io_num;
    for(;;) {
        if(xQueueReceive(gpio_evt_queue, &io_num, portMAX_DELAY)) {
            //depending on what state is and what button was pressed, may need to change state 
            switch(state){
                case menu: 
                if(io_num == up){
                    data.menu.idx = (data.memu.idx - 1) % track_count;
                    //draw_menu - for lcd
                } else if(io_num == down){
                    data.menu.idx = (data.menu.idx + 1) % track_count;
                    //draw_menu - for lcd
                } else if(io_num == right){
                    //draw_playing(idx, true) - for lcd
                    data.play.play_pause = 1;
                    changeState = 1;
                    //playing(idx, track, data.play.play_pause) - for VS1053
                } else if(io_num == left | io_num == center){
                    //draw_menu(idx) - for lcd
                }
                break;

                case playing:
                if(io_num == center){
                    data.play.play_pause = (!data.play.play_pause);
                    //draw_playing(idx, data.play.play_pause) - for lcd
                    //playing(idx, track, data.play.play_pause) - for VS1053
                } else if(io_num == left){
                    //end_song() - for VS1053
                    //draw_menu - for lcd
                    changeState = 1;
                } else if(io_num == song_end){
                    //draw_menu - for lcd
                    changeState = 1;
                } else if(io_num == up | io_num == down | io_num == right){
                    //playing(idx, track, data.play.play_pause) - for VS1053
                    //don't think we have to draw screen again? 
                }
                breakl
            }
            if(changeState){
                if(state == menu){
                    state = playing;
                } else{
                    state = menu;
                }
            }
            //printf("GPIO[%d] intr, val: %d\n", io_num, gpio_get_level(io_num));
        }
    }
}

static state;
static state_data;

union data{
    struct menu{
        int32_t idx;
    }menu;
    struct play{
        int32_t idx;
        bool play_pause;    //1 for playing, 0 for pause
    }play;
}data;

enum state_machine{
    menu,
    playing
}state;

void app_main()
{   
    gpio_config_t io_conf;
    io_conf.intr_type = GPIO_PIN_POSEDGE;
    io_conf.mode = GPIO_MODE_INPUT;
    io_conf.pin_bit_mask = GPIO_INPUT_PIN_SEL;
    io_conf.pull_down_en = 0;
    io_conf.pull_up_en = 0; 
    gpio_config(&io_conf);      //configure gpio with settings 

    //interrupt of rising edge
    io_conf.intr_type = GPIO_PIN_INTR_POSEDGE;          //should this be GPIO_PIN_POSEDGE???

    //create a queue to handle gpio event from isr
    gpio_evt_queue = xQueueCreate(10, sizeof(uint32_t));    //creates a queue of 10 uint32_t variables
    //start gpio task

    xTaskCreate(gpio_task_example, "gpio_task_example", 2048, NULL, 10, NULL);

    //install gpio isr handler service, allows per pin gpio interrupt handlers 
    gpio_install_isr_service(ESP_INTR_FLAG_DEFAULT);
    //hook isr handler for specific gpio pin
    gpio_isr_handler_add(GPIO_INPUT_IO_0, gpio_isr_handler, (void*) up);
    gpio_isr_handler_add(GPIO_INPUT_IO_1, gpio_isr_handler, (void*) down);
    gpio_isr_handler_add(GPIO_INPUT_IO_2, gpio_isr_handler, (void*) left);
    gpio_isr_handler_add(GPIO_INPUT_IO_3, gpio_isr_handler, (void*) right);
    gpio_isr_handler_add(GPIO_INPUT_IO_4, gpio_isr_handler, (void*) center);

    while(1) {
        vTaskDelay(1000 / portTICK_RATE_MS);        //just to slow it down
    }
}
