;------------------------------------------------------------------------
;-  Written by: Neviksti
;-     If you use my code, please share your creations with me
;-     as I am always curious :)
;------------------------------------------------------------------------

;temporary sprite buffer1 ($0400-$061F)
.DEFINE SpriteBuf1	$0400
.DEFINE SpriteBuf2	$0600


.DEFINE sx1	   				0
.DEFINE sy1	   				1
.DEFINE stile1				2
.DEFINE sprioritypalette1	3
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

.DEFINE px1	   				16
.DEFINE py1	   				17
.DEFINE ptile1				18
.DEFINE pprioritypalette1	19
.DEFINE px2	   				20
.DEFINE py2	   				21
.DEFINE ptile2				22
.DEFINE pprioritypalette2	23
.DEFINE px3	   				24
.DEFINE py3	   				25
.DEFINE ptile3				26
.DEFINE pprioritypalette3	27
.DEFINE px4	   				28
.DEFINE py4	   				29
.DEFINE ptile4				30
.DEFINE pprioritypalette4	31

.DEFINE bx1	   				32
.DEFINE by1	   				33
.DEFINE btile1				34
.DEFINE bprioritypalette1	35
.DEFINE bx2	   				36
.DEFINE by2	   				37
.DEFINE btile2				38
.DEFINE bprioritypalette2	39
.DEFINE bx3	   				40
.DEFINE by3	   				41
.DEFINE btile3				42
.DEFINE bprioritypalette3	43
.DEFINE bx4	   				44
.DEFINE by4	   				45
.DEFINE btile4				46
.DEFINE bprioritypalette4	47





.BANK 0
.SECTION "SpriteInit"

SpriteInit:
	php	

	rep	#$30	;16bit mem/A, 16 bit X/Y

	ldx #$0000
	lda #$AAAA
_clr:
	sta SpriteBuf2, x		;initialize all sprites to be off the screen
	inx
	inx
	cpx #$0020
	bne _clr	
	
	
	ldx #$0000
	lda #$eeee
_clr2:
	sta SpriteBuf1, x		;initialize all sprites to be off the screen
	inx
	inx
	cpx #$0200
	bne _clr2	

	plp
	rts

;==========================================================================================

SpriteUpdate:

	sep #$30
	

;Player1
	lda player.1.spriteX_Lo
	sta SpriteBuf1+sx1
	lda player.1.spriteY_Lo
	sta SpriteBuf1+sy1
	lda player.1.animationFrame
	sta SpriteBuf1+stile1
	lda player.1.priorityPalette		
	sta SpriteBuf1+sprioritypalette1

;Player2	
	lda player.2.spriteX_Lo
	sta SpriteBuf1+sx2
	lda player.2.spriteY_Lo
	sta SpriteBuf1+sy2
	lda player.2.animationFrame
	sta SpriteBuf1+stile2
	lda player.2.priorityPalette			
	sta SpriteBuf1+sprioritypalette2
	
;Player3	
	lda player.3.spriteX_Lo
	sta SpriteBuf1+sx3
	lda player.3.spriteY_Lo
	sta SpriteBuf1+sy3
	lda player.3.animationFrame
	sta SpriteBuf1+stile3
	lda player.3.priorityPalette			
	sta SpriteBuf1+sprioritypalette3
	
;Player4	
	lda player.4.spriteX_Lo
	sta SpriteBuf1+sx4
	lda player.4.spriteY_Lo
	sta SpriteBuf1+sy4
	lda player.4.animationFrame
	sta SpriteBuf1+stile4
	lda player.4.priorityPalette			
	sta SpriteBuf1+sprioritypalette4

;Pollen1	
	;SpawnPollen $D3, $E5
	lda pollenX1
	sta SpriteBuf1+px1
	lda pollenY1
	sta SpriteBuf1+py1
	lda pollenTile1
	sta SpriteBuf1+ptile1
	lda pollenPal1			
	sta SpriteBuf1+pprioritypalette1
	
;Pollen2	
	;SpawnPollen $D3, $E5
	lda pollenX2
	sta SpriteBuf1+px2
	lda pollenY2
	sta SpriteBuf1+py2
	lda pollenTile2
	sta SpriteBuf1+ptile2
	lda pollenPal2			
	sta SpriteBuf1+pprioritypalette2
	
;Pollen3	
	;SpawnPollen $D3, $E5
	lda pollenX3
	sta SpriteBuf1+px3
	lda pollenY3
	sta SpriteBuf1+py3
	lda pollenTile3
	sta SpriteBuf1+ptile3
	lda pollenPal3			
	sta SpriteBuf1+pprioritypalette3
	
;Pollen4	
	;SpawnPollen $D3, $E5
	lda pollenX4
	sta SpriteBuf1+px4
	lda pollenY4
	sta SpriteBuf1+py4
	lda pollenTile4
	sta SpriteBuf1+ptile4
	lda pollenPal4			
	sta SpriteBuf1+pprioritypalette4
	
	rts

.ends

