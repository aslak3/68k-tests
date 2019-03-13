		.align	2

		.equ CPLDLED, 0x100000

		.section .vectors, #alloc

resetsp:	.long 0x008000			| not using stack yet
resetpc:	.long _start			| the initial pc

		.section .text

_start:		move.b #0xff,%d0

next:		move.b %d0,CPLDLED

		move.w #0x8000,%d1		| setup delay
delay:		dbra %d1,delay			| loop on the spot

		not.b %d0

		bra next			| to the top!
