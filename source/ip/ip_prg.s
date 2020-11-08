;****************************************************************
;	MARS MEGA-CD Boot Check Program
;					Initial program
;
;	Copyright SEGA ENTERPRISES,LTD. 1994
;				SEGA ENTERPRISES,LTD.
;				CS Hardware R&D Dept.
;						T.Okawa
;---------------------------------------------------------------;
;	Verion 1.0				7/4/1994
;****************************************************************


; include
	include	include\md.i		; Mega Drive Mapping
	include include\cdcmd.i		; Sub CPU commands

	list


;---------------------------------------------------------------;
;	Program start
;---------------------------------------------------------------;

_start:
	moveq #0,d0
	bsr cramaddr
	move.w #$f00,d0 ;blue
	move.w d0,$c00000

@test_init:	
	cmp.w	#FLG_ACTIVATE,status_2	; has the sp started yet?
	bne.b	@test_init
	
	move.w #CMD_LOADINTER,command_0 ;tell sub cpu to load the main program
	move.w #FLG_ACTIVATE,command_2  ;into word ram
	
@wait_process:
	cmp.w #CMD_LOADINTER,status_0 ; has the sub cpu processed the command yet?
	bne @wait_process
	clr.w command_2 ;if it has processed the command, clear the init flag
	
@wait_finish: ;wait for the command to finish
	cmp.w #RES_OK,status_2
	bne @wait_finish

	moveq #0,d0
	bsr cramaddr
	move.w #$fff,d0 ;white
	move.w d0,$c00000

	lea.l	word_ram,a0

	jmp	(a0)
	
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
	

;****************************************************************
;	end of file
;****************************************************************
