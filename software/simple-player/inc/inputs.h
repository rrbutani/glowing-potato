/*
 * Configures ISRs for GPIO input pins (probably only useful for buttons).
 *
 * This module is somewhat opinionated: for example, it registers positive edge
 * ISRs, assumes positive logic inputs (it enables the internal pull downs) and
 * has a strict convention it follows for what args the ISR handler is passed
 * in. This module has no configuration options.
 *
 * (TODO) Eventually this will debounce inputs as well, if so configured.
 */

#ifndef _SP_INPUTS_
#define _SP_INPUTS_

#include <stdint.h>

/*
 * Takes a handler and all the pins you wish to trigger the handler for.
 *
 * On the positive edge (rising edge) of a signal on one of the specified pins,
 * the handler will be called with the pin number of said pin.
 *
 * The pin numbers should be passed in as ints (varargs).
 */
void register_ISRs(void (*handler)(void* arg), uint8_t num_pins, ...);

#endif /* _SP_INPUTS_ */