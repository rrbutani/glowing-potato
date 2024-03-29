## V0: Misc things
 - We're going to use 3x1mm disc magnets. These should be thin enough to put underneath the screen.
 - Here are the numbers on the device thickness:
     + We've got our 1.2mm main PCB in the middle. On the top of the device we've got:
         * the display (2.8mm thick); once we add the magnets and the padding (VHB RP45, 1.1mm), we'll get up to 4mm
         * and on the bottom:
             - the buttons (0.56mm)
             - the 3D printer interfacers (0.24mm)
             - the clickwheel PCB (1.2mm)
             - 1/16th inch acrylic (1.5875mm)
             - vinyl (0.4mm, hopefully)
             - for a total of: ~4mm!
         * If all goes according to plan, we should only go 4mm above the top of the top PCB and the 3D printed top half of the case should be flush with the screen and the top of the clickwheel.
     + On the bottom (below the main PCB) we've got a bunch of components. The notable ones are the headphone jack connector and the XH battery connector. The latter is the tallest of the components and clocks in at 6.1mm (a little disappointing since it's the tallest component by a fair margin, but it's fine - it'll give us more headroom for the battery).
         * The bottom casing will need to extend a little bit past this; hopefully no more than 0.9mm or so.
     + This gives us a total thickness of 0.9mm + 6.1mm + 1.2mm + 4mm or 12.2mm which isn't too shabby.

## Breakouts
 - ESP32 + Antenna + CP2102N + USB C Port
 - TPS63001 + Battery Connector + Charge IC + 1.8V Regulator
 - Display Breakout (FPC Connector)
