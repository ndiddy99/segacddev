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

	list


;---------------------------------------------------------------;
;	Program start
;---------------------------------------------------------------;

_start:
		moveq #0,d0
		bsr cramaddr
		move.w #$f00,d0 ;blue
		move.w d0,$c00000

@test_load:	
		cmp.w	#'ok',status_0	; SP loading end ?
		bne.b	@test_load
		
@test_1m:
		btst.b	#MODE,_memory ;wait until word ram is set to 1M mode
		beq.b	@test_1m
		
@test_access:
		btst.b	#RET,_memory ;wait until the sub cpu stops messing with ram
		beq.b	@test_access

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
