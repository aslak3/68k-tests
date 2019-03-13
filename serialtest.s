		.align 2

		.equ CPLDLED, 0x100001

		.equ BASE2681, 0x200001
		.equ MR1A2681, BASE2681+0
		.equ MR2A2681, BASE2681+0
		.equ SRA2681, BASE2681+2
		.equ CSRA2681, BASE2681+2
		.equ BRGEXT2681, BASE2681+4
		.equ CRA2681, BASE2681+4
		.equ RHRA2681, BASE2681+6
		.equ THRA2681, BASE2681+6
		.equ IPCR2681, BASE2681+8
		.equ ACR2681, BASE2681+8
		.equ ISR2681, BASE2681+10
		.equ IMR2681, BASE2681+10
		.equ CTU2681, BASE2681+12
		.equ CRUR2681, BASE2681+12
		.equ CTL2681, BASE2681+14
		.equ CTLR2681, BASE2681+14
		.equ MR1B2681, BASE2681+16
		.equ MR2B2681, BASE2681+16
		.equ SRB2681, BASE2681+18
		.equ CSRB2681, BASE2681+18
		.equ TEST2681, BASE2681+20
		.equ CRB2681, BASE2681+20
		.equ RHRB2681, BASE2681+22
		.equ SCRATCH2681, BASE2681+25
		.equ IP2681, BASE2681+26
		.equ OPCR2681, BASE2681+26
		.equ STARTCOM2681, BASE2681+28
		.equ SETOPCOM2681, BASE2681+28
		.equ STOPCOM2681, BASE2681+30
		.equ RESETOPCOM2681, BASE2681+30

		.section .vectors, #alloc

resetsp:	.long 0x008000			| the initial sp
resetpc:	.long _start			| the initial pc

		.section .text

_start:		move.b #0b00010011,MR1A2681	| 8n
		move.b #0b00000111,MR2A2681	| one full stop bit
		move.b #0b10111011,CSRA2681	| 9600
		move.b #0b00000101,CRA2681	| enable rx and tx

		move.b #0x2a,%d0
		bsr putchar
		move.b #0x21,%d0
		bsr putchar

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

putchar:	btst.b #2,SRA2681
		beq putchar			| yes, look again
		move.b %d0,THRA2681		| put that byte
		rts

| get a string in a0

getstring:	bsr getchar
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

ramvectors:	.space 1024			| runtime vectors
input:		.space 256			| input buffer in ram
