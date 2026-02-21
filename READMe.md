# STM32 Blue Pill Blink (Clone Bypass)

This project contains the basic heartbeat blink code for an STM32F103C8T6 (Blue Pill). 

**Note:** The microcontroller on this board is a clone/counterfeit chip. The official STM32CubeIDE debugger will refuse to upload code to it and will throw a `Could not verify ST device!` error.

To bypass this, we compile the code in STM32CubeIDE, but flash it directly via the terminal using OpenOCD. 
You can run the included `./flash32.sh` script, or use the following command:

`openocd -f interface/stlink.cfg -c "set CPUTAPID 0x2ba01477" -f target/stm32f1x.cfg -c "reset_config none" -c 'program Debug/"Blue Pill Blink.elf" verify reset exit'`

### Command Breakdown:
* `openocd`:(Open On-Chip Debugger) The program that talks to the hardware. [At its core, it is a free, open-source software program that acts as the ultimate translator between your computer and your microcontroller hardware.
]
* `-f interface/stlink.cfg`: Tells OpenOCD we are using an ST-Link V2 USB dongle.
* `-c "set CPUTAPID 0x2ba01477"`: **The clone bypass password.** This forces OpenOCD to accept the clone's unrecognized hardware ID instead of rejecting it.
* `-f target/stm32f1x.cfg`: Tells OpenOCD we are targeting an STM32F1 series chip.
* `-c "reset_config none"`: Prevents the ST-Link from trying to use a physical reset wire (which is often missing or broken on cheap ST-Link clones), relying on software resets instead.
* `-c 'program ... verify reset exit'`: The actual action. It pushes the compiled `.elf` file into the flash memory, verifies it was written correctly without corruption, reboots the chip so the code starts running immediately, and safely closes the connection.
