;****************************************************************
;	MARS MEGA-CD Boot Check Program
;					Mega Drive Mapping Assign
;	Copyright SEGA ENTERPRISES,LTD. 1994
;				SEGA ENTERPRISES,LTD.
;				CS Hardware R&D Dept.
;						T.Okawa
;---------------------------------------------------------------;
;
;****************************************************************


;---------------------------------------------------------------;
os_rom		equ	$000000			; os rom address
bios_address	equ	$010000			; bios system address
s_prog_ram	equ	$020000	; ->$03ffff	; subcpu program ram
word_ram	equ	$200000			; 2Mbit word ram
v_image_256	equ	$220000			; vram image 32cell
v_image_128	equ	$230000			; vram image 16cell
v_image_64	equ	$238000			; vram image 8cell
v_image_32_0	equ	$23c000			; vram image 4cell 0
v_image_32_1	equ	$23e000			; vram image 4cell 1

framebuffer	equ	$840000
overwrite	equ	$860000
marsipl		equ	$880000
marsbank	equ	$900000

;---------------------------------------------------------------;
zprg_ram	equ	$a00000

;---------------------------------------------------------------;
_version	equ	$a10001		; byte		; md version
_port_a		equ	$a10003		; byte		; joy pad a
_port_b		equ	$a10005		; byte		; joy pad b
_port_c		equ	$a10007		; byte		; joy pad c
_pa_cont	equ	$a10009		; byte		; joy pad a control
_pb_cont	equ	$a1000b		; byte		; joy pad b control
_pc_cont	equ	$a1000d		; byte		; joy pad c control
_cartmode	equ	$a11000		; word

;---------------------------------------------------------------;
z_brq		equ	$a11100				; Z80 bus request
z_res		equ	$a11200				; Z80 reset

;---------------------------------------------------------------;
_iflreg		equ	$a12000		; byte		; Interrupt
_resreg		equ	$a12001		; byte		; Reset
_protect	equ	$a12002		; byte		; Write Protect
_memory		equ	$a12003		; byte		; Memory Mode
_cdcmode	equ	$a12004		; byte		; cdc mode register
_h_vector	equ	$a12006		; word		; H Interrupt Vector
_cdchost	equ	$a12008		; word		; cdc data port

main_flug	equ	$a1200e		; byte		; maincpu flug
sub_flug	equ	$a1200f		; byte		; subcpu fug
command_0	equ	$a12010				; communication command
command_2	equ	$a12012				;
command_4	equ	$a12014				;
command_6	equ	$a12016				;
command_8	equ	$a12018				;
command_10	equ	$a1201a				;
command_12	equ	$a1201c				;
command_14	equ	$a1201e				;
status_0	equ	$a12020				; communication status
status_2	equ	$a12022				;
status_4	equ	$a12024				;
status_6	equ	$a12026				;
status_8	equ	$a12028				;
status_10	equ	$a1202a				;
status_12	equ	$a1202c				;
status_14	equ	$a1202e				;

;---------------------------------------------------------------;
mars_ID		equ	$a130ec		; long		; MARS ID "MARS"
bankchip	equ	$a130f1		;		; Bank Chip Reg.0

;---------------------------------------------------------------;
_security	equ	$a14000		; long		; md security
_v6os		equ	$a14100		; word

;---------------------------------------------------------------;
marsreg		equ	$a15100
access		equ	$00		; byte		; MARS VDP access control
adapter		equ	$01		; byte		; MARS adapter control
intctl		equ	$03		; byte		; SH2 interrupt control
bankctl		equ	$05		; byte		; BANK conterol
dreqctl		equ	$07		; byte		; DREQ control
dreqsource	equ	$08		; long		; 68 to SH DREQ source address
dreqdest	equ	$0c		; long		; 68 to SH DREQ destination address
dreqlength	equ	$10		; word		; 68 to SH DREQ length
dreqfifo	equ	$12		; word		; 68 to SH DREQ FIFO
segatv		equ	$1b		; byte		; SEGA TV Reg.
comm0		equ	$20		; 		; Communcation Reg.
comm2		equ	$22		; 		; Communcation Reg.
comm4		equ	$24		; 		; Communcation Reg.
comm6		equ	$26		; 		; Communcation Reg.
comm8		equ	$28		; 		; Communcation Reg.
comm9		equ	$29		; 		; Communcation Reg.
comm10		equ	$2a		; 		; Communcation Reg.
comm12		equ	$2c		; 		; Communcation Reg.
comm14		equ	$2e		; 		; Communcation Reg.
timctl		equ	$30		; byte		; PWM Timer Control
pwmctl		equ	$31		; byte		; PWM Control
fstimer		equ	$32		; word		; PWM Frequency Timer
lchpulse	equ	$34		; word		; PWM Lch Pulse Width
rchpulse	equ	$36		; word		; PWM Rch Pulse Width
monopulse	equ	$38		; word		; PWM Monaural Pulse Width

tvmode		equ	$80		; byte		; NTSC/PAL
bitmapmd	equ	$81		; byte		; BitMap Mode Reg.
shift		equ	$83		; byte		; Packed Pixel Dot Shift
filllength	equ	$85		; byte		; DRAM Fill Length
fillstart	equ	$86		; word		; DRAM Fill Start Address
filldata	equ	$88		; word		; DRAM Fill Data
vdpsts		equ	$8a		; byte		; VDP status
framectl	equ	$8b		; byte		; Frame Buffer Control

palette		equ	$a15200		; 256 words	; Palette Data


_vdpdata	equ	$c00000				; vdp data port
_vdpreg		equ	$c00004				; vdp register



;---------------------------------------------------------------;
;	Bit Assign
;---------------------------------------------------------------;

; access
FM		equ	7		; 0:MD		/1: SH

; adapter
ADEN		equ	0		; 0: disenable 	/1: enable
RES		equ	1		; 0: SH2 reset 	/1: SH2 reset off

; intctl
INTM		equ	0		; 0: NOP	/1: master CMD INT
INTS		equ	1		; 0: NOP	/1: slave  CMD INT

; dreqctl
RV		equ	0		; 0: NOP	/1: ROM to VRAM DMA
DMA		equ	1		; 0: CPU write	/1: DMA write
D68S		equ	2		; 0: NOP	/1: DREQ start
FULL		equ	7		; 0: empty	/1: full

; segatv
CM		equ	0		; 0: ROM	/1: DRAM

; tvmode
PAL		equ	7		; 0:NTSC	/1: PAL

; bitmapmode
L240		equ	6		; 0:224line	/1: 240line
PRI		equ	7		; 0:ÇlÇcóDêÊ	/1: ÇlÇ`ÇqÇróDêÊ

; shift
SFT		equ	0		; 0:Nomal	/1: Dot Shift

; vdpsts
PEN		equ	5		; 0:Palette EN	/1: Palette DisEN
HBLK		equ	6		; 0:Disp	/1: Blank
VBLK		equ	7		; 0:Disp	/1: Blank

; framectl
FS		equ	0		; 0:DRAM0	/1: DRAM1
FEN		equ	1		; 0:access EN	/1: access DisEN

; _iflreg
IFL2		equ	0		; 0:No opration /1: SUBCPU INT
IEN2		equ	7		; 0:INT Mask	/1: INT Enable

; _memory
MODE		equ	2		; 0:2M mode	/1: 1M mode
DMNA		equ	1		; 0:Swap OK	/1: Swap request
RET		equ	0		; 0:Running	/1: Return Main

; _cdcmode
MAINREAD	equ	2		; Main CPU read
SUBREAD		equ	3		; Sub CPU read
PCMDMA		equ	4		; PCM DMA
PRGDMA		equ	5		; Program RAM DMA
WORDDMA		equ	7		; Word RAM DMA

EDT		equ	7		; End of Data Transfer
DSR		equ	6		; Data Set Ready

; sub_flug
S_READY		equ	7

; main_flug
M_READY		equ	7


;****************************************************************
;	end of file
;****************************************************************
