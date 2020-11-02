;****************************************************************
;	MARS MEGA-CD Boot Check Program
;					System Data
;
;	Copyright SEGA ENTERPRISES,LTD. 1994
;				SEGA ENTERPRISES,LTD.
;				CS Hardware R&D Dept.
;						T.Okawa
;---------------------------------------------------------------*
;
;****************************************************************

regdata:
		dc.b	$04,$24,SCR_A_TBL>>10,WINDOW_BASE>>10
		dc.b	SCR_B_TBL>>13,SPR_BASE>>9,$00,BGCOLOR
		dc.b	$00,$00,$00,$08
		dc.b	$81,HSCR_TBL>>10,$00,$02
		dc.b	$11,$00,$00,$ff
		dc.b	$ff,$00,$00,$80

_colordata:
	dc.w	$0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
	dc.w	$0000,$0000,$0000,$0000,$0222,$0000,$0888,$0eee

	dc.w	$0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
	dc.w	$0000,$0000,$0000,$0000,$0000,$0000,$0000,$008e

	dc.w	$00ee,$0000,$0a22,$0c42,$0e44,$0e66,$0eee,$0aaa
	dc.w	$0888,$0444,$08ae,$046a,$000e,$0008,$00ae,$008e

	dc.w	$0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
	dc.w	$0000,$0000,$0000,$0000,$0000,$0000,$0000,$0eee

asciidata:

; 20
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
;-
	dc.l	$000f0000
	dc.l	$000f0000
	dc.l	$000f0000
	dc.l	$000f0000
	dc.l	$000f0000
	dc.l	$00000000
	dc.l	$000f0000
	dc.l	$00000000
;-
	dc.l	$00f0f000
	dc.l	$00f0f000
	dc.l	$00f0f000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
;-
	dc.l	$00f00f00
	dc.l	$00f00f00
	dc.l	$0ffffff0
	dc.l	$00f00f00
	dc.l	$0ffffff0
	dc.l	$00f00f00
	dc.l	$00f00f00
	dc.l	$00000000
;-
	dc.l	$000f0000
	dc.l	$00ffff00
	dc.l	$0f0f0000
	dc.l	$00fff000
	dc.l	$000f0f00
	dc.l	$0ffff000
	dc.l	$000f0000
	dc.l	$00000000
;-
	dc.l	$00000000
	dc.l	$0ff000f0
	dc.l	$0ff00f00
	dc.l	$0000f000
	dc.l	$000f0000
	dc.l	$00f00ff0
	dc.l	$0f000ff0
	dc.l	$00000000
;-
	dc.l	$00ff0000
	dc.l	$0f00f000
	dc.l	$0f00f000
	dc.l	$00ff0000
	dc.l	$0f00f0f0
	dc.l	$0f000f00
	dc.l	$00fff0f0
	dc.l	$00000000
;-
	dc.l	$00ff0000
	dc.l	$000f0000
	dc.l	$00f00000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
;-
	dc.l	$0000f000
	dc.l	$000f0000
	dc.l	$00f00000
	dc.l	$00f00000
	dc.l	$00f00000
	dc.l	$000f0000
	dc.l	$0000f000
	dc.l	$00000000
;-
	dc.l	$00f00000
	dc.l	$000f0000
	dc.l	$0000f000
	dc.l	$0000f000
	dc.l	$0000f000
	dc.l	$000f0000
	dc.l	$00f00000
	dc.l	$00000000
;-
	dc.l	$000f0000
	dc.l	$0f0f0f00
	dc.l	$00fff000
	dc.l	$0fffff00
	dc.l	$00fff000
	dc.l	$0f0f0f00
	dc.l	$000f0000
	dc.l	$00000000
;-
	dc.l	$00000000
	dc.l	$000f0000
	dc.l	$000f0000
	dc.l	$0fffff00
	dc.l	$000f0000
	dc.l	$000f0000
	dc.l	$00000000
	dc.l	$00000000
;-
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00ff0000
	dc.l	$000f0000
	dc.l	$00f00000
	dc.l	$00000000
;-
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$0fffff00
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
;-
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00ff0000
	dc.l	$00ff0000
	dc.l	$00000000
	dc.l	$00000000
;-
	dc.l	$00000000
	dc.l	$000000f0
	dc.l	$00000f00
	dc.l	$0000f000
	dc.l	$000f0000
	dc.l	$00f00000
	dc.l	$0f000000
	dc.l	$00000000
;-
	dc.l	$00ffff00
	dc.l	$0f0000f0
	dc.l	$0f000ff0
	dc.l	$0f0ff0f0
	dc.l	$0ff000f0
	dc.l	$0f0000f0
	dc.l	$00ffff00
	dc.l	$00000000
;-
	dc.l	$000f0000
	dc.l	$00ff0000
	dc.l	$0f0f0000
	dc.l	$000f0000
	dc.l	$000f0000
	dc.l	$000f0000
	dc.l	$0fffff00
	dc.l	$00000000
;-
	dc.l	$00ffff00
	dc.l	$0f0000f0
	dc.l	$000000f0
	dc.l	$0000ff00
	dc.l	$00ff0000
	dc.l	$0f000000
	dc.l	$0ffffff0
	dc.l	$00000000
;-
	dc.l	$00ffff00
	dc.l	$0f0000f0
	dc.l	$000000f0
	dc.l	$00ffff00
	dc.l	$000000f0
	dc.l	$0f0000f0
	dc.l	$00ffff00
	dc.l	$00000000
;-
	dc.l	$00000f00
	dc.l	$0000ff00
	dc.l	$000f0f00
	dc.l	$00f00f00
	dc.l	$0ffffff0
	dc.l	$00000f00
	dc.l	$00000f00
	dc.l	$00000000
;-
	dc.l	$0ffffff0
	dc.l	$0f000000
	dc.l	$0ffff000
	dc.l	$00000f00
	dc.l	$000000f0
	dc.l	$0f000f00
	dc.l	$00fff000
	dc.l	$00000000
;-
	dc.l	$000fff00
	dc.l	$00f00000
	dc.l	$0f000000
	dc.l	$0fffff00
	dc.l	$0f0000f0
	dc.l	$0f0000f0
	dc.l	$00ffff00
	dc.l	$00000000
;-
	dc.l	$0ffffff0
	dc.l	$0f0000f0
	dc.l	$00000f00
	dc.l	$0000f000
	dc.l	$000f0000
	dc.l	$000f0000
	dc.l	$000f0000
	dc.l	$00000000
;-
	dc.l	$00ffff00
	dc.l	$0f0000f0
	dc.l	$0f0000f0
	dc.l	$00ffff00
	dc.l	$0f0000f0
	dc.l	$0f0000f0
	dc.l	$00ffff00
	dc.l	$00000000
;-
	dc.l	$00ffff00
	dc.l	$0f0000f0
	dc.l	$0f0000f0
	dc.l	$00fffff0
	dc.l	$000000f0
	dc.l	$00000f00
	dc.l	$00fff000
	dc.l	$00000000
;-
	dc.l	$00000000
	dc.l	$00ff0000
	dc.l	$00ff0000
	dc.l	$00000000
	dc.l	$00ff0000
	dc.l	$00ff0000
	dc.l	$00000000
	dc.l	$00000000
;-
	dc.l	$00000000
	dc.l	$00ff0000
	dc.l	$00ff0000
	dc.l	$00000000
	dc.l	$00ff0000
	dc.l	$000f0000
	dc.l	$00f00000
	dc.l	$00000000
;-
	dc.l	$0000fff0
	dc.l	$000ff000
	dc.l	$00ff0000
	dc.l	$0ff00000
	dc.l	$00ff0000
	dc.l	$000ff000
	dc.l	$0000fff0
	dc.l	$00000000
;-
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$0ffffff0
	dc.l	$00000000
	dc.l	$0ffffff0
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
;-
	dc.l	$0fff0000
	dc.l	$000ff000
	dc.l	$0000ff00
	dc.l	$00000ff0
	dc.l	$0000ff00
	dc.l	$000ff000
	dc.l	$0fff0000
	dc.l	$00000000
;-
	dc.l	$00ffff00
	dc.l	$0f0000f0
	dc.l	$000000f0
	dc.l	$0000ff00
	dc.l	$000f0000
	dc.l	$00000000
	dc.l	$000f0000
	dc.l	$00000000
;-
	dc.l	$000fff00
	dc.l	$00f000f0
	dc.l	$0f00f0f0
	dc.l	$0f0f0ff0
	dc.l	$0f00ff00
	dc.l	$00f00000
	dc.l	$000ffff0
	dc.l	$00000000
;-
	dc.l	$000ff000
	dc.l	$00f00f00
	dc.l	$0f0000f0
	dc.l	$0ffffff0
	dc.l	$0f0000f0
	dc.l	$0f0000f0
	dc.l	$0f0000f0
	dc.l	$00000000
;-
	dc.l	$0fffff00
	dc.l	$0f0000f0
	dc.l	$0f0000f0
	dc.l	$0fffff00
	dc.l	$0f0000f0
	dc.l	$0f0000f0
	dc.l	$0fffff00
	dc.l	$00000000
;-
	dc.l	$000fff00
	dc.l	$00f000f0
	dc.l	$0f000000
	dc.l	$0f000000
	dc.l	$0f000000
	dc.l	$00f000f0
	dc.l	$000fff00
	dc.l	$00000000
;-
	dc.l	$0ffff000
	dc.l	$00f00f00
	dc.l	$00f000f0
	dc.l	$00f000f0
	dc.l	$00f000f0
	dc.l	$00f00f00
	dc.l	$0ffff000
	dc.l	$00000000
;-
	dc.l	$0ffffff0
	dc.l	$0f000000
	dc.l	$0f000000
	dc.l	$0ffff000
	dc.l	$0f000000
	dc.l	$0f000000
	dc.l	$0ffffff0
	dc.l	$00000000
;-
	dc.l	$0ffffff0
	dc.l	$0f000000
	dc.l	$0f000000
	dc.l	$0ffff000
	dc.l	$0f000000
	dc.l	$0f000000
	dc.l	$0f000000
	dc.l	$00000000
;-
	dc.l	$000fff00
	dc.l	$00f000f0
	dc.l	$0f000000
	dc.l	$0f00fff0
	dc.l	$0f0000f0
	dc.l	$00f000f0
	dc.l	$000fff00
	dc.l	$00000000
;-
	dc.l	$0f0000f0
	dc.l	$0f0000f0
	dc.l	$0f0000f0
	dc.l	$0ffffff0
	dc.l	$0f0000f0
	dc.l	$0f0000f0
	dc.l	$0f0000f0
	dc.l	$00000000
;-
	dc.l	$00fff000
	dc.l	$000f0000
	dc.l	$000f0000
	dc.l	$000f0000
	dc.l	$000f0000
	dc.l	$000f0000
	dc.l	$00fff000
	dc.l	$00000000
;-
	dc.l	$0000fff0
	dc.l	$00000f00
	dc.l	$00000f00
	dc.l	$00000f00
	dc.l	$00000f00
	dc.l	$0f000f00
	dc.l	$00fff000
	dc.l	$00000000
;-
	dc.l	$0f0000f0
	dc.l	$0f000f00
	dc.l	$0f00f000
	dc.l	$0fff0000
	dc.l	$0f00f000
	dc.l	$0f000f00
	dc.l	$0f0000f0
	dc.l	$00000000
;-
	dc.l	$0f000000
	dc.l	$0f000000
	dc.l	$0f000000
	dc.l	$0f000000
	dc.l	$0f000000
	dc.l	$0f000000
	dc.l	$0ffffff0
	dc.l	$00000000
;-
	dc.l	$0f0000f0
	dc.l	$0ff00ff0
	dc.l	$0f0ff0f0
	dc.l	$0f0ff0f0
	dc.l	$0f0000f0
	dc.l	$0f0000f0
	dc.l	$0f0000f0
	dc.l	$00000000
;-
	dc.l	$0f0000f0
	dc.l	$0ff000f0
	dc.l	$0f0f00f0
	dc.l	$0f00f0f0
	dc.l	$0f000ff0
	dc.l	$0f0000f0
	dc.l	$0f0000f0
	dc.l	$00000000
;-
	dc.l	$000ff000
	dc.l	$00f00f00
	dc.l	$0f0000f0
	dc.l	$0f0000f0
	dc.l	$0f0000f0
	dc.l	$00f00f00
	dc.l	$000ff000
	dc.l	$00000000
;-
	dc.l	$0fffff00
	dc.l	$0f0000f0
	dc.l	$0f0000f0
	dc.l	$0fffff00
	dc.l	$0f000000
	dc.l	$0f000000
	dc.l	$0f000000
	dc.l	$00000000
;-
	dc.l	$000ff000
	dc.l	$00f00f00
	dc.l	$0f0000f0
	dc.l	$0f0000f0
	dc.l	$0f00f0f0
	dc.l	$00f00f00
	dc.l	$000ff0f0
	dc.l	$00000000
;-
	dc.l	$0fffff00
	dc.l	$0f0000f0
	dc.l	$0f0000f0
	dc.l	$0fffff00
	dc.l	$0f00f000
	dc.l	$0f000f00
	dc.l	$0f0000f0
	dc.l	$00000000
;-
	dc.l	$00ffff00
	dc.l	$0f0000f0
	dc.l	$0f000000
	dc.l	$00ffff00
	dc.l	$000000f0
	dc.l	$0f0000f0
	dc.l	$00ffff00
	dc.l	$00000000
;-
	dc.l	$0fffff00
	dc.l	$000f0000
	dc.l	$000f0000
	dc.l	$000f0000
	dc.l	$000f0000
	dc.l	$000f0000
	dc.l	$000f0000
	dc.l	$00000000
;-
	dc.l	$0f0000f0
	dc.l	$0f0000f0
	dc.l	$0f0000f0
	dc.l	$0f0000f0
	dc.l	$0f0000f0
	dc.l	$0f0000f0
	dc.l	$00ffff00
	dc.l	$00000000
;-
	dc.l	$0f0000f0
	dc.l	$0f0000f0
	dc.l	$0f0000f0
	dc.l	$00f00f00
	dc.l	$00f00f00
	dc.l	$000ff000
	dc.l	$000ff000
	dc.l	$00000000
;-
	dc.l	$0f0000f0
	dc.l	$0f0000f0
	dc.l	$0f0000f0
	dc.l	$0f0ff0f0
	dc.l	$0f0ff0f0
	dc.l	$0ff00ff0
	dc.l	$0f0000f0
	dc.l	$00000000
;-
	dc.l	$0f0000f0
	dc.l	$0f0000f0
	dc.l	$00f00f00
	dc.l	$000ff000
	dc.l	$00f00f00
	dc.l	$0f0000f0
	dc.l	$0f0000f0
	dc.l	$00000000
;-
	dc.l	$0f000f00
	dc.l	$0f000f00
	dc.l	$0f000f00
	dc.l	$00fff000
	dc.l	$000f0000
	dc.l	$000f0000
	dc.l	$000f0000
	dc.l	$00000000
;-
	dc.l	$0ffffff0
	dc.l	$000000f0
	dc.l	$00000f00
	dc.l	$000ff000
	dc.l	$00f00000
	dc.l	$0f000000
	dc.l	$0ffffff0
	dc.l	$00000000
;-
	dc.l	$00ffff00
	dc.l	$00f00000
	dc.l	$00f00000
	dc.l	$00f00000
	dc.l	$00f00000
	dc.l	$00f00000
	dc.l	$00ffff00
	dc.l	$00000000
;-
	dc.w	$0000,$0000,$ff00,$0000,$0ff0,$0000,$00ff,$0000	;Å_
	dc.w	$000f,$f000,$0000,$ff00,$0000,$0ff0,$0000,$0000

;	dc.l	$0f000f00
;	dc.l	$00f0f000
;	dc.l	$0fffff00
;	dc.l	$000f0000
;	dc.l	$0fffff00
;	dc.l	$000f0000
;	dc.l	$000f0000
;	dc.l	$00000000
;-
	dc.l	$0ffff000
	dc.l	$0000f000
	dc.l	$0000f000
	dc.l	$0000f000
	dc.l	$0000f000
	dc.l	$0000f000
	dc.l	$0ffff000
	dc.l	$00000000
;-
	dc.l	$000f0000
	dc.l	$00f0f000
	dc.l	$0f000f00
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
;-
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$0ffffff0
	dc.l	$00000000
;-
	dc.l	$00f00000
	dc.l	$000f0000
	dc.l	$0000f000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
;-
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00ffff00
	dc.l	$00000f00
	dc.l	$00ffff00
	dc.l	$0f000f00
	dc.l	$00fff0f0
	dc.l	$00000000
;-
	dc.l	$0f000000
	dc.l	$0f000000
	dc.l	$0f0fff00
	dc.l	$0ff000f0
	dc.l	$0f0000f0
	dc.l	$0ff000f0
	dc.l	$0f0fff00
	dc.l	$00000000
;-
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00ffff00
	dc.l	$0f0000f0
	dc.l	$0f000000
	dc.l	$0f0000f0
	dc.l	$00ffff00
	dc.l	$00000000
;-
	dc.l	$000000f0
	dc.l	$000000f0
	dc.l	$00fff0f0
	dc.l	$0f000ff0
	dc.l	$0f0000f0
	dc.l	$0f000ff0
	dc.l	$00fff0f0
	dc.l	$00000000
;-
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00ffff00
	dc.l	$0f0000f0
	dc.l	$0ffffff0
	dc.l	$0f000000
	dc.l	$00ffff00
	dc.l	$00000000
;-
	dc.l	$0000ff00
	dc.l	$000f0000
	dc.l	$000f0000
	dc.l	$0fffff00
	dc.l	$000f0000
	dc.l	$000f0000
	dc.l	$000f0000
	dc.l	$00000000
;-
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00fff0f0
	dc.l	$0f000ff0
	dc.l	$0f000ff0
	dc.l	$00fff0f0
	dc.l	$000000f0
	dc.l	$00ffff00
;-
	dc.l	$0f000000
	dc.l	$0f000000
	dc.l	$0f0fff00
	dc.l	$0ff000f0
	dc.l	$0f0000f0
	dc.l	$0f0000f0
	dc.l	$0f0000f0
	dc.l	$00000000
;-
	dc.l	$000f0000
	dc.l	$00000000
	dc.l	$00ff0000
	dc.l	$000f0000
	dc.l	$000f0000
	dc.l	$000f0000
	dc.l	$00fff000
	dc.l	$00000000
;-
	dc.l	$00000f00
	dc.l	$00000000
	dc.l	$0000ff00
	dc.l	$00000f00
	dc.l	$00000f00
	dc.l	$00000f00
	dc.l	$0f000f00
	dc.l	$00fff000
;-
	dc.l	$0f000000
	dc.l	$0f000000
	dc.l	$0f000f00
	dc.l	$0f00f000
	dc.l	$0f0f0000
	dc.l	$0ff0f000
	dc.l	$0f000f00
	dc.l	$00000000
;-
	dc.l	$00ff0000
	dc.l	$000f0000
	dc.l	$000f0000
	dc.l	$000f0000
	dc.l	$000f0000
	dc.l	$000f0000
	dc.l	$00fff000
	dc.l	$00000000
;-
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$fff0ff00
	dc.l	$f00f00f0
	dc.l	$f00f00f0
	dc.l	$f00f00f0
	dc.l	$f00f00f0
	dc.l	$00000000
;-
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$0f0fff00
	dc.l	$0ff000f0
	dc.l	$0f0000f0
	dc.l	$0f0000f0
	dc.l	$0f0000f0
	dc.l	$00000000
;-
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00ffff00
	dc.l	$0f0000f0
	dc.l	$0f0000f0
	dc.l	$0f0000f0
	dc.l	$00ffff00
	dc.l	$00000000
;-
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$0f0fff00
	dc.l	$0ff000f0
	dc.l	$0ff000f0
	dc.l	$0f0fff00
	dc.l	$0f000000
	dc.l	$0f000000
;-
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00fff0f0
	dc.l	$0f000ff0
	dc.l	$0f000ff0
	dc.l	$00fff0f0
	dc.l	$000000f0
	dc.l	$000000f0
;-
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$0f0fff00
	dc.l	$0ff000f0
	dc.l	$0f000000
	dc.l	$0f000000
	dc.l	$0f000000
	dc.l	$00000000
;-
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00fffff0
	dc.l	$0f000000
	dc.l	$00ffff00
	dc.l	$000000f0
	dc.l	$0fffff00
	dc.l	$00000000
;-
	dc.l	$000f0000
	dc.l	$000f0000
	dc.l	$0fffff00
	dc.l	$000f0000
	dc.l	$000f0000
	dc.l	$000f00f0
	dc.l	$0000ff00
	dc.l	$00000000
;-
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$0f0000f0
	dc.l	$0f0000f0
	dc.l	$0f0000f0
	dc.l	$0f000ff0
	dc.l	$00fff0f0
	dc.l	$00000000
;-
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$0f0000f0
	dc.l	$0f0000f0
	dc.l	$0f0000f0
	dc.l	$00f00f00
	dc.l	$000ff000
	dc.l	$00000000
;-
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$f00000f0
	dc.l	$f00f00f0
	dc.l	$f00f00f0
	dc.l	$f00f00f0
	dc.l	$0ff0ff00
	dc.l	$00000000
;-
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$0f0000f0
	dc.l	$00f00f00
	dc.l	$000ff000
	dc.l	$00f00f00
	dc.l	$0f0000f0
	dc.l	$00000000
;-
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$0f0000f0
	dc.l	$0f0000f0
	dc.l	$0f000ff0
	dc.l	$00fff0f0
	dc.l	$000000f0
	dc.l	$00ffff00
;-
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$0ffffff0
	dc.l	$00000f00
	dc.l	$000ff000
	dc.l	$00f00000
	dc.l	$0ffffff0
	dc.l	$00000000
;-
	dc.l	$000ff000
	dc.l	$00f00000
	dc.l	$00f00000
	dc.l	$0f000000
	dc.l	$00f00000
	dc.l	$00f00000
	dc.l	$000ff000
	dc.l	$00000000
;-
	dc.l	$000ff000
	dc.l	$000ff000
	dc.l	$000ff000
	dc.l	$000ff000
	dc.l	$000ff000
	dc.l	$000ff000
	dc.l	$000ff000
	dc.l	$00000000
;-
	dc.l	$00ff0000
	dc.l	$0000f000
	dc.l	$0000f000
	dc.l	$00000f00
	dc.l	$0000f000
	dc.l	$0000f000
	dc.l	$00ff0000
	dc.l	$00000000
;-
	dc.l	$00000000
	dc.l	$0ffffff0
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
;-
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$000000f0
	dc.l	$0fffff00
	dc.l	$f0f0f000
	dc.l	$00f0f000
	dc.l	$00f0ff00
	dc.l	$00000000

;****************************************************************
;	end of file
;****************************************************************
