		.align	2

		.equ CPLDLED, 0x100000

		.section .vectors, #alloc

resetsp:	.long 0x008000			| not using stack yet
resetpc:	.long _start			| the initial pc

		.section .text

_start:		move.b #0xff,%d0
		move.b #1,delaycount		| setup delay loop count

next:		move.b %d0,CPLDLED		| switch the LED on or off

		bsr delay			| do the delay sub

		add.b #1,delaycount		| inc the delaycount
		and.b #0x3f,delaycount		| truncate it to 0-63

		not.b %d0			| flip

		bra next			| to the top!

delay:		move.w #0,%d2			| clear top byte
		move.b delaycount,%d2		| get loop counter

outterdelay:	move.w #0x8000,%d1		| setup delay
innerdelay:	dbra %d1,innerdelay		| loop on the spot
		dbra %d2,outterdelay

		rts

		.section .bss

delaycount:	.space 1			| delay variable
