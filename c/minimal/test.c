#define PORT_IO(port) (*(unsigned char *)(port))

#define LED 0x100001
#define BUZZER 0x100003

unsigned char tone = 50;
unsigned short delay;

const unsigned char led_on = 0xff;
const unsigned char led_off = 0x00;

void do_delay(void);

int main(void)
{
	unsigned char silence = 0;

	while(1)
 	{
		PORT_IO(LED) = led_on;
		do_delay();
		PORT_IO(LED) = led_off;
		do_delay();

		PORT_IO(BUZZER) = tone;
		do_delay();
		PORT_IO(BUZZER) = silence;
		
		tone += 10;
	}

	return 0;
}

void do_delay(void)
{
	for (delay = 0; delay < 0xffff; delay++)
		;
}
