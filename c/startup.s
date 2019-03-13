		.align 2

		movea.l #rom_data,%a0
		movea.l #data_start,%a1
		move.l #data_size,%d0
		beq skipdata			| handle size == 0

1:		move.b (%a0)+,(%a1)+
		subq.l #1,%d0
		bne 1b

skipdata:	movea.l #bss_start,%a0
		move.l #bss_size,%d0
		beq skipbss

1:		clr.b (%a0)+
		subq.l #1,%d0
		bne 1b

skipbss:	jsr main
		bra skipbss

