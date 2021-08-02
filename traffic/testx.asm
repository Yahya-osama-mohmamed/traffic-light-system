$NOMOD51	 ;to suppress the pre-defined addresses by keil
$include (C8051F020.h)		; to declare the device peripherals	with it's addresses
ORG 0H					   ; to start writing the code from the base 0


;diable the watch dog
MOV WDTCN,#11011110B ;0DEH
MOV WDTCN,#10101101B ;0ADH

; config of clock
MOV OSCICN , #14H ; 2MH clock
;config cross bar
MOV XBR0 , #00H
MOV XBR1 , #00H
MOV XBR2 , #040H  ; Cross bar enabled , weak Pull-up enabled 

;config,setup
MOV P0MDOUT, #00h
MOV P1MDOUT, #01h
MOV P2MDOUT, #0FFh

MOV P1,#01H 
;loop

;FREQ:
 ;    JB P0.0, SPEED1
     ;JB P0.1, SPEED2
		 ;JB P0.2, SPEED3


;SPEED1:
;MOV 420, #1
;AJMP START

	


START: 	
	CLR A
	MOV A,#00111000B
	ANL A,P0
	RR A
	RR A
	MOV R4,A
	;MOV R4,10
				MOV R5,#10
				MOV DPH, #04h	
				MOV DPL, #00h	

COUNT:	MOV DPL,R4
				CLR A
				MOVC A,@A+DPTR
				MOV P2,A
				LOOP5:
							MOV DPL,R5
							CLR A
							MOVC A,@A+DPTR
							MOV P3,A
							ACALL DELAY
							DJNZ R5,LOOP5
				MOV R5,#10



			


;SWITCH: MOV P1,P0
;				AJMP CONT

MAIN:
				;AJMP SWITCH
				CONT:
					DJNZ R4, COUNT
					CPL P1.0
					CPL P1.1
					AJMP START
					AJMP MAIN

DELAY :
	CLR A
	MOV A,#00000111B
	ANL A,P0
	RL A
	MOV R2,A
	LOOP3:MOV R1,#50
	LOOP2:MOV R0,#198
	LOOP1:DJNZ R0,LOOP1
	DJNZ R1,LOOP2
	DJNZ R2,LOOP3
	RET




ORG 401H
DB 3FH,06H,5BH,4FH,66H,6DH,7DH,07H,7FH,6FH