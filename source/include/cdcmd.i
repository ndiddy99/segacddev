;****************************************************************
;	Sega CD Freeloader: CD Commands
;
;	Copyright Nathan Misner
;
;	Command enumerations
;---------------------------------------------------------------;
;						Created 11/1/20
;****************************************************************

;---------------------------------------------------------------;
;	Sub CPU commands (sent to command_0, ack from status_0)
;---------------------------------------------------------------;

CMD_LOADINTER	equ 0 ;load the main CPU interface code into word ram
CMD_OPENDRV	equ 1 ;open the cd drive
CMD_CLOSEDRV	equ 2 ;close the cd drive
CMD_DRVSTATUS	equ 3 ;get the drive status
CMD_LOADMAIN	equ 4 ;load the main CPU code off the disc 
CMD_LOADSUB	equ 5 ;load the sub CPU code off the disc and start execution

;---------------------------------------------------------------;
;	Command results (read from status_2)
;---------------------------------------------------------------;
RES_WAIT	equ 0 ;command recieved and in progress
RES_OK		equ 1 ;if the command succeeded
RES_ERR		equ 2 ;if the command failed

;---------------------------------------------------------------;
;	Drive status results (for CMD_DRVSTATUS, read from status_2)
;---------------------------------------------------------------;
DRV_OPEN	equ 0 ;if the drive is open
DRV_DISC	equ 1 ;if there's a disc in the drive
DRV_EMPTY	equ 2 ;if the drive is empty

;---------------------------------------------------------------;
;	Sub CPU flags (sent to command_2)
;---------------------------------------------------------------;
FLG_ACTIVATE	equ "HI" ;tell sub cpu to run the command in command_0
