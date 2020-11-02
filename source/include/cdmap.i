;***************************************************************;
;	MARS MEGA-CD Boot Check Program
;					SUBCPU Map
;
;	Copyright SEGA ENTERPRISES,LTD. 1994
;				SEGA ENTERPRISES,LTD.
;				CS Hardware R&D Dept.
;						T.Okawa
;---------------------------------------------------------------;
;
;***************************************************************;

;---------------------------------------------------------------;

RTE_CODE	equ	$4e73
JMP_CODE	equ	$4ef9

;---------------------------------------------------------------;
;				label
;---------------------------------------------------------------;

; label		      ; address		; size		; info.


word_ram	equ	$00080000			; word RAM 2M mode
word_ram_1m	equ	$000c0000			; word RAM 1M mode

backup_ram	equ	$fffe0000	; $3fff		; backup RAM

rf5c164		equ	$ffff0000			; pcm RF5C164
pcm_vol		equ	$ffff0001
pcm_pan		equ	$ffff0003
pcm_fdl		equ	$ffff0005
pcm_fdh		equ	$ffff0007
pcm_lsl		equ	$ffff0009
pcm_lsh		equ	$ffff000b
pcm_st		equ	$ffff000d
pcm_cont	equ	$ffff000f			; pcm control (bank)
pcm_ch		equ	$ffff0011			; pcm channel control
pcm_ch0_low	equ	$ffff0021
pcm_ch0_high	equ	$ffff0023
pcm_ch1_low	equ	$ffff0025
pcm_ch1_high	equ	$ffff0027
pcm_ram		equ	$ffff2000			; pcm wave memory

_ledreg		equ	$ffff8000	; byte		; led register
_memory		equ	$ffff8003	; byte		; memory mode
_cdcmode	equ	$ffff8004	; byte		; cdc destination
_dmaadrs	equ	$ffff800a	; word		; cdc DMA address
main_flug	equ	$ffff800e	; byte		; maincpu flug
sub_flug	equ	$ffff800f	; byte		; subcpu flug
command_0	equ	$ffff8010			; communication command
command_2	equ	$ffff8012			;
command_4	equ	$ffff8014			;
command_6	equ	$ffff8016			;
command_8	equ	$ffff8018			;
command_10	equ	$ffff801a			;
command_12	equ	$ffff801c			;
command_14	equ	$ffff801e			;
status_0	equ	$ffff8020			; communication status
status_2	equ	$ffff8022			;
status_4	equ	$ffff8024			;
status_6	equ	$ffff8026			;
status_8	equ	$ffff8028			;
status_10	equ	$ffff802a			;
status_12	equ	$ffff802c			;
status_14	equ	$ffff802e			;

_timerdata	equ	$ffff8030
_intmask	equ	$ffff8033

_fontcolor	equ	$ffff804d	; byte	rw	; sorce font color
_fontbit	equ	$ffff804e	; word	rw	; sorce font bit
_fontdata	equ	$ffff8050	; ->$ff8057 ro	; converted font data

_stampsize		equ	$ffff8059	; byte	; stamp size
_stamp_map_base		equ	$ffff805a	; word	; stamp map base address
_image_vcell_size	equ	$ffff805c	; word	; image buffer v cell size
_image_start_adrs	equ	$ffff805e	; word	; image buffer start address
_image_offset		equ	$ffff8060	; word	; image buffer offset
_image_hdot_size	equ	$ffff8062	; word	; image buffer h dot size
_image_vdot_size	equ	$ffff8064	; word	; image buffer v dot size
_trace_vector		equ	$ffff8066	; word	; trace vector table address


;---------------------------------------------------------------;
;	Bit assign
;---------------------------------------------------------------;

; _iflreg
IFL2		equ	0
IEN2		equ	7

; _ledreg
LEDR		equ	0
LEDG		equ	1

; _memory
RET		equ	0
DMNA		equ	1
MODE		equ	2
PM0		equ	3
PM1		equ	4

; _cdcmode
MAINREAD	equ	2
SUBREAD		equ	3
PCMDMA		equ	4
PRGDMA		equ	5
WORDDMA		equ	7
EDT		equ	7
DSR		equ	6

; sub_flug
S_READY		equ	7

; main_flug
M_READY		equ	7

; _intmask
IEN1		equ	1
IEN3		equ	3


;---------------------------------------------------------------;
;	macro
;---------------------------------------------------------------;

;---------------------------------------------------------------;
;	align	xx
;		xx = what to align to
;---------------------------------------------------------------;

align		macro xx
		cnop 0,xx
		endm


;---------------------------------------------------------------;
;	bios	xx
;		xx = bios call No.
;---------------------------------------------------------------;

bios		macro	xx			; bios call macro
		move.w	#xx,d0
		jsr	_cdbios
		endm

;---------------------------------------------------------------;
;	call	xx,yy
;		xx = nz,z,nc,c
;		yy = jump address
;---------------------------------------------------------------;

call		macro	xx,yy
		if	strcmp(xx,"nz")
			beq.b	@jamp
		endif
		if	strcmp(xx,"z")
			bne.b	@jamp
		endif
		if	strcmp(xx,"nc")
			bcs.b	@jamp
		endif
		if	strcmp(xx,"c")
			bcc.b	@jamp
		endif
		bsr	yy
@jamp:
		endm

;***************************************************************;
;	end of file
;***************************************************************;
