;***************************************************************;
;	MARS MEGA-CD Boot Check Program
;					ISSO9660 asign
;
;	Copyright SEGA ENTERPRISES,LTD. 1994
;				SEGA ENTERPRISES,LTD.
;				CS Hardware R&D Dept.
;						T.Okawa
;---------------------------------------------------------------;
;
;***************************************************************;


;---------- ISSO9660 Primary Volume Descriptor -----------------;

vdtype		equ	0
stdident	equ	1
volumename	equ	40
rootdirentry	equ	156


;---------- ISSO9660 Format of a Directory Record --------------;

extentLSN	equ	6
filelen		equ	14


;***************************************************************;
;	end of file
;***************************************************************;
