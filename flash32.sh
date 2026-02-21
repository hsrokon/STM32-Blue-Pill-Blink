#!/bin/bash
# Custom flash script to bypass the STM32 clone locks

echo "Flashing the Blue Pill..."

openocd -f interface/stlink.cfg \
	-c "set CPUTAPID 0x2ba01477" \
	-f target/stm32f1x.cfg \
	-c "reset_config none" \
	-c 'program Debug/"Blue Pill Blink.elf" verify reset exit'
