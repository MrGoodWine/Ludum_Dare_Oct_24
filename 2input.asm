6;------------------------------------------------------------------------
;-  Written by: Neviksti
;-     If you use my code, please share your creations with me
;-     as I am always curious :)
;------------------------------------------------------------------------

;JoyPad variables = $20 to $27

.ENUM $20
Joy0		DW
Joy1 		DW		; Current button state of joypad1, bit0=0 if it is a valid joypad
Joy2		DW		;same thing for all pads...
Joy3		DW
Joy4		DW
Joy5		DW

SJoy0		DW
SJoy1		DW
SJoy2		DW
SJoy3		DW
SJoy4		DW
SJoy5		DW
Spare0		DW
SRodent		DW
SJoy23Prs	DW
SJoy45Prs	DW



Joy1Press	DW		; Holds joypad1 keys that are pressed and have been pressed since clearing this mem location
Joy2Press	DW		;same thing for all pads...
Joy3Press	DW
Joy4Press	DW
Joy5Press	DW


.ENDE


.DEFINE HVBJOY	$4212
.DEFINE JOY0	$4218
.DEFINE JOY1	$421A
.DEFINE JOY2	$421C
.DEFINE JOY3	$421E
.DEFINE JOY0H	$4219
.DEFINE JOY1H	$421B
.DEFINE JOY2H	$421D
.DEFINE JOY3H	$421F
.DEFINE JOYSER0	$4016
.DEFINE JOYSER1	$4017
.DEFINE WRIO	$4201

; Button mask bits

.DEFINE BUTTON_B       	1 << 7
.DEFINE BUTTON_Y       	1 << 6
.DEFINE BUTTON_SELECT  	1 << 5
.DEFINE BUTTON_START   	1 << 4
.DEFINE BUTTON_UP      	1 << 3
.DEFINE BUTTON_DOWN    	1 << 2
.DEFINE BUTTON_LEFT    	1 << 1
.DEFINE BUTTON_RIGHT   	1 << 0
.DEFINE BUTTON_A      	1 << 3
.DEFINE BUTTON_X    	1 << 2
.DEFINE BUTTON_L    	1 << 1
.DEFINE BUTTON_R   		1 << 0



.BANK 0
.ORG HEADER_OFF
.SECTION "JoyInit" SEMIFREE

JoyInit:
	php	

	rep	#$10	;8 bit mem/A, 16 bit X/Y
	sep	#$20

	lda #$C0	;have the automatic read of the SNES read the first pair of JoyPads
	sta WRIO

	ldx #$0000
	stx Joy1Press
	stx Joy2Press
	stx Joy3Press
	stx Joy4Press
	stx Joy5Press

	LDA #$81
	STA $4200   ;Enable JoyPad Read and NMI



	plp
	rts
.ENDS

.BANK 0
.ORG HEADER_OFF
.SECTION "JoyInput" SEMIFREE

GetInput:

;
;       Read Multitap controller and mouse simultaneously
;
;       Code by Gau of the Veldt
;       (C) 1995 Gau of the Veldt
;       Freeware
;
;       Just mention me somewhere your greets or credits if you use
;       this code (the "special thanks" section is fine).
;
;       Email is nice too - you can even ask for help :)
;       gau@netbistro.com
;
;        Mixed labels: RAM locations
;       CAPPED labels: SNES Registers
;
;       JOYSER0/1 are $4016,$4017 respectively
;
           php
           sep #$30
-          lda HVBJOY
           bit #$01
           bne -                ;Wait for the controller states to get read
           lda JOY0H
           sta SJoy1+1
           lda JOY0
           sta SJoy1            ;Jport1/Mousebuttons is read directly
           and #$0F
           sta Spare0           ;Indicates a nonzero value here if something
           ldx #$10             ;else (ie: mouse) uses $4016 - at this point
-          lda JOYSER0          ;(and only this point) you can read this
           rep #$20             ;device
           lsr
           rol SRodent          ;Read one word thorugh $4016 bit 0
           sep #$20             ;serially into the rodent pseudoreg
           dex                  ;(I use a BIOS for my coding)
           bne  -
		   ldx SJoy1
		   cpx Joy1Press
		   beq +
		   stx Joy1Press
+		   ldx SJoy1+1
		   cpx Joy1Press+1
		   beq +
		   stx Joy1Press+1
+          lda JOY1H            ;Joyport two is read directly
           sta SJoy2+1          ;(ie: used $4219,1A)
           lda JOY1
           sta SJoy2
           and #$0F
           sta Spare0+1         ;Joyport three is read directly
           lda JOY3H            ;(Note you use $421E,1F, not $421C,1D)
           sta SJoy3+1
           lda JOY3
           sta SJoy3
           and #$0F
           sta SJoy23Prs+1      ;1's here indicate plugged-in controllers:
           sta SJoy23Prs        ;Bit 0: #2 plugged in, 8: #3 plugged in
           lda JOYSER1
           lsr
           rol SJoy23Prs
           lsr
           rol SJoy23Prs+1
           stz WRIO             ;Control of $4016,17 given to multitap
           ldy #$10
-          lda JOYSER1
           rep #$20
           lsr
           rol SJoy4            ;32 bits from $4017, read serially from
           lsr                  ;bit 0 and 1, will indicate the states of
           rol SJoy5            ;the last two controller ports.
           sep #$20             ;Bit 0 has the bits for Joyport four
           dey                  ;Bit 1 has the bits for Joyport five
           bne -
           lda SJoy4
           and #$0F
           sta SJoy45Prs        ;1's here inidicate plugged-in controller
           lda SJoy5            ;Bit 0: #4 plugged in, 8: #5 plugged in
           and #$0F
           sta SJoy45Prs+1
           sta SJoy45Prs
           lda JOYSER1
           lsr
           rol SJoy45Prs
           lsr
           rol SJoy45Prs+1
           lda #$80             ;Control of $4016(17) given back to mouse
           sta WRIO             ;Tricky - the tap spies on bit 7 of the
           plp                  ;         parallel port (meaning it can be
             rts                   ;         read at the controller too :)
	
	

.ENDS
