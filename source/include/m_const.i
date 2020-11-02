;****************************************************************
;	MARS MEGA-CD Boot Check Program
;					Mega Drive Constants and Macro
;	Copyright SEGA ENTERPRISES,LTD. 1994
;				SEGA ENTERPRISES,LTD.
;				CS Hardware R&D Dept.
;						T.Okawa
;---------------------------------------------------------------;
;
;****************************************************************


;---------------------------------------------------------------;
;	Cosntants
;---------------------------------------------------------------;
RTE_CODE	equ	$4e73	; Return code
JMP_CODE	equ	$4ef9	; Jump code


;---------------------------------------------------------------;
;	VRAM assign
;---------------------------------------------------------------;

SYSTEM_AREA	equ	$0020	; ÉÅÉCÉìâÊñ 
ASCII_AREA	equ	$0400	; Ç`ÇrÇbÇhÇhÅiÇWÇwÇWÅj (Length $0c00)
SCR_A_TBL	equ	$2000	; Scroll A table base address
WINDOW_BASE	equ	$2000	; Window base address
SCR_B_TBL	equ	$4000	; Scroll B table base address
SPR_BASE	equ	$4000	; Sprite table base address
BGCOLOR		equ	$0000	; Back ground color
HSCR_TBL	equ	$6000	; H scroll table base address


;---------------------------------------------------------------;
;	Wait	xx
;		xx = wait time (unit 1/60sec)
;---------------------------------------------------------------;

wait:		macro xx
		clr.w	w_counter(a6)
	@l0:
		cmp.w	#xx,w_counter(a6)
		bcs.b	@10
		endm


;---------------------------------------------------------------;
;	complete
;---------------------------------------------------------------;

complete	macro
		move	#0,ccr
		endm


;---------------------------------------------------------------;
;	error
;---------------------------------------------------------------;

error		macro
		move	#1,ccr
		endm


;---------------------------------------------------------------;
;	call	xx,yy
;		xx = nz,z,nc,c
;		yy = jump address
;---------------------------------------------------------------;

call		macro	xx,yy
		if	strcmp("xx","nz")
			beq.b	@jamp\@
		endif
		if	strcmp("xx","z")
			bne.b	@jamp\@
		endif
		if	strcmp("xx","nc")
			bcs.b	@jamp\@
		endif
		if	strcmp("xx","c")
			bcc.b	@jamp\@
		endif
		bsr	yy
@jamp\@:
		endm

;****************************************************************
;	end of file
;****************************************************************
