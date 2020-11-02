;****************************************************************
;	MARS MEGA-CD Boot Check Program
;					ISSO9660 utility
;
;	Copyright SEGA ENTERPRISES,LTD. 1994
;				SEGA ENTERPRISES,LTD.
;				CS Hardware R&D Dept.
;						T.Okawa
;---------------------------------------------------------------;
;
;****************************************************************

; include
	include		include\isso.i

;---------------------------------------------------------------;
;	reading for isso9660 volume data
;---------------------------------------------------------------;

		align $2

issoread:
		lea.l	issosector(pc),a2	; volume descriptor read
		move.w	#(volumebuffer>>3)&$0ffff,d6
		move.l	#1,4(a2)
		move.l	#1-1,d5
		move.b	#PRGDMA,d3
		bsr	dataread
		bcs	discerror

		lea.l	volumebuffer,a0
		lea.l	rootdirentry(a0),a1
		move.l	extentLSN(a1),d0

		lea.l	readsector(pc),a2
		move.l	d0,(a2)
		move.w	#(volumebuffer>>3)&$0ffff,d6
		move.l	#$10000/$800-1,d5
		move.l	#$10000/$800,4(a2)
		move.b	#PRGDMA,d3
		bsr	dataread
		bcs	discerror

		move.w	#%00000,ccr
		rts

issosector:
		dc.l	16
readsector:
		dc.l	0
readsectorsize:
		dc.l	0


;---------------------------------------------------------------;
;		cd-rom data read routine	( only dma )
;
; IN  :	a2.l	read sector data address
;	d6.w	dma address data
;	d5.w	read counter
;	d3.b	destination
;---------------------------------------------------------------;

dataread:
		movem.l d0/d1/d4/d7/a0/a1,-(a7)

@retry:
		add.w	#1,retry_counter

		movea.l	a2,a0			; read sector set
		bios	ROMREADN

		move.w	d6,d4
@l1:
		clr.w	v_counter
@statwait:
		cmp.w	#60*5,v_counter		; max wait = 5sec
		bcc.b	@retry
		bios	CDCSTAT			; data ready ?
		bcs.b	@statwait

		move.b	d3,_cdcmode		; read mode set
		move.w	d4,_dmaadrs
		clr.w	v_counter
@l2:
		tst.w	_dmaadrs		; debug
		bne.b	@ll2			;
		cmp.b	#PRGDMA,d3		;
		bne.b	@ll2			;
		jmp	$206			;
@ll2:
		cmp.w	#60,v_counter		; max wait = 1sec
		bcc.b	@retry
		bios	CDCREAD			; cdc set
		bcs.b	@retry
		clr.w	v_counter
@l3:
		cmp.w	#60,v_counter		; max wait = 1sec
		bcc.b	@retry
		tst.w	_dmaadrs		; debug
		btst.b	#EDT,_cdcmode		; waiting for DMA finished
		beq.b	@l3

		bios	CDCACK

		add.w	#($800>>3),d4
		dbra	d5,@l1

		movem.l (a7)+,d0/d1/d4/d7/a0/a1
		move.w	#%00000,ccr
		rts

discerror:
		move.l	#'disc',status_0
		move.l	#' err',status_4
@lp:
		bra.b	@lp


;---------------------------------------------------------------;
;		cd-rom data read routine	( subcpu read )
;
; IN  :	a2.l	read sector data address
;	a1.l	pointer of destination buffer
;	d5.w	read counter
;---------------------------------------------------------------;

cpuread:
		movem.l	d0-d7/a0-a6,-(a7)

		movea.l	a1,a5

		clr.w	d7
@retry:
		cmp.w	#3,d7
		bcc	discerror

		movea.l	a2,a0			; read sector set
		bios	ROMREADN
@l1:
		clr.w	v_counter
@statwait:
		cmp.w	#60*5,v_counter		; max wait = 5sec
		bcc.b	@retry
		bios	CDCSTAT			; data ready ?
		bcs.b	@statwait

		move.b	d3,_cdcmode		; read mode set
		clr.w	v_counter
@l2:
		cmp.w	#60,v_counter		; max wait = 1sec
		bcc.b	@retry
		bios	CDCREAD			; cdc set
		bcs.b	@retry

		movea.l	a5,a0
		lea.l	hederbuffer(pc),a1
		bios	CDCTRN
		bcs	@retry

		movea.l	a0,a5

		bios	CDCACK

		dbra	d5,@l1

		movem.l	(a7)+,d0-d7/a0-a6
		rts

hederbuffer:
		dc.l	0,0,0,0


;---------------------------------------------------------------;
;		file search
;
; IN  :	a0.l	search file data address
;
; OUT :	d0.l	logical sector number
;	d1.l	file size
;---------------------------------------------------------------;

filesearch:
		movem.l a1/a2/a6,-(a7)

		lea.l	volumebuffer,a1
@l0:
		movea.l	a0,a6
		move.b	(a6)+,d0
@l2:
		movea.l	a1,a2
		cmp.b	(a1)+,d0
		bne.b	@l2
@l3:
		move.b	(a6)+,d0
		beq	@end
		cmp.b	(a1)+,d0
		bne.b	@l0
		bra.b	@l3
@end:
		sub.l	#33,a2
		move.b	extentLSN(a2),d0
		lsl.l	#8,d0
		move.b	extentLSN+1(a2),d0
		lsl.l	#8,d0
		move.b	extentLSN+2(a2),d0
		lsl.l	#8,d0
		move.b	extentLSN+3(a2),d0

		move.b	filelen(a2),d1
		lsl.l	#8,d1
		move.b	filelen+1(a2),d1
		lsl.l	#8,d1
		move.b	filelen+2(a2),d1
		lsl.l	#8,d1
		move.b	filelen+3(a2),d1

		movem.l (a7)+,a1/a2/a6
		rts


;---------------------------------------------------------------;
;		file execute
;---------------------------------------------------------------;

fileexecute:
		clr.w	status_0
		lea.l	command_4,a0
		bsr	filesearch		; searching for exec file
@l0:
		bclr.b	#RET,_memory
		bne.b	@l0

		lea.l	readsector(pc),a6
		move.l	d0,(a6)
		clr.l	d6
		lsr.l	#8,d1
		lsr.l	#3,d1
		and.l	#$20000/$800-1,d1	; MAX buffer = $20000
		move.l	d1,d5
		move.l	d5,4(a6)
		add.l	#1,4(a6)
		move.b	#WORDDMA,d3
		bsr	dataread
		bcs	discerror

		lea.l	word_ram_1m,a0
		move.l	(a0)+,d0		; sub program load
		move.l	(a0)+,d7
		beq.b	@l1
		add.l	d0,a0
		lsr.l	#4,d7
		sub.l	#1,d7
		lea.l	ap_program_area,a1
@copy:
		move.l	(a0)+,(a1)+
		move.l	(a0)+,(a1)+
		move.l	(a0)+,(a1)+
		move.l	(a0)+,(a1)+
		dbra	d7,@copy
@l1:
		bset.b	#RET,_memory
		beq.b	@l1

		move.w	#'go',status_0		; finished loading
@l2:
		cmp.l	#'exec',command_0
		beq.b	@l2
		clr.l	status_0

		cmp.w	#-1,d7
		bne.b	@end
		jsr	ap_program_area
@end:
		rts


;****************************************************************
;	end of file
;****************************************************************
