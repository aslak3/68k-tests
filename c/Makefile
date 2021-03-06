CC = m68k-elf-gcc
AS = m68k-elf-as
LD = m68k-elf-ld
OBJCOPY = m68k-elf-objcopy
FLASHER = ../../68k-monitor/tools/flasher

COMMON_OBJS = startup.o serial.o fileio.o

BINS = prime.bin easter.bin floats.bin tiny.bin mandelbrot.bin

all: $(BINS)

%.o: %.c
	$(CC) -mcpu=68000 -ffreestanding -g -Wall -O2 -c $< -o $@

%.o: %.s
	$(AS) -mcpu=68000 --fatal-warnings $< -o $@

prime.elf: $(COMMON_OBJS) prime.o
easter.elf: $(COMMON_OBJS) easter.o
floats.elf: $(COMMON_OBJS) floats.o
tiny.elf: $(COMMON_OBJS) tiny.o
mandelbrot.elf: $(COMMON_OBJS) mandelbrot.o

prime.elf easter.elf floats.elf tiny.elf mandelbrot.elf:
	$(CC) -mcpu=68000 -T linker.scr -ffreestanding -nostdlib -nostartfiles \
		$^ -lc -lgcc -o $@

prime.bin: prime.elf
easter.bin: easter.elf
floats.bin: floats.elf
tiny.bin: tiny.elf
mandelbrot.bin: mandelbrot.elf

prime.bin easter.bin floats.bin tiny.bin mandelbrot.bin:
	$(OBJCOPY) -S -O binary $< $@.t
	dd if=$@.t of=$@ ibs=64 obs=64 conv=sync
	rm -f $@.t

flash:
	$(FLASHER) -s /dev/ttyS1 -f $(BIN)
	
clean:
	rm -f *.o *.elf *.bin

