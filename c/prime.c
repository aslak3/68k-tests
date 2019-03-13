#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "include/serial.h"

int main(void)
{
	uint8_t buffer[100];
	int test, max;

	memset(buffer, 0, 100);

	serialinit();

	putstring((uint8_t *)"\r\nEnter the highest integer to test: ");
	getstring(buffer);
	putstring((uint8_t *)"\r\n");
	max = atoi((char *) buffer);

	if (max < 2)
	{
		putstring((uint8_t *) "Number must be greater then 1\r\n");
		return 1;
	}

	test = max;

	for (test = 2; test <= max; test++)
	{
		int check, flag = 0;

		for (check = 2; check <= test / 2; check++)
		{
			if (!(test % check))
			{
				flag = 1;
				break;
			}
		}

		if (flag == 0)
		{
			snprintf((char *) buffer, 100, "%d is a prime number.\r\n", test);
			putstring(buffer);
		}
	}

	return 0;
}
