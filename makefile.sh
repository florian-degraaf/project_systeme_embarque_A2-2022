#!bin/bash

rm .tmp
mkdir .tmp
echo Creation du dossier .tmp

avr-gcc -Os -DF_CPU=16000000L -mmcu=atmega2560 -c blink.c -o .tmp/blink.o
echo Creation du fichier objet

rm build
mkdir build
echo Creation du dossier build 

avr-gcc -Os -DF_CPU=16000000L -mmcu=atmega2560 blink.c -o build/blink.o.elf 2> /dev/null
echo Creation du fichier .elf 

avr-objcopy -O ihex -R .eeprom build/blink.o.elf build/blink.hex
echo Creation du fichier .hex 

avrdude -F -V -c arduino -p ATMEGA2560 -P /dev/ttyACM0 -b 115200 -U flash:w:build/blink.hex
echo Televersement du fichier .hex 
