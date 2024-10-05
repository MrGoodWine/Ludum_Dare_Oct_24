;------------------------------------------------------------------------
;-  Written by: Neviksti
;-     If you use my code, please share your creations with me
;-     as I am always curious :)
;------------------------------------------------------------------------

;temporary sprite buffer1 ($0400-$061F)
.DEFINE SpriteBuf1	$0400
.DEFINE SpriteBuf2	$0420
.DEFINE SpriteBuf3	$0600
.DEFINE SpriteBuf4	$0620


.DEFINE sx	   		$1
.DEFINE sy	   		$0
.DEFINE sframe 		2
.DEFINE spriority		3

.BANK 0
.SECTION "SpriteInit"

SpriteInit:
	php	

	rep	#$30	;16bit mem/A, 16 bit X/Y

	ldx #$0000
	lda #$efef
_clr:
	sta SpriteBuf2, x		;initialize all sprites to be off the screen
	inx
	inx
	cpx #$0200
	bne _clr	
	ldx #$0000
	lda #$5555
;_clr2:
;	sta SpriteBuf3, x		;initialize all sprites to be off the screen
;	inx
;	inx
;	cpx #$0020
;	bne _clr2	

	plp
	rts
.ENDS
;==========================================================================================
