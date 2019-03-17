#include <stdio.h>
#include <stdint.h>

#include "include/serial.h"

size_t uart_write(FILE* instance, const char *bp, size_t n);
size_t uart_read(FILE* instance, char *bp, size_t n);

const struct File_methods input_methods = { NULL, uart_read };
const struct File_methods output_methods = { uart_write, NULL };
const struct File_methods err_methods = { uart_write, NULL };

struct File stdin_data = { &input_methods };
struct File stdout_data = { &output_methods };
struct File stderr_data = { &output_methods };

FILE* const stdin = &stdin_data;
FILE* const stdout = &stdout_data;
FILE* const stderr = &stderr_data;

size_t uart_write(FILE *instance, const char *bp, size_t n)
{
	for (size_t c = 0; c < n; c++)
	{
		putbyte((uint8_t) bp[c]);
	}
	return n;
}

size_t uart_read(FILE* instance, char *bp, size_t n)
{
	for (size_t c = 0; c < n; c++)
	{
		bp[c] = (char) getbyte();
	}
	return n;
}
