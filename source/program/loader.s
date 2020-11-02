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
	
program_start:
	incbin program\program.bin
program_end
