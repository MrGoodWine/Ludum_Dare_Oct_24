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

jsr @BashingCollisions

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
		
	
		rts	
		
	

;================================================================
@p4Collisions:

	
@p4NoCollision:	
		
	
		rts	
		
		
;================================================================
;================================================================
;================================================================

@BashingCollisions:

jsr @p1Bashing
jsr @p2Bashing
jsr @p3Bashing
jsr @p4Bashing

rts
;================================================================

@p1Bashing

		lda player.1.motionState
		cmp #Bash
		bne @p1BashReturn
		lda player.1.isColliding
		cmp #$02
		bne @p1BashCheckP3
		lda #Still
		sta player.2.motionState
	  
		lda #$20
		sta player.2.cooldown
		
@p1BashCheckP3:
		lda player.1.isColliding
		cmp #$04
		bne @p1BashCheckP4
		lda #Still
		sta player.3.motionState
	  
		lda #$20
		sta player.3.cooldown
		
@p1BashCheckP4:
		lda player.1.isColliding
		cmp #$08
		bne @p1BashReturn
		lda #Still
		sta player.4.motionState
	  
		lda #$20
		sta player.4.cooldown	


@p1BashReturn:		
rts

;================================================================
@p2Bashing


		lda player.2.motionState
		cmp #Bash
		bne @p2BashReturn
		lda player.2.isColliding
		cmp #$01
		bne @p2BashCheckP3
		lda #Still
		sta player.1.motionState
	  
		lda #$20
		sta player.1.cooldown
		
@p2BashCheckP3:
		lda player.2.isColliding
		cmp #$04
		bne @p2BashCheckP4
		lda #Still
		sta player.3.motionState
	  
		lda #$20
		sta player.3.cooldown
		
@p2BashCheckP4:
		lda player.2.isColliding
		cmp #$08
		bne @p2BashReturn
		lda #Still
		sta player.4.motionState
	  
		lda #$20
		sta player.4.cooldown	

@p2BashReturn: 
rts

;================================================================
@p3Bashing

		lda player.3.motionState
		cmp #Bash
		bne @p3BashReturn
		lda player.3.isColliding
		cmp #$01
		bne @p3BashCheckP2
		lda #Still
		sta player.1.motionState
	  
		lda #$20
		sta player.1.cooldown
		
@p3BashCheckP2:
		lda player.3.isColliding
		cmp #$04
		bne @p3BashCheckP4
		lda #Still
		sta player.2.motionState
	  
		lda #$20
		sta player.2.cooldown
		
@p3BashCheckP4:
		lda player.3.isColliding
		cmp #$08
		bne @p3BashReturn
		lda #Still
		sta player.4.motionState
	  
		lda #$20
		sta player.4.cooldown	
	
@p3BashReturn:
rts

;================================================================
@p4Bashing

		lda player.4.motionState
		cmp #Bash
		bne @p4BashReturn
		lda player.4.isColliding
		cmp #$01
		bne @p4BashCheckP3
		lda #Still
		sta player.1.motionState
	  
		lda #$20
		sta player.1.cooldown
		
@p4BashCheckP3:
		lda player.4.isColliding
		cmp #$02
		bne @p4BashCheckP4
		lda #Still
		sta player.2.motionState
	  
		lda #$20
		sta player.2.cooldown
		
@p4BashCheckP4:
		lda player.4.isColliding
		cmp #$04
		bne @p4BashReturn
		lda #Still
		sta player.3.motionState
	  
		lda #$20
		sta player.3.cooldown	
	
@p4BashReturn:
rts

.ends