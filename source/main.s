;****************************************************************
;	Sega CD Freeloader: Main source file
;
;	Copyright Nathan Misner
;
;---------------------------------------------------------------;
;						Created 11/1/20
;****************************************************************

;include
	include include\cdmap.i

system_ID: ;CD Header data
;			"0123456789ABCDEF"
		dc.b	"SEGADISCSYSTEM  "	;Disc ID
		dc.b	"MEGACDCHECK",0		;Disc Volume name
		dc.w		$0000		;Volume Version
		dc.w			$1	;volume type
		dc.b	"MEGA-CD    ",0		;System name
		dc.w		$0000,0		;system Version,0
		;disc address, load size, entry offset, work ram
		dc.l	$800,$800,0,$8000	;IP
		dc.l	$1000,$7800,0,$40000	;SP
		;SYSTEM reservation area
		dc.b	"                "
		dc.b	"                "
		dc.b	"                "
		dc.b	"                "
		dc.b	"                "
		dc.b	"                "
		dc.b	"                "
		dc.b	"                "
		dc.b	"                "
		dc.b	"                "
		dc.b	"                "
		
Disc_ID:
;			"0123456789ABCDEF"
		dc.b	"SEGA MEGA DRIVE "	;Hardware system ID
		dc.b	"(C)SEGA 1994.JUL"	;Company code, Release date
						; Game name for Japan
		dc.b	"MARS CHECK CDROM CHECK PROGRAM VERSION 1.0      "
						; Game name for other country
		dc.b	"MARS CHECK CDROM CHECK PROGRAM VERSION 1.0      "
		dc.b	"XX 00000000-00  "	;Disc kind, good number, version number
		dc.b	"J               "	;I/O support
		dc.b	"                "
		dc.b	"            "  
		dc.b	"            " 		;MODEM information
		dc.b	"        "
		dc.b	"                "
		dc.b	"                "
		dc.b	"J               "	;COUNTRY

;---------------------------------------------------------------;
;	Security program
;---------------------------------------------------------------;
	include secus.i
	
;---------------------------------------------------------------;
;	IP program (main cpu)
;---------------------------------------------------------------;
	align $800
	incbin ip_prg.bin
	
;---------------------------------------------------------------;
;	SP program (sub cpu)
;---------------------------------------------------------------;
	align $1000
	incbin sp_prg.bin
	
;---------------------------------------------------------------;
;	Boot area padding
;---------------------------------------------------------------;
	align $8000
	
;---------------------------------------------------------------;
;	CD Filesystem
;---------------------------------------------------------------;
	incbin filesystem.bin
	align $2000000

;****************************************************************
;	end of file
;****************************************************************

