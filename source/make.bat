@echo off

SET ROOT_DIR=c:\segacd
SET ASM_DIR=%ROOT_DIR%\tools
SET INCLUDE_PATH=%ROOT_DIR%\source
SET ASM_FLAGS=/p /j %INCLUDE_PATH%

ECHO Building main program
%ASM_DIR%\asm68k.exe %ASM_FLAGS% program\program.s, program\program.bin, program\program.sym, program\program.lst
%ASM_DIR%\asm68k.exe %ASM_FLAGS% program\loader.s, filesystem\IPL.BIN

ECHO Building Filesystem
%ASM_DIR%\mkisofs -iso-level 1 -o filesystem.img -pad filesystem
%ASM_DIR%\trimfsimage filesystem.img filesystem.bin
del filesystem.img

ECHO Building IP
%ASM_DIR%\asm68k.exe %ASM_FLAGS% ip\ip_prg.s, ip_prg.bin

ECHO Building SP
%ASM_DIR%\asm68k.exe %ASM_FLAGS% sp\sp_prg.s, sp_prg.bin, sp\sp_prg.sym, sp\sp_prg.lst

ECHO Building CD
%ASM_DIR%\asm68k.exe %ASM_FLAGS% main.s, main.iso

pause

cd ..\tools\mame
mame64.exe segacd -cdrm ..\..\source\main.iso -debug