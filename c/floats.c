#include <stdio.h>
#include <string.h>
#include <stdint.h>

#include "include/hardware.h"
#include "include/serial.h"

//uint8_t greeting[] = "What is your name? ";

int main(void)
{
	char buffer[256];
	float f = 1.0;

	serialinit();

	while (1)
	{
		snprintf(buffer, 256, "float %f\r\n", f);
		f *= 1.001;
		putstring((uint8_t *) buffer);
	}

	return 0;
}
