;***************************************************************;
;	MARS MEGA-CD Boot Check Program
;					Program RAM assign
;
;	Copyright SEGA ENTERPRISES,LTD. 1994
;				SEGA ENTERPRISES,LTD.
;				CS Hardware R&D Dept.
;						T.Okawa
;---------------------------------------------------------------;
;
;***************************************************************;

; label		      ; address	; size		; info.

ap_program_area	equ	$10000	; $50000	; child process area
v_counter	equ	$60000	; word		; v interrupt counter
retry_counter	equ	$60002	; word		; retry counter

cdcbuffer	equ	$68000	; -> $6ffff	; cdc buffer ( MAX 16 sector)
volumebuffer	equ	$70000	; -> $7ffff	; isso9660 volume data buffer


;***************************************************************;
;	end of file
;***************************************************************;
