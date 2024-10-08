;------------------------------------------------------------------------
;-  Written by: Neviksti
;-     If you use my code, please share your creations with me
;-     as I am always curious :)
;------------------------------------------------------------------------

;temporary sprite buffer1 ($0400-$061F)
.DEFINE SpriteBuf1	$0400
.DEFINE SpriteBuf2	$0600


.DEFINE sx	   				0
.DEFINE sy	   				1
.DEFINE stile				2
.DEFINE sprioritypalette	3
.DEFINE sx2	   				4
.DEFINE sy2	   				5
.DEFINE stile2				6
.DEFINE sprioritypalette2	7
.DEFINE sx3	   				8
.DEFINE sy3	   				9
.DEFINE stile3				10
.DEFINE sprioritypalette3	11
.DEFINE sx4	   				12
.DEFINE sy4	   				13
.DEFINE stile4				14
.DEFINE sprioritypalette4	15
.DEFINE sframe 				2


.BANK 0
.SECTION "SpriteInit"

SpriteInit:
	php	

	rep	#$30	;16bit mem/A, 16 bit X/Y

	ldx #$0000
	lda #$ffff
_clr:
	sta SpriteBuf1, x
	sta SpriteBuf2, x		;initialize all sprites to be off the screen
	inx
	inx
	cpx #$0020
	bne _clr	

	plp
	rts
.ENDS
;==========================================================================================
