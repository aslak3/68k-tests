#include <stdint.h>
#include <stdbool.h>

#include "include/hardware.h"
#include "include/serial.h"

void serialinit(void)
{
	PORT_IO(MR1B2681) = 0b00010011;
	PORT_IO(MR2B2681) = 0b00000111;	
	PORT_IO(CSRB2681) = 0b10111011;
	PORT_IO(CRB2681) = 0b00000101;
}

void putstring(uint8_t *string)
{
	for (uint8_t *ptr = string; *ptr; ptr++)
	{
		putbyte(*ptr);
	}
}

void putbyte(uint8_t byte)
{
	while(!(PORT_IO(SRB2681) & 0b00000100));
	PORT_IO(THRB2681) = byte;
}

void getstring(uint8_t *string)
{
	uint8_t *ptr = string;
	bool done = false;

	while (!done)
	{
		uint8_t byte = getbyte();
		putbyte(byte);
		if (byte == '\r')
			done = true;
		else if (byte == '\n')
			done = 1;
		else
			*ptr++ = byte;
		*ptr = '\0';
	}
}	

uint8_t getbyte(void)
{
	while (!(PORT_IO(SRB2681) & 0b00000001));
	return PORT_IO(RHRB2681);
}
