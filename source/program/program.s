;****************************************************************
;	Sega CD Freeloader: Main Genesis program
;
;	Copyright Nathan Misner
;
;---------------------------------------------------------------;
;						Created 11/1/20
;****************************************************************

;include
	include include\md.i		;hw mapping
	include include\m_const.i	;hw constants
	include include\mdwork.i	;wram locations
	
	org workbase
entry:
	;cargo culted init stuff
	moveq	#0,d0
	move.l	d0,command_0
	move.l	d0,command_4
	move.l	d0,command_8
	move.l	d0,command_12

	move.w	#$2700,sr
	lea	_vint(pc),a0
	move.l	a0,_mlevel6+2		; set V interrupt vector
	move.w	#$2000,sr

	bsr	SysInit			; Initialize
	
	;red background
	move.w #$00E,d0
	move.w d0,colorbuffer
	
@loop:
	nop
	nop
	nop
	bra @loop

;---------------------------------------------------------------*
;	V interrupt
;---------------------------------------------------------------*

_vint:
		movem.l	d0-d7/a0-a6,-(a7)

		lea.l	systembase,a6

		bset.b	#IFL2,_iflreg		; SUBCPU Interrupt

		btst.b	#SCROLL_ON,vdp_flug(a6)
		beq.b	@v2
		bsr	scrolldma		; スクロールテーブルのＤＭＡ
	@v2:
		btst.b	#COLOR_ON,vdp_flug(a6)
		beq.b	@cend
		lea.l	colorbuffer,a0		; color data address
		move.w	reg_1(a6),d2		; VDP reg #1
		bsr	cramdma			; CRAM DMA
	@cend:
		add.w	#1,v_counter(a6)
		add.w	#1,w_counter(a6)
	@end:
		movem.l	(a7)+,d0-d7/a0-a6
		rte
		rte


;---------------------------------------------------------------*
;	System Initialize
;
; OUT	: a6	systembase address
;---------------------------------------------------------------*

SysInit:
		lea.l	systembase,a6		; set Main System work base address

; ----	WorkRAM Setup
		lea	scrbuffer,a0
		move.w	#$f00/4/4-1,d7
		moveq	#0,d0
	@wclr0:
		move.l	d0,(a0)+
		move.l	d0,(a0)+
		move.l	d0,(a0)+
		move.l	d0,(a0)+
		dbra	d7,@wclr0

		lea	scrbufferB,a0
		move.w	#$f00/4/4-1,d7
		moveq	#0,d0
	@wclr1:
		move.l	d0,(a0)+
		move.l	d0,(a0)+
		move.l	d0,(a0)+
		move.l	d0,(a0)+
		dbra	d7,@wclr1

; ----	VDP Initialize
		lea	regdata(pc),a2		; set pointer of VDP reg. data
		lea	reg_0(a6),a3		; set VDP register table address
		bsr	vdpinit			; VDP initialize

; ----	Charactor Data Setup
		lea.l	asciidata(pc),a0
		lea.l	tempbuff,a1
		move.w	#$c00/4/4-1,d0
	@l1:
		move.l	(a0)+,(a1)+
		move.l	(a0)+,(a1)+
		move.l	(a0)+,(a1)+
		move.l	(a0)+,(a1)+
		dbra	d0,@l1

		lea	workbase,a0		; DMA source
		move.w	#$c00,d0		; Data size
		move.w	#ASCII_AREA,d1		; DMA destination
		move.w	reg_1(a6),d2		; VDP reg #1
		bsr	vramdma			; VRAM DMA

; ----	カラーデータをワークに転送
		lea	_colordata(pc),a0
		lea	colorbuffer,a1
		move.w	#$80/4/4-1,d0
	@l2:
		move.l	(a0)+,(a1)+
		move.l	(a0)+,(a1)+
		move.l	(a0)+,(a1)+
		move.l	(a0)+,(a1)+
		dbra	d0,@l2

		lea	colorbuffer,a0		; color data address
		move.w	reg_1(a6),d2		; VDP reg #1
		bsr	cramdma			; CRAM DMA

		rts
		
;---------------------------------------------------------------*
;	Other files
;---------------------------------------------------------------*
	include program\sysdata.s ;ASCII font and register data
	include program\mdlib.s ;Library

