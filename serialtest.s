		.align 2

		.equ LATCH, 0x20000

		.equ BASE2681, 0x40000
		.equ MR1A2681, BASE2681+0
		.equ MR2A2681, BASE2681+0
		.equ SRA2681, BASE2681+1
		.equ CSRA2681, BASE2681+1
		.equ BRGEXT2681, BASE2681+2
		.equ CRA2681, BASE2681+2
		.equ RHRA2681, BASE2681+3
		.equ THRA2681, BASE2681+3
		.equ IPCR2681, BASE2681+4
		.equ ACR2681, BASE2681+4
		.equ ISR2681, BASE2681+5
		.equ IMR2681, BASE2681+5
		.equ CTU2681, BASE2681+6
		.equ CRUR2681, BASE2681+6
		.equ CTL2681, BASE2681+7
		.equ CTLR2681, BASE2681+7
		.equ MR1B2681, BASE2681+8
		.equ MR2B2681, BASE2681+8
		.equ SRB2681, BASE2681+9
		.equ CSRB2681, BASE2681+9
		.equ TEST2681, BASE2681+10
		.equ CRB2681, BASE2681+10
		.equ RHRB2681, BASE2681+11
		.equ SCRATCH2681, BASE2681+12
		.equ IP2681, BASE2681+13
		.equ OPCR2681, BASE2681+13
		.equ STARTCOM2681, BASE2681+14
		.equ SETOPCOM2681, BASE2681+14
		.equ STOPCOM2681, BASE2681+15
		.equ RESETOPCOM, BASE2681+15

		.section vectors, #alloc

resetsp:	.long 0xe0fff			| the initial sp
resetpc:	.long _start			| the initial pc

		.section .text

_start:		move.b #0b00010011,MR1A2681	| 8n
		move.b #0b00000111,MR2A2681	| one full stop bit
		move.b #0b10111011,CSRA2681	| 9600
		move.b #0b00000101,CRA2681	| enable rx and tx

mainloop:	movea.l #entersome,%a0		| get start of message
		bsr putstring			| output it
		movea.l #input,%a0		| input buffer
		bsr getstring			| ask for a string with 0
		movea.l #youtyped,%a0		| ...
		bsr putstring			| ...
		movea.l #input,%a0		| ...
		bsr putstring			| ...

		bra mainloop

| put the string in a0

putstring:	move.b (%a0)+,%d0		| get the byte to put
		beq putstringout		| end of message, done
		bsr putchar			| output the char in d0
		bra putstring			| back for more
putstringout:	rts

| put the char in d0

putchar:	btst.b #2,SRA2681		| busy sending last char?
		beq putchar			| yes, look again
		move.b %d0,THRA2681		| put that byte
		rts

| get a string in a0

getstring:	bsr getchar
		move.b %d0,LATCH		| for fun, put byte on leds
		bsr putchar			| echo it
		cmpi.b #0x0a,%d0		| lf?
		beq getstringout		| match, done
		cmpi.b #0x0d,%d0		| cr?
		beq getstringout		| match, done
		move.b %d0,(%a0)+		| save it to the string
		bra getstring			| next char
getstringout:	move.b #0,(%a0)			| add a null
		rts

| get a char in d0

getchar:	btst.b #0,SRA2681		| chars?
		beq getchar			| no chars yet
		move.b RHRA2681,%d0		| get it in d0
		rts

		.section .rodata

entersome:	.asciz "\r\n\r\nEnter some text: "
youtyped:	.asciz "\r\nYou typed: "

		.section .bss

input:		.space 256			| input buffer in ram
