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
	include		include\cdcmd.i

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
	move.w #FLG_ACTIVATE,status_2 ;let the main cpu know we're ready

@activate_loop: ;wait for activate command to be sent to command_0
		;before starting the command processing step
		
	move.w command_2,d0
	cmp.w #FLG_ACTIVATE,d0
	bne @activate_loop
	
@command_loop: ;read a command, then go to that command's function
	moveq #0,d0 ;clear d0 upper word
	move.w command_0,d0 ;read the command
	move.w d0,status_0 ;acknowledge that we're running the command
	move.w #RES_WAIT,status_2 ;set the status to "wait for processing"
	asl.l #2,d0 ;convert the command number to its index in the table
	move.w d0,a0
	move.l command_table(a0),a0
	jsr (a0) ;run the command function
	bra @activate_loop
	
	align $2
command_table:
	dc.l func_loadinter
	; dc.l func_opendrv
	; dc.l func_closedrv
	; dc.l func_drvstatus
	; dc.l func_loadmain
	; dc.l func_loadsub

md_ipl:
	dc.b	"IPL.BIN",0
	
	align $2

func_loadinter:
	
@set_1m:
	bset.b	#MODE,_memory ;set the word ram mode to 1m
	beq.b	@set_1m
@get_access:
	bclr.b	#RET,_memory ;clear the RET bit, getting access to word ram
	bne.b	@get_access

	bsr	issoread
	bcc	@retry			; if success continue with loading
	
	move.w #RES_ERR,status_2	; else return error
	rts
	
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
	bset.b	#RET,_memory		; swap in the data we loaded so
	beq.b	@l2			; the main cpu can read it

	move.w	#RES_OK,status_2	; subcpu ready
@end:
	rts

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


;---------------------------------------------------------------;
;	iso routines
;---------------------------------------------------------------;

	include		sp\isoutil.s


;****************************************************************
;	end of file
;****************************************************************
