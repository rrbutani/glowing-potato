/*
 * Configures ISRs for GPIO input pins (probably only useful for buttons).
 *
 * This module is somewhat opinionated: for example, it registers positive edge
 * ISRs, assumes positive logic inputs (it enables the internal pull downs) and
 * has a strict convention it follows for what args the ISR handler is passed
 * in. This module has no configuration options.
 *
 * This will also debounce inputs as well, if so configured (menuconfig).
 */

#ifndef _SP_INPUTS_
#define _SP_INPUTS_

#if defined(__cplusplus)
extern "C" {
#endif

/*
 * Takes a handler and all the pins you wish to trigger the handler for.
 *
 * On the positive edge (rising edge) of a signal on one of the specified pins,
 * the handler will be called with the pin number of said pin.
 *
 * The pin numbers should be passed in as ints (varargs).
 */
void register_ISRs(void (*handler)(void* pin_num), int num_pins, ...);

#if defined(__cplusplus)
}
#endif

#endif /* _SP_INPUTS_ */