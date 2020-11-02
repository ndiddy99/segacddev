;****************************************************************
;	MARS MEGA-CD Boot Check Program
;					Mega Drive Work RAM Assign
;	Copyright SEGA ENTERPRISES,LTD. 1994
;				SEGA ENTERPRISES,LTD.
;				CS Hardware R&D Dept.
;						T.Okawa
;---------------------------------------------------------------;
;
;****************************************************************

;---------------------------------------------------------------;
workbase	equ	$00ff0000	; $2000	; work start (program area)

tempbuff	equ	$00ff4000	; $1000	; temporaly buffer

colorbuffer	equ	$ffffc180	; $80	; color data buffer
scrbuffer	equ	$ffffc200	; $f00	; scroll A buffer
scrbufferB	equ	$ffffd100	; $f00	; scroll B buffer

;---------------------------------------------------------------;
systembase	equ	$ffffe000		; system used work start
reg_0		equ	$0000		; 2	; VDP reg. #0
reg_1		equ	$0002		; 2	; VDP reg. #1
reg_2		equ	$0004		; 2	; VDP reg. #2
reg_3		equ	$0006		; 2	; VDP reg. #3
reg_4		equ	$0008		; 2	; VDP reg. #4
reg_5		equ	$000a		; 2	; VDP reg. #5
reg_6		equ	$000c		; 2	; VDP reg. #6
reg_7		equ	$000e		; 2	; VDP reg. #7
reg_8		equ	$0010		; 2	; VDP reg. #8
reg_9		equ	$0012		; 2	; VDP reg. #9
reg_10		equ	$0014		; 2	; VDP reg. #10
reg_11		equ	$0016		; 2	; VDP reg. #11
reg_12		equ	$0018		; 2	; VDP reg. #12
reg_13		equ	$001a		; 2	; VDP reg. #13
reg_14		equ	$001c		; 2	; VDP reg. #14
reg_15		equ	$001e		; 2	; VDP reg. #15
reg_16		equ	$0020		; 2	; VDP reg. #16
reg_17		equ	$0022		; 2	; VDP reg. #17
reg_18		equ	$0024		; 2	; VDP reg. #18
joymemo1	equ	$0026		; 1	; joy pad 1
joymemo2	equ	$0027		; 1	; joy pad 2
joytrrg1	equ	$0028		; 1	; joy pad 1 push
joytrrg2	equ	$0029		; 1	; joy pad 2 push
joyoff1		equ	$002a		; 1	; joy pad 1 release
joyoff2		equ	$002b		; 1	; joy pad 2 release
vdp_flug	equ	$002c		; 1	; VDP control flug
vdp_flug1	equ	$002d		; 1	;	"
sys_flug	equ	$002e		; 1	; System used flug
init_flug	equ	$002f		; 1	; initial flug
v_counter	equ	$0030		; 2	; V interrupt counter
w_counter	equ	$0032		; 2	; wait counter
dmaoffset	equ	$0034		; 4	; DMA offset address
h_counter	equ	$0038		; 2	; H interrupt counter

textbuffer	equ	$0100		; $80	; テキスト表示用


;---------------------------------------------------------------;
;	MEGA-CD OS used RAM area
;---------------------------------------------------------------;

;Stack		equ	$fffffd00	;$100 For Stack
os_sys_ram	equ	$fffffd00	;$200 OS SYStem RAM area
;for modem	equ	$ffffff00	;100 use ark for modem

;---------------------------------------------------------------;

;;;;;;;;< OS system ram assign	>;;;;;;;
; Clear only power on
;Jump Tables
_reset		equ	os_sys_ram		;6: reset jump table
_mlevel6	equ	_reset+6		;V interrupt
_mlevel4	equ	_mlevel6+6		;H interrupt
_mlevel2	equ	_mlevel4+6		;external interrupt
_mtrap00	equ	_mlevel2+6		;TRAP #00
_mtrap01	equ	_mtrap00+6		
_mtrap02	equ	_mtrap01+6		
_mtrap03	equ	_mtrap02+6		
_mtrap04	equ	_mtrap03+6		
_mtrap05	equ	_mtrap04+6		
_mtrap06	equ	_mtrap05+6		
_mtrap07	equ	_mtrap06+6		
_mtrap08	equ	_mtrap07+6		
_mtrap09	equ	_mtrap08+6		
_mtrap10	equ	_mtrap09+6		
_mtrap11	equ	_mtrap10+6		
_mtrap12	equ	_mtrap11+6		
_mtrap13	equ	_mtrap12+6		
_mtrap14	equ	_mtrap13+6		
_mtrap15	equ	_mtrap14+6		
_mchkerr	equ	_mtrap15+6		;chk 
_madrerr	equ	_mchkerr+6		;address error
_mcoderr	equ	_mchkerr+6		;undefined code
_mdiverr	equ	_mcoderr+6		;divide error
_mtrperr	equ	_mdiverr+6
_mnocod0	equ	_mtrperr+6
_mnocod1	equ	_mnocod0+6
_mspverr	equ	_mnocod1+6
_mtrace		equ	_mspverr+6
_vint_ex	equ	_mtrace+6
_mburam		equ	_vint_ex+6		;buck up ram entry


;---------------------------------------------------------------;
;	Bit Assign
;---------------------------------------------------------------;

; vdp_flug
COLOR_ON	equ	0	; Color DMA    	1:on/ 0:off
SCROLL_ON	equ	1	; Scroll DMA   	1:on/ 0:off

; vdp_flug1
SCROLLAB	equ	0	; scroll DMA A/B

; sys_flug
Z80		equ	0	; Z80 working


;****************************************************************
;	end of file
;****************************************************************
