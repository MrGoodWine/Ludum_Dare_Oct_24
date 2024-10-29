;================================================================		
;================================================================	
;================================================================	
.bank 0 slot 0
.org 0
.section "Collision Routine"  

;================================================================	
CollisionCalc: 

jsr @setupBBoxes
jsr @ClearCollisions
jsr @p1Collisions
jsr @p2Collisions
jsr @p3Collisions
jsr @p4Collisions
rts

@setupBBoxes
;player 1 Bounding Box
		lda player.1.positionY_Lo
		adc #$08
		sta player.1.topBBox
		
		lda player.1.positionX_Lo
		adc #$08
		sta player.1.leftBBox
		
		lda player.1.positionY_Lo
		adc #$14
		sta player.1.bottomBBox
		
		lda player.1.positionX_Lo
		adc #$14
		sta player.1.rightBBox
		
		
		
;player 2 Bounding Box		
		lda player.2.positionY_Lo
		adc #$08
		sta player.2.topBBox
		
		lda player.2.positionX_Lo
		adc #$08
		sta player.2.leftBBox
		
		lda player.2.positionY_Lo
		adc #$14
		sta player.2.bottomBBox
		
		lda player.2.positionX_Lo
		adc #$14
		sta player.2.rightBBox
		
		
		
		
;player 3 Bounding Box		
		lda player.3.positionY_Lo
		adc #$08
		sta player.3.topBBox
		
		lda player.3.positionX_Lo
		adc #$08
		sta player.3.leftBBox
		
		lda player.3.positionY_Lo
		adc #$14
		sta player.3.bottomBBox
		
		lda player.3.positionX_Lo
		adc #$14
		sta player.3.rightBBox
		
		
;player 4 Bounding Box		
		lda player.4.positionY_Lo
		adc #$08
		sta player.4.topBBox
		
		lda player.4.positionX_Lo
		adc #$08
		sta player.4.leftBBox

		lda player.4.positionY_Lo
		adc #$14
		sta player.4.bottomBBox
		
		lda player.4.positionX_Lo
		adc #$14
		sta player.4.rightBBox


		rts
		
;================================================================
		
@ClearCollisions:
		lda player.1.isColliding
		and #$00
		sta player.1.isColliding
		
		lda player.2.isColliding
		and #$00
		sta player.2.isColliding
		
		lda player.3.isColliding
		and #$00
		sta player.3.isColliding
		
		lda player.4.isColliding
		and #$00
		sta player.4.isColliding
rts		
		
		
		
		
		
;================================================================			
		
;player 1 checks	Check whether their own Sides are within another BBox
		
		
@p1Collisions:

;@p1p2TopLftBBox:
		lda player.1.bottomBBox
		cmp player.2.topBBox
		bmi @p1vsp3  
		
		lda player.1.topBBox
		cmp player.2.bottomBBox
		bpl @p1vsp3  
		
		lda player.1.rightBBox
		cmp player.2.leftBBox
		bmi @p1vsp3  
		
		lda player.1.leftBBox
		cmp player.2.rightBBox
		bpl @p1vsp3  
		
		lda player.1.isColliding
		ora #$02
		sta player.1.isColliding
		
		lda player.2.isColliding
		ora #$01
		sta player.2.isColliding
		
		rts

@p1vsp3:	
		lda player.1.bottomBBox
		cmp player.3.topBBox
		bmi @p1vsp4 
		
		lda player.1.topBBox
		cmp player.3.bottomBBox
		bpl @p1vsp4  
		
		lda player.1.rightBBox
		cmp player.3.leftBBox
		bmi @p1vsp4  
		
		lda player.1.leftBBox
		cmp player.3.rightBBox
		bpl @p1vsp4
		
		lda player.1.isColliding
		ora #$04
		sta player.1.isColliding
		
		lda player.3.isColliding
		ora #$01
		sta player.3.isColliding
		
		rts

@p1vsp4:
		lda player.1.bottomBBox
		cmp player.4.topBBox
		bmi @p1NoCollision
		
		lda player.1.topBBox
		cmp player.4.bottomBBox
		bpl @p1NoCollision  
		
		lda player.1.rightBBox
		cmp player.4.leftBBox
		bmi @p1NoCollision  
		
		lda player.1.leftBBox
		cmp player.4.rightBBox
		bpl @p1NoCollision
		
		lda player.1.isColliding
		ora #$08
		sta player.1.isColliding
		
		lda player.4.isColliding
		ora #$01
		sta player.4.isColliding
		
		rts


@p1NoCollision:	
		;lda player.1.isColliding
		;and #$00
		;sta player.1.isColliding
	
		rts


;================================================================			
		
@p2Collisions:	
		lda player.2.bottomBBox
		cmp player.3.topBBox
		bmi @p2vsp4 
		
		lda player.2.topBBox
		cmp player.3.bottomBBox
		bpl @p2vsp4  
		
		lda player.2.rightBBox
		cmp player.3.leftBBox
		bmi @p2vsp4  
		
		lda player.2.leftBBox
		cmp player.3.rightBBox
		bpl @p2vsp4
		
		lda player.2.isColliding
		ora #$04
		sta player.2.isColliding
		
		lda player.3.isColliding
		ora #$02
		sta player.3.isColliding
		
		rts

@p2vsp4:
		lda player.2.bottomBBox
		cmp player.4.topBBox
		bmi @p2NoCollision
		
		lda player.2.topBBox
		cmp player.4.bottomBBox
		bpl @p2NoCollision  
		
		lda player.2.rightBBox
		cmp player.4.leftBBox
		bmi @p2NoCollision  
		
		lda player.2.leftBBox
		cmp player.4.rightBBox
		bpl @p2NoCollision
		
		lda player.2.isColliding
		ora #$08
		sta player.2.isColliding
		
		lda player.4.isColliding
		ora #$02
		sta player.4.isColliding
		
		rts


@p2NoCollision:	
		
		;lda player.2.isColliding
		;and #$01
		;sta player.2.isColliding
	
		rts
		
		
;================================================================
@p3Collisions:
		lda player.3.bottomBBox
		cmp player.4.topBBox
		bmi @p3NoCollision
		
		lda player.3.topBBox
		cmp player.4.bottomBBox
		bpl @p3NoCollision  
		
		lda player.3.rightBBox
		cmp player.4.leftBBox
		bmi @p3NoCollision  
		
		lda player.3.leftBBox
		cmp player.4.rightBBox
		bpl @p3NoCollision
		
		lda player.3.isColliding
		ora #$08
		sta player.3.isColliding
		
		lda player.4.isColliding
		ora #$04
		sta player.4.isColliding
		
		rts


@p3NoCollision:	
		
		;lda player.3.isColliding
		;and #$01
		;;and #$02
		;sta player.3.isColliding
	
		rts	
		
	

;================================================================
@p4Collisions:

	
@p4NoCollision:	
		
		;lda player.4.isColliding
		;and #$01
		;;and #$02
		;;and #$04
		;sta player.4.isColliding
	
		rts	
		
		
.ends