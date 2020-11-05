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
	include program\mdlib.s		;Library
	
	org workbase
entry:
	;cargo culted init stuff
	moveq	#0,d0
	move.l	d0,command_0
	move.l	d0,command_4
	move.l	d0,command_8
	move.l	d0,command_12

	move.w	#$2700,sr ;disable interrupts
	lea	_vint,a0
	move.l	a0,_mlevel6+2 ;set V interrupt vector
	move.w	#$2000,sr ;enable interrupts
	
	;magenta background
	moveq #0,d0
	jsr cramaddr
	move.w #$f0f,d0 ;magenta
	move.w d0,$c00000
	
	moveq #0,d0
	moveq #0,d1
	lea hello_text,a0
	jsr printstr
	
	moveq #5,d0
	moveq #2,d1
	lea penis_text,a0
	jsr printstr
	
	moveq #0,d0
	moveq #4,d1
	move.w #$ABCD,d2
	jsr printword
	
	; move.w #$c000,d0
	; jsr vramaddr
	; move.w #$21,d0
	; move.w d0,$c00000
	
main_loop:
	lea.l systembase,a6

	moveq #0,d0
	moveq #4,d1
	move.w v_counter(a6),d2
	jsr printword
	move.w #1,vblank_flag(a6)
spin_loop:
	move.w vblank_flag(a6),d0
	bne spin_loop
	jmp main_loop
	
hello_text:
	dc.b "Hello world!",0
	
penis_text:
	dc.b "penis",0

	align $2

;---------------------------------------------------------------;
;	Prints a string using the font loaded by the BIOS
;
; IN	a0	Pointer to the string
;	d0.w	String x position
;	d1.w	String y position
;---------------------------------------------------------------;
printstr:
	;1. calculate vram address. BIOS initializes the VDP to 64x64 (so
	;128 bytes per line) with a base address of $c000 for plane 1.
	move.w #$8f02,$c00004 ;set vdp increment to 2 bytes (should already be set but just to make sure)
	asl.w #1,d0 ;multiply x pos by 2 (words->bytes)
	asl.w #7,d1 ;multiply y pos by 128
	add.w d1,d0 ;add y pos to x pos
	add.w #$c000,d0 ;add base address to calculated area
	jsr vramaddr ;set vdp to write to the calculated address
	moveq #0,d0 ;clear d0
@printloop:
	move.b (a0)+,d0 ;move text to d0
	beq @doneprint ;if we hit the null terminator, exit
	move.w d0,$c00000 ;write to vram
	bra @printloop
@doneprint
	rts
	
;---------------------------------------------------------------;
;	Prints a word using the font loaded by the BIOS
;
; IN	d0.w	x position
;	d1.w	y position
;	d2.w	word to print
;---------------------------------------------------------------;
printword:
	;calculate vram address. BIOS initializes the VDP to 64x64 (so
	;128 bytes per line) with a base address of $c000 for plane 1.
	move.w #$8f02,$c00004 ;set vdp increment to 2 bytes (should already be set but just to make sure)
	asl.w #1,d0 ;multiply x pos by 2 (words->bytes)
	asl.w #7,d1 ;multiply y pos by 128
	add.w d1,d0 ;add y pos to x pos
	add.w #$c000,d0 ;add base address to calculated area
	jsr vramaddr ;set vdp to write to the calculated address
	;print high nybble of high byte
	move.w d2,d0
	rol.w #4,d0 ;isolate high nybble of the word
	and.w #$f,d0
	jsr printnybble
	;print low nybble of high byte
	move.w d2,d0
	lsr.w #8,d0
	and.w #$f,d0
	jsr printnybble
	;print high nybble of low byte
	move.w d2,d0
	lsr.w #4,d0
	and.w #$f,d0
	jsr printnybble
	;print low nybble of low byte
	move.w d2,d0
	and.w #$f,d0
	jsr printnybble
	
	rts

;---------------------------------------------------------------;
;	Utility function that writes a nybble to VRAM
;
; IN	d0.w	nybble to print
;---------------------------------------------------------------;

printnybble:
	cmp.w #$a,d0
	bcs @nine_or_less
	add.w #'A'-$a,d0
	bra @done
@nine_or_less:
	add.w #'0',d0
@done:
	move.w d0,$c00000
	rts
	

;---------------------------------------------------------------;
;	Sets CRAM to write to given address
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
	
;---------------------------------------------------------------;
;	Sets VRAM to write to given address
;
; IN	d0.w	Address to write to in CRAM
;---------------------------------------------------------------;

vramaddr:
	movem.w d0,-(a7) ;save address
	and.w #$3fff,d0 ;mask off last two bits
	or.w #$4000,d0 ;add vram write command
	move.w d0,$c00004 ;write first word to vdp
	
	movem.w (a7)+,d0 ;retrieve address
	rol.w #2,d0 ;last 2 bits -> first 2 bits
	and.w #3,d0 ;mask off everything but first 2 bits
	move.w d0,$c00004 ;write second word to vdp
	rts

;---------------------------------------------------------------*
;	V interrupt
;---------------------------------------------------------------*

_vint:
		movem.l	d0-d7/a0-a6,-(a7)
		
		lea.l	systembase,a6

		; bset.b	#IFL2,_iflreg		; SUBCPU Interrupt

		; btst.b	#SCROLL_ON,vdp_flug(a6)
		; beq.b	@v2
		; bsr	scrolldma		; スクロールテーブルのＤＭＡ
	; @v2:
		; btst.b	#COLOR_ON,vdp_flug(a6)
		; beq.b	@cend
		; lea.l	colorbuffer,a0		; color data address
		; move.w	reg_1(a6),d2		; VDP reg #1
		; bsr	cramdma			; CRAM DMA
	; @cend:
		add.w #1,v_counter(a6)
		move.w #0,vblank_flag(a6) 
	; @end:
		movem.l	(a7)+,d0-d7/a0-a6
		rte
		rte

