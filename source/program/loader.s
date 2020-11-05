;****************************************************************
;	Sega CD Freeloader: Program loader
;
;	Copyright Nathan Misner
;
;	Copies the main program from Word RAM to Work RAM
;---------------------------------------------------------------;
;						Created 11/1/20
;****************************************************************

;include
	include include\md.i		;hw mapping
	include include\m_const.i	;hw constants
	include include\mdwork.i	;wram locations
	
entry:
	moveq #0,d0
	bsr cramaddr
	move.w #$0f0,d0 ;green
	move.w d0,$c00000

	lea program_start(pc),a0
	lea workbase,a1
	;number of longwords to copy (copying 4 words per loop)
	move.w #((program_end-program_start)/16)+1,d0
copy_loop:
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	move.l (a0)+,(a1)+
	dbra d0,copy_loop
	
	;done copying so jump to wram
	lea workbase,a0
	jmp (a0)
	
;---------------------------------------------------------------;
;		Sets CRAM to write to given address
;
; IN	d0.w	Address to write to in CRAM
;---------------------------------------------------------------;

cramaddr:
	movem.w d0,-(a7) ;save address
	and.w #$3fff,d0 ;mask off last two bits
	or.w #$c000,d0 ;add cram write command
	move.w d0,$c00004 ;write first word to vdp
	
	movem.w (a7)+,d0 ;retrieve address
	rol.w #2,d0 ;last 2 bits -> first 2 bits
	and.w #3,d0 ;mask off everything but first 2 bits
	move.w d0,$c00004 ;write second word to vdp
	rts
	
program_start:
	incbin program\program.bin
program_end
