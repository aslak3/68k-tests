#include <stdio.h>
#include <string.h>
#include <stdint.h>

int main(void)
{
	char buffer[256];
	float f = 1.0;

	while (1)
	{
		printf(buffer, 256, "float %f\r\n", f);
		f *= 1.001;
	}

	return 0;
}
