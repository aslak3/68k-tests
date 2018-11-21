AS = m68k-linux-gnu-as
LD = m68k-linux-gnu-ld
OBJCOPY = m68k-linux-gnu-objcopy
UPLOAD = $(HOME)/8bitcomputer/eepromprogrammer/upload/upload

BINS = romonly.bin romram.bin serialtest.bin

all: $(BINS)

%.o: %.s
	$(AS) $< -o $@

%.elf: %.o
	$(LD) -T linker.scr -nostdlib $< -o $@

%.bin: %.elf
	$(OBJCOPY) --pad-to 16384 -O binary $< $@

upload:
	$(UPLOAD) -s /dev/ttyUSB0 -f $(BIN)
	
clean:
	rm -f *.o *.elf *.bin

