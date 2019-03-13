CC = /usr/local/m68k/bin/m68k-elf-gcc
AS = /usr/local/m68k/bin/m68k-elf-as
LD = /usr/local/m68k/bin/m68k-elf-ld
OBJCOPY = /usr/local/m68k/bin/m68k-elf-objcopy
FLASHER = ../../../68k-monitor/tools/flasher

BIN = test.bin
OBJS = startup.o test.o

all: $(BIN)

%.o: %.c
	$(CC) -mcpu=68000 -Wall -g -O0 -c $< -o $@

%.o: %.s
	$(AS) -mcpu=68000 --fatal-warnings $< -o $@

test.elf: $(OBJS)
	$(CC) -mcpu=68000 -T linker.scr -ffreestanding -nostdlib -nostartfiles -static \
		$^ -lgcc -o $@

%.bin: %.elf
	$(OBJCOPY) -S -O binary $< $@.t
	dd if=$@.t of=$@ ibs=64 obs=64 conv=sync
	rm -f $@.t
	
flash:
	$(FLASHER) -s /dev/ttyS1 -f $(BIN)
	
clean:
	rm -f *.o *.elf *.bin

