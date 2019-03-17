#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(void)
{
	char buffer[100];
	int test, max;

	memset(buffer, 0, 100);

	while(1)
	{
		printf("\r\nEnter the highest integer to test: ");
		fgets(buffer, 100, stdin);
		max = atoi(buffer);

		if (max < 2)
		{
			printf("Number must be greater then 1\r\n");
			continue;
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
				printf("%d is a prime number.\r\n", test);
		}
	}

	return 0;
}
