;****************************************************************
;	MARS MEGA-CD Boot Check Program
;					Mega Drive Libraly
;
;	Copyright SEGA ENTERPRISES,LTD. 1994
;				SEGA ENTERPRISES,LTD.
;				CS Hardware R&D Dept.
;						T.Okawa
;---------------------------------------------------------------;
;
;****************************************************************

;---------------------------------------------------------------;
;	Scroll DMA （インタラプト内ルーチン）
;---------------------------------------------------------------;

scrolldma:
		btst.b	#SCROLLAB,vdp_flug1(a6)
		bne.b	@l0			;

		lea.l	scrbuffer,a0		; DMA source
		move.w	#$f00,d0		; Data size
		move.w	#SCR_A_TBL,d1		; DMA destination
		move.w	reg_1(a6),d2		; VDP reg #1
		bsr	vramdma			; VRAM DMA
		bra.b	@l1
	@l0:
		lea.l	scrbufferB,a0		; DMA source
		move.w	#$f00,d0		; Data size
		move.w	#SCR_B_TBL,d1		; DMA destination
		move.w	reg_1(a6),d2		; VDP reg #1
		bsr	vramdma			; VRAM DMA
	@l1:
		bchg.b	#SCROLLAB,vdp_flug1(a6)

		rts


;---------------------------------------------------------------;
;		VRAM DMA
;
; IN	d0.w	data size
;	d1.w	DMA destination address
;	d2.w	VDP reg #1
;	a0.l	DMA source address
;---------------------------------------------------------------;

vramdma:
		movem.l	d3/a1,-(a7)

		btst.b	#Z80,sys_flug(a6)
		call	nz,z80busreq

		lea.l	$c00004,a1
		bset	#4,d2
		move.w	d2,(a1)			; DMA bit = 1

		lsr.w	#1,d0			; set DMA length
		move.w	d0,d3
		and.w	#$0ff,d3
		or.w	#$9300,d3
		move.w	d3,(a1)
		lsr.w	#8,d0
		or.w	#$9400,d0
		move.w	d0,(a1)

		move.l	a0,d3			; set DMA source address
		and.l	#$ffffff,d3
		lsr.l	#1,d3
		move.w	#$9500,d0
		move.b	d3,d0
		move.w	d0,(a1)
		lsr.l	#8,d3
		move.w	#$9600,d0
		move.b	d3,d0
		move.w	d0,(a1)
		lsr.w	#8,d3
		move.w	#$9700,d0
		move.b	d3,d0
		move.w	d0,(a1)

		move.w	d1,d0			; set DMA destination address
		lsr.w	#8,d0
		lsr.w	#6,d0
		or.w	#$80,d0
		move.w	d0,-(a7)
		move.w	d1,d0
		and.w	#$3fff,d0
		or.w	#$4000,d0
		move.w	d0,-(a7)
		move.w	(a7)+,(a1)
		move.w	(a7)+,(a1)

		bclr	#4,d2			; DMA bit = 0
		move.w	d2,(a1)
		btst.b	#Z80,sys_flug(a6)
		call	nz,z80busreqoff

		movem.l	(a7)+,d3/a1
		rts


;---------------------------------------------------------------;
;		CRAM DMA
;
; IN	d2.w	VDP reg #1
;	a0.l	DMA source address
;---------------------------------------------------------------;

cramdma:
		movem.l	d0/d3/a1,-(a7)

		btst.b	#Z80,sys_flug(a6)
		call	nz,z80busreq

		lea.l	$c00004,a1
		bset	#4,d2
		move.w	d2,(a1)			; DMA bit = 1

		move.w	#$9340,(a1)
		move.w	#$9400,(a1)

		move.l	a0,d3			; set DMA source address
		and.l	#$ffffff,d3
		lsr.l	#1,d3
		move.w	#$9500,d0
		move.b	d3,d0
		move.w	d0,(a1)
		lsr.l	#8,d3
		move.w	#$9600,d0
		move.b	d3,d0
		move.w	d0,(a1)
		lsr.w	#8,d3
		move.w	#$9700,d0
		move.b	d3,d0
		move.w	d0,(a1)

		move.l	#$c0000080,-(a7)	; set DMA destination address
		move.w	(a7)+,(a1)
		move.w	(a7)+,(a1)

		bclr	#4,d2			; DMA bit = 0
		move.w	d2,(a1)

		btst.b	#Z80,sys_flug(a6)
		call	nz,z80busreqoff

		movem.l	(a7)+,d0/d3/a1
		rts


;---------------------------------------------------------------;
;	VDP initialize
;
; IN	a2.l	pointer of VDP reg. data
;	a3.l	VDP register table address
;---------------------------------------------------------------;

vdpinit:
		movem.l	d0-d2/a0/a1,-(a7)

		lea.l	$c00004,a0
		lea.l	$c00000,a1
	@w:
		move.w	(a0),d0			; Wait Vblank
		btst	#3,d0
		beq.b	@w

		move.w	#$100,d2
		move.w	#$8000,d1		; VDP register No.
		move.w	#18,d0			; set VDP register
	@l0:					;	#0 - #18
		move.b	(a2)+,d1
		move.w	d1,(a0)
		move.w	d1,(a3)+
		add.w	d2,d1
		dbra	d0,@l0

		move.l	#$40000000,(a0)
		move.w	#$10000/4/4-1,d0
	@l1:
		move.l	#0,(a1)
		move.l	#0,(a1)
		move.l	#0,(a1)
		move.l	#0,(a1)
		dbra	d0,@l1

		clr.l	d1
		move.l	#$40000010,(a0)
		move.w	#80/4/4-1,d0		; V scroll RAM clear
	@l2:
		move.l	d1,(a1)
		move.l	d1,(a1)
		move.l	d1,(a1)
		move.l	d1,(a1)
		dbra	d0,@l2

		move.l	#$c0000000,(a0)		; color RAM clear
		move.w	#$80/4/4-1,d0
	@l3:
		move.l	d1,(a1)
		move.l	d1,(a1)
		move.l	d1,(a1)
		move.l	d1,(a1)
		dbra	d0,@l3

		movem.l	(a7)+,d0-d2/a0/a1
		rts


;---------------------------------------------------------------;
;	Z80 Bus Request
;---------------------------------------------------------------;

z80busreq:
		bset.b	#0,z_brq
	@wz:
		btst.b	#0,z_brq
		bne.b	@wz
		rts


;---------------------------------------------------------------;
;	Z80 Bus Request off
;---------------------------------------------------------------;

z80busreqoff:
		bclr.b	#0,z_brq
		rts


;****************************************************************
;	end of file
;****************************************************************
