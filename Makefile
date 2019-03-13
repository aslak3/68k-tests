AS = m68k-linux-gnu-as
LD = m68k-linux-gnu-ld
OBJCOPY = m68k-linux-gnu-objcopy
UPLOAD = $(HOME)/8bitcomputer/eepromprogrammer/upload/upload

BOARD = mini000

SINGLEBINS = romonly.bin romram.bin serialtest.bin flasherromonly.bin \
	flasherromram.bin
UPPERBINS = $(addsuffix -upper.bin, $(basename $(SINGLEBINS)))
LOWERBINS = $(addsuffix -lower.bin, $(basename $(SINGLEBINS)))

ifeq ($(BOARD),mini000)
BINS = $(SINGLEBINS) $(UPPERBINS) $(LOWERBINS)
else ifeq ($(BOARD),bb008)
BINS = $(SINGLEBINS)
endif

all: $(BINS)

%.o: %.s
	$(AS) $< -o $@

%.elf: %.o
	$(LD) -T linker-$(BOARD).scr -nostdlib $< -o $@

%.bin: %.elf
ifeq ($(BOARD),bb008)
	$(OBJCOPY) --pad-to 0x0e0800 -O binary $< $@
else ifeq ($(BOARD),mini000)
	$(OBJCOPY) --pad-to 0xf00800 -O binary $< $@
endif

%-upper.bin: %.bin
	$(OBJCOPY) --interleave=2 --byte=0 -I binary -O binary $< $@
%-lower.bin: %.bin
	$(OBJCOPY) --interleave=2 --byte=1 -I binary -O binary $< $@

upload:
	$(UPLOAD) -s /dev/ttyUSB0 -f $(BIN)
	
clean:
	rm -f *.o *.elf *.bin

