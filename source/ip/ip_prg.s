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
		cmp.w	#'ok',status_0	; SP loading end ?
		bne.b	_start
@test_1m:
		btst.b	#MODE,_memory ;wait until word ram is set to 1M mode
		beq.b	@test_1m
@test_access:
		btst.b	#RET,_memory ;wait until the sub cpu stops messing with ram
		beq.b	@test_access

		lea.l	word_ram,a0

		jmp	(a0)

;****************************************************************
;	end of file
;****************************************************************
