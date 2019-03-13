#include <stdint.h>
#include <stdlib.h>

#include "include/hardware.h"

int main(void)
{
	while (1)
	{
		PORT_IO(BUZZER) = atoi("50");
		for (uint16_t d = 0; d < 0xffff; d++)
			;
		PORT_IO(BUZZER) = atoi("100");
		for (uint16_t d = 0; d < 0xffff; d++)
			;
	}

	while(1);

	return 0;
}
