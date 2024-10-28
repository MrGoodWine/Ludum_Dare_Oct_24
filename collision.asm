;================================================================		
;================================================================	
;================================================================	
.bank 0 slot 0
.org 0
.section "Collision Routine"  


CollisionCalc: 


;player 1 Bounding Box
		lda player.1.positionY_Lo
		adc #$00
		sta player.1.topBBox
		
		lda player.1.positionX_Lo
		adc #$00
		sta player.1.leftBBox
		
		lda player.1.positionY_Lo
		adc #$20
		sta player.1.bottomBBox
		
		lda player.1.positionX_Lo
		adc #$20
		sta player.1.rightBBox
		
		
		
;player 2 Bounding Box		
		lda player.2.positionY_Lo
		adc #$00
		sta player.2.topBBox
		
		lda player.2.positionX_Lo
		adc #$00
		sta player.2.leftBBox
		
		lda player.2.positionY_Lo
		adc #$20
		sta player.2.bottomBBox
		
		lda player.2.positionX_Lo
		adc #$20
		sta player.2.rightBBox
		
		
		
		
;player 3 Bounding Box		
		lda player.3.positionY_Lo
		adc #$04
		sta player.3.topBBox
		
		lda player.3.positionX_Lo
		adc #$04
		sta player.3.leftBBox
		
		lda player.3.positionY_Lo
		adc #$0C
		sta player.3.bottomBBox
		
		lda player.3.positionX_Lo
		adc #$0C
		sta player.3.rightBBox
		
		
;player 4 Bounding Box		
		lda player.4.positionY_Lo
		adc #$04
		sta player.4.topBBox
		
		lda player.4.positionX_Lo
		adc #$04
		sta player.4.leftBBox

		lda player.4.positionY_Lo
		adc #$0C
		sta player.4.bottomBBox
		
		lda player.4.positionX_Lo
		adc #$0C
		sta player.4.rightBBox
		
		
;player 1 checks	Check whether their own Top left corner / Bottom right corner is within another BBox
		
		
;@p1vsp2:

;@p1p2TopLftBBox:
		lda player.1.topBBox
		cmp player.2.topBBox
		bmi @p1p2BotRgtBBox  ;Minus is higher on screen thus not within a BBox
		lda player.1.leftBBox
		cmp player.2.leftBBox
		bmi @p1p2BotRgtBBox  ;Minus is further left on screen thus not within a BBox
		
		lda player.1.topBBox
		cmp player.2.bottomBBox
		bpl @p1p2BotRgtBBox  
		lda player.1.leftBBox
		cmp player.2.rightBBox
		bpl @p1p2BotRgtBBox  
		
		
		
		lda player.1.isColliding
		ora #$02
		sta player.1.isColliding
		
		lda player.2.isColliding
		ora #$01
		sta player.2.isColliding
		rts
		
@p1p2BotRgtBBox:		
		lda player.1.bottomBBox
		cmp player.2.bottomBBox
		bpl @p1vsp3  ;Plus is lower on screen thus not within a BBox
		lda player.1.rightBBox
		cmp player.2.rightBBox
		bpl @p1vsp3  ;Plus is further right on screen thus not within a BBox
		
		
		lda player.1.bottomBBox
		cmp player.2.topBBox
		bmi @p1vsp3  ;Plus is lower on screen thus not within a BBox
		lda player.1.rightBBox
		cmp player.2.leftBBox
		bmi @p1vsp3 
		
		
		lda player.1.isColliding
		ora #$02
		sta player.1.isColliding
		
		lda player.2.isColliding
		ora #$01
		sta player.2.isColliding
		rts
		
		
@p1vsp3:		
		lda player.1.isColliding
		and #$00
		sta player.1.isColliding
		
		lda player.2.isColliding
		and #$00
		sta player.2.isColliding
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		rts
.ends