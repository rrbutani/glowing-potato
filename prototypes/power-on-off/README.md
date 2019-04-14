# Power On/Off Prototype

Quick test to see if we can combine a NAND Gate based latching power on/power off circuit with a GPIO pin from a microcontroller.

The latching NAND Gate based circuit is the one described on [this page](http://www.mosaic-industries.com/embedded-systems/microcontroller-projects/electronic-circuits/push-button-switch-turn-on/latching-toggle-power-switch) (the "Press ON - Hold OFF latching circuit" in figure 5).

The goal is to use a GPIO pin to force a power off. If we connect an output pin set to low to the capacitor feeding into the NAND gate, we should immediately power off. If this same pin is in a high-Z state, we _should_ (hopefully - this is the assumption being tested) allow the circuit to operate as normal.

GPIO26 doesn't have a reset state listed on the [ESP32 Pin List](https://www.bitsandparts.eu/documentation/484/esp32_chip_pin_list_en.pdf), which supposedly means it'll be in high-Z on reset (according to [this](https://esp32.com/viewtopic.php?t=1926)).

One big flaw in all this is that the circuit runs off unregulated power because it toggles the enable on the regulator instead of the enable pins on all the ICs (why it does this is a separate thing but the short version is that it seems like a safer way to ensure that we aren't drawing much current when powered off - an important thing when using LiPo cells). This means that we can't connect a GPIO pin to the circuit since doing so would expose the ESP32 to higher voltages than it's rated for (>4.2V for a single cell LiPo).

So we'll settle for not truly being able to turn off the device from the ESP32. This is going to result in a weird user interface where we'll expose a software shutdown option which, after performing the necessary software shutdown routines, instructs the user to power and hold the power button to _truly_ shutdown.

Or we can just go into a soft shutdown state (with a button press triggering a 'boot' up) and hope that the other components aren't drawing too much power and that UVLO will save us (now that we have a UVLO circuit this is something that we can actually maybe count on). Sidenote: UVLO should disengage once charging kicks in as we'd expect.

So now that I've written this, it's become apparent that writing this quick and dirty test would be a bad use of time. So, till next time!