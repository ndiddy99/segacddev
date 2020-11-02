;****************************************************************
;	MARS MEGA-CD Boot Check Program
;					System program
;
;	Copyright SEGA ENTERPRISES,LTD. 1994
;				SEGA ENTERPRISES,LTD.
;				CS Hardware R&D Dept.
;						T.Okawa
;---------------------------------------------------------------;
;	Verion 1.0				7/4/1994
;****************************************************************

; include
	include		include\cdmap.i
	include		include\prgram.i
	include		include\cdbios.i

	list


;---------------------------------------------------------------;
;	system headder
;---------------------------------------------------------------;
		org	$6000
sub_headder:
		dc.b	'MAIN_AP____',0		; module name, flag
		dc.w	$0000,0			; version,type
		dc.l	0			; ptr. next module
		dc.l	0			; module size
		dc.l	sub_start-sub_headder	; Start address
		dc.l	0			; Work Ram size

sub_start:
		dc.w	sub_init-sub_start	; initialize routine
		dc.w	sub_main-sub_start	; main routine
		dc.w	sub_int2-sub_start	; level 2 interrupt routine
		dc.w	sub_user-sub_start	; user defined routine
		dc.w	0


;---------------------------------------------------------------;
;	initialize routine
;---------------------------------------------------------------;

sub_init:
		bsr	comm_init		; communication initialize

		lea	gr_int(pc),a0		; graphic interrupt vector set
		move.w	#JMP_CODE,_level1
		move.l	a0,_level1+2

		lea	_int3(pc),a0		; timer interrupt vector set
		move.w	#JMP_CODE,_level3
		move.l	a0,_level3+2

		rts


;---------------------------------------------------------------;
;	level 1 interrupt routine
;---------------------------------------------------------------;

gr_int:
		rte


;---------------------------------------------------------------;
;	level 2 interrupt routine
;---------------------------------------------------------------;

sub_int2:
		addq.w	#1,v_counter

		rts


;---------------------------------------------------------------;
;	level 3 interrupt routine
;---------------------------------------------------------------;

_int3:
		rte


;---------------------------------------------------------------;
;	subcpu main routine
;---------------------------------------------------------------;

sub_main:
		nop
	@l0:
		bset.b	#MODE,_memory
		beq.b	@l0
	@l1:
		bclr.b	#RET,_memory
		bne.b	@l1

		bsr	issoread
		bcs	@loop			; if error then program end
	@retry:
		lea	md_ipl(pc),a0		; Name pointer
		bsr	filesearch		; File search

		lea	readsector(pc),a0
		move.l	d0,(a0)
		moveq	#0,d6			; DMA data address
		and.l	#$20000/$800-1,d1	; MAX buffer = $20000
		move.l	d1,d5			; read counter
		move.l	d5,4(a0)
		move.b	#WORDDMA,d3		; destination
		bsr	dataread		; CD Data read
		bcs	@retry
	@l2:
		bset.b	#RET,_memory		; Swap memory
		beq.b	@l2

		move.w	#'ok',status_0		; subcpu ready
	; @l3:
		; cmp.w	#'sh',command_0		; Wait MD IPL Setup
		; bne.b	@l3
	; @retry1:
		; lea	sh2_ipl(pc),a0		; Name pointer
		; bsr	filesearch		; File search

		; lea	readsector(pc),a0
		; move.l	d0,(a0)
		; moveq	#0,d6			; DMA data address
		; and.l	#$20000/$800-1,d1	; MAX buffer = $20000
		; move.l	d1,d5			; read counter
		; move.l	d5,4(a0)
		; move.b	#WORDDMA,d3		; destination
		; bsr	dataread		; CD Data read
		; bcs	@retry1
	; @l4:
		; bclr.b	#RET,_memory		; Swap memory
		; bne.b	@l4

		bios	ROMPAUSEON		; CD pause
	@loop:













		nop
		bra.b	@loop


;---------------------------------------------------------------;
;	user defined routine
;---------------------------------------------------------------;

sub_user:
		rts


;---------------------------------------------------------------;
;	communication initialize
;---------------------------------------------------------------;

comm_init:
		clr.b	sub_flug
		clr.l	status_0
		clr.l	status_4
		clr.l	status_8
		clr.l	status_12
		rts

;---------------------------------------------------------------;

md_ipl:
	dc.b	"IPL.BIN",0

;---------------------------------------------------------------;
;	iso routines
;---------------------------------------------------------------;

	include		sp\isoutil.s


;****************************************************************
;	end of file
;****************************************************************
