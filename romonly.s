		.align	2

		.equ LATCH, 0x20000

		.section vectors, #alloc

resetsp:	.long 0xe0fff			| not using stack yet
resetpc:	.long _start			| the initial pc

		.section .text

_start:		movea.l #ledstart,%a0		| get start address in a0
		move.w #ledend-ledstart-1,%d0	| set the length (b) in d0

next:		move.b (%a0)+,LATCH		| move byte to LATCH

		move.w #0x8000,%d1		| setup delay
delay:		dbra %d1,delay			| loop on the spot

		dbra %d0,next			| back for more

		bra _start			| to the top!

		.section .rodata

ledstart:	.byte 0b00000001
		.byte 0b00000010
		.byte 0b00000100
		.byte 0b00001000
		.byte 0b00010000
		.byte 0b00100000
		.byte 0b01000000
		.byte 0b10000000
		.byte 0b01000000
		.byte 0b00100000
		.byte 0b00010000
		.byte 0b00001000
		.byte 0b00000100
		.byte 0b00000010
		.byte 0b00000001
		.byte 0b00000010
		.byte 0b00000100
		.byte 0b00001000
		.byte 0b00010000
		.byte 0b00100000
		.byte 0b01000000
		.byte 0b10000000
		.byte 0b01000000
		.byte 0b00100000
		.byte 0b00010000
		.byte 0b00001000
		.byte 0b00000100
		.byte 0b00000010
		.byte 0b00000001
		.byte 0b00000011
		.byte 0b00000111
		.byte 0b00001111
		.byte 0b00011111
		.byte 0b00111111
		.byte 0b01111111
		.byte 0b11111111
		.byte 0b11111111
		.byte 0b00000000
		.byte 0b11111111
		.byte 0b00000000
		.byte 0b11111111
		.byte 0b00000000
		.byte 0b11111111
		.byte 0b00000000
		.byte 0b11111111
		.byte 0b00000000
		.byte 0b11111111
		.byte 0b00000000
		.byte 0b11111111
		.byte 0b11111110
		.byte 0b11111100
		.byte 0b11111000
		.byte 0b11110000
		.byte 0b11100000
		.byte 0b11000000
		.byte 0b10000000
		.byte 0b00000000
		.byte 0b10000000
		.byte 0b11000000
		.byte 0b11100000
		.byte 0b11110000
		.byte 0b01111000
		.byte 0b00111100
		.byte 0b00011110
		.byte 0b00001111
		.byte 0b10000111
		.byte 0b11000011
		.byte 0b11100001
		.byte 0b11110000
		.byte 0b01111000
		.byte 0b00111100
		.byte 0b00011110
		.byte 0b00001111
		.byte 0b10000111
		.byte 0b11000011
		.byte 0b11100001
		.byte 0b11110000
		.byte 0b01111000
		.byte 0b00111100
		.byte 0b00011110
		.byte 0b00001111
		.byte 0b00000111
		.byte 0b00000011
		.byte 0b00000001
		.byte 0b00000000
ledend:
