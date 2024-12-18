
;================================================================		
;================================================================	
;================================================================

;Walls
.DEFINE TopWall	 		$08
.DEFINE BottomWall	 	$DF
.DEFINE LeftWall 		$08
.DEFINE RightWall		$F8


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

jsr @wallCollisions

jsr PollenCollisions

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



;================================================================
@wallCollisions:



jsr @p1WallCheck
jsr @p2WallCheck
jsr @p3WallCheck
jsr @p4WallCheck

rts

;================================================================
@p1WallCheck:

		lda #BottomWall 
		cmp player.1.bottomBBox
		bcs @p1TopWall  
		lda #$01
		sta player.1.headingY
		;ldx #bash_velocity
		;stx player.1.targetVelocityY
		lda player.1.positionY_Lo
		sbc #$08
		sta player.1.positionY_Lo
		sta player.1.spriteY_Lo
		lda #Still
		sta player.1.motionState
		lda #$20
		sta player.1.cooldown	

@p1TopWall:		
		lda #TopWall
		cmp player.1.topBBox
		bcc @p1RightWall  
		lda #$00
		sta player.1.headingY
		;ldx #bash_velocity
		;stx player.1.targetVelocityY
		lda player.1.positionY_Lo
		adc #$08
		sta player.1.positionY_Lo
		sta player.1.spriteY_Lo
		lda #Still
		sta player.1.motionState
		lda #$20
		sta player.1.cooldown	

@p1RightWall:		
		lda #RightWall
		cmp player.1.rightBBox 
		bcs @p1LeftWall 
		lda #$01
		sta player.1.headingX
		;ldx #bash_velocity
		;stx player.1.targetVelocityX
		lda player.1.positionX_Lo
		sbc #$08
		sta player.1.positionX_Lo
		sta player.1.spriteX_Lo
		lda #Still
		sta player.1.motionState
		lda #$20
		sta player.1.cooldown	

@p1LeftWall:		
		lda #LeftWall
		cmp player.1.leftBBox
		bcc @p1NoWall 
		lda #$00
		sta player.1.headingX
		;ldx #bash_velocity
		;stx player.1.targetVelocityX
		lda player.1.positionX_Lo
		adc #$08
		sta player.1.positionX_Lo
		sta player.1.spriteX_Lo
		lda #Still
		sta player.1.motionState
		lda #$20
		sta player.1.cooldown	
		
@p1NoWall:	
rts
;================================================================
@p2WallCheck:

		lda #BottomWall 
		cmp player.2.bottomBBox
		bcs @p2TopWall  
		lda #$01
		sta player.2.headingY
		;ldx #bash_velocity
		;stx player.1.targetVelocityY
		lda player.2.positionY_Lo
		sbc #$08
		sta player.2.positionY_Lo
		sta player.2.spriteY_Lo
		lda #Still
		sta player.2.motionState
		lda #$20
		sta player.2.cooldown	

@p2TopWall:		
		lda #TopWall
		cmp player.2.topBBox
		bcc @p2RightWall  
		lda #$00
		sta player.2.headingY
		;ldx #bash_velocity
		;stx player.1.targetVelocityY
		lda player.2.positionY_Lo
		adc #$08
		sta player.2.positionY_Lo
		sta player.2.spriteY_Lo
		lda #Still
		sta player.2.motionState
		lda #$20
		sta player.2.cooldown	

@p2RightWall:		
		lda #RightWall
		cmp player.2.rightBBox 
		bcs @p2LeftWall 
		lda #$01
		sta player.2.headingX
		;ldx #bash_velocity
		;stx player.1.targetVelocityX
		lda player.2.positionX_Lo
		sbc #$08
		sta player.2.positionX_Lo
		sta player.2.spriteX_Lo
		lda #Still
		sta player.2.motionState
		lda #$20
		sta player.2.cooldown	

@p2LeftWall:		
		lda #LeftWall
		cmp player.2.leftBBox
		bcc @p2NoWall 
		lda #$00
		sta player.2.headingX
		;ldx #bash_velocity
		;stx player.1.targetVelocityX
		lda player.2.positionX_Lo
		adc #$08
		sta player.2.positionX_Lo
		sta player.2.spriteX_Lo
		lda #Still
		sta player.2.motionState
		lda #$20
		sta player.2.cooldown	
		
		
@p2NoWall:	
rts
;================================================================
@p3WallCheck:

		
		lda #BottomWall 
		cmp player.3.bottomBBox
		bcs @p3TopWall  
		lda #$01
		sta player.3.headingY
		;ldx #bash_velocity
		;stx player.1.targetVelocityY
		lda player.3.positionY_Lo
		sbc #$08
		sta player.3.positionY_Lo
		sta player.3.spriteY_Lo
		lda #Still
		sta player.3.motionState
		lda #$20
		sta player.3.cooldown	

@p3TopWall:		
		lda #TopWall
		cmp player.3.topBBox
		bcc @p3RightWall  
		lda #$00
		sta player.3.headingY
		;ldx #bash_velocity
		;stx player.1.targetVelocityY
		lda player.3.positionY_Lo
		adc #$08
		sta player.3.positionY_Lo
		sta player.3.spriteY_Lo
		lda #Still
		sta player.3.motionState
		lda #$20
		sta player.3.cooldown	

@p3RightWall:		
		lda #RightWall
		cmp player.3.rightBBox 
		bcs @p3LeftWall 
		lda #$01
		sta player.3.headingX
		;ldx #bash_velocity
		;stx player.1.targetVelocityX
		lda player.3.positionX_Lo
		sbc #$08
		sta player.3.positionX_Lo
		sta player.3.spriteX_Lo
		lda #Still
		sta player.3.motionState
		lda #$20
		sta player.3.cooldown	

@p3LeftWall:		
		lda #LeftWall
		cmp player.3.leftBBox
		bcc @p3NoWall 
		lda #$00
		sta player.3.headingX
		;ldx #bash_velocity
		;stx player.1.targetVelocityX
		lda player.3.positionX_Lo
		adc #$08
		sta player.3.positionX_Lo
		sta player.3.spriteX_Lo
		lda #Still
		sta player.3.motionState
		lda #$20
		sta player.3.cooldown	
		
@p3NoWall:	
rts
;================================================================
@p4WallCheck:

		lda #BottomWall 
		cmp player.4.bottomBBox
		bcs @p4TopWall  
		lda #$01
		sta player.4.headingY
		;ldx #bash_velocity
		;stx player.1.targetVelocityY
		lda player.4.positionY_Lo
		sbc #$08
		sta player.4.positionY_Lo
		sta player.4.spriteY_Lo
		lda #Still
		sta player.4.motionState
		lda #$20
		sta player.4.cooldown	

@p4TopWall:		
		lda #TopWall
		cmp player.4.topBBox
		bcc @p4RightWall  
		lda #$00
		sta player.4.headingY
		;ldx #bash_velocity
		;stx player.1.targetVelocityY
		lda player.4.positionY_Lo
		adc #$08
		sta player.4.positionY_Lo
		sta player.4.spriteY_Lo
		lda #Still
		sta player.4.motionState
		lda #$20
		sta player.4.cooldown	

@p4RightWall:		
		lda #RightWall
		cmp player.4.rightBBox 
		bcs @p4LeftWall 
		lda #$01
		sta player.4.headingX
		;ldx #bash_velocity
		;stx player.1.targetVelocityX
		lda player.4.positionX_Lo
		sbc #$08
		sta player.4.positionX_Lo
		sta player.4.spriteX_Lo
		lda #Still
		sta player.4.motionState
		lda #$20
		sta player.4.cooldown	

@p4LeftWall:		
		lda #LeftWall
		cmp player.4.leftBBox
		bcc @p4NoWall 
		lda #$00
		sta player.4.headingX
		;ldx #bash_velocity
		;stx player.1.targetVelocityX
		lda player.4.positionX_Lo
		adc #$08
		sta player.4.positionX_Lo
		sta player.4.spriteX_Lo
		lda #Still
		sta player.4.motionState
		lda #$20
		sta player.4.cooldown	
		
@p4NoWall:	
rts

;================================================================

PollenCollisions:

		lda pollen1Timer
		cmp #$05
		;bcs @Pollen2
		jsr @pollen1CollisionCheck
		
	@Pollen2:
		lda pollen2Timer
		cmp #$05
		;bcs @Pollen3
		jsr @pollen2CollisionCheck
		
	@Pollen3:
		lda pollen3Timer
		cmp #$05
		;bcs @Pollen4
		jsr @pollen3CollisionCheck
		
	@Pollen4:	
		lda pollen4Timer
		cmp #$05
		;bcs @PollenEnd
		jsr @pollen4CollisionCheck
		
@PollenEnd:
rts		

;================================================================	

@pollen1CollisionCheck:

@pollen1Player1:
		lda pollenY1
		adc #$18
		cmp player.1.topBBox
		bcc @pollen1Player2
		
		lda pollenY1
		adc #$08
		cmp player.1.bottomBBox
		bcs @pollen1Player2  
		
		lda pollenX1
		adc #$18
		cmp player.1.leftBBox
		bcc @pollen1Player2 
		
		lda pollenX1
		adc #$08
		cmp player.1.rightBBox
		bcs @pollen1Player2
		
		lda player.1.pollenCollected
		ina 
		sta player.1.pollenCollected
		
		ClearPollen1
		rts
		
@pollen1Player2:
		lda pollenY1
		adc #$18
		cmp player.2.topBBox
		bcc @pollen1Player3
		
		lda pollenY1
		adc #$08
		cmp player.2.bottomBBox
		bcs @pollen1Player3  
		
		lda pollenX1
		adc #$18
		cmp player.2.leftBBox
		bcc @pollen1Player3  
		
		lda pollenX1
		adc #$08
		cmp player.2.rightBBox
		bcs @pollen1Player3
		
		lda player.2.pollenCollected
		ina 
		sta player.2.pollenCollected
		
		ClearPollen1
		rts
		
@pollen1Player3:
		lda pollenY1
		adc #$18
		cmp player.3.topBBox
		bcc @pollen1Player4
		
		lda pollenY1
		adc #$08
		cmp player.3.bottomBBox
		bcs @pollen1Player4 
		
		lda pollenX1
		adc #$18
		cmp player.3.leftBBox
		bcc @pollen1Player4 
		
		lda pollenX1
		adc #$08
		cmp player.3.rightBBox
		bcs @pollen1Player4
		
		lda player.3.pollenCollected
		ina 
		sta player.3.pollenCollected
		
		ClearPollen1
		rts
		
@pollen1Player4:
		lda pollenY1
		adc #$18
		cmp player.4.topBBox
		bcc @pollen1NoCollision
		
		lda pollenY1
		adc #$08
		cmp player.4.bottomBBox
		bcs @pollen1NoCollision  
		
		lda pollenX1
		adc #$18
		cmp player.4.leftBBox
		bcc @pollen1NoCollision  
		
		lda pollenX1
		adc #$08
		cmp player.4.rightBBox
		bcs @pollen1NoCollision
		
		lda player.4.pollenCollected
		ina
		sta player.4.pollenCollected
		
		ClearPollen1
		rts

@pollen1NoCollision:
rts

;================================================================

@pollen2CollisionCheck:

@pollen2Player1:
		lda pollenY2
		adc #$18
		cmp player.1.topBBox
		bcc @pollen2Player2
		
		lda pollenY2
		adc #$08
		cmp player.1.bottomBBox
		bcs @pollen2Player2  
		
		lda pollenX2
		adc #$18
		cmp player.1.leftBBox
		bcc @pollen2Player2 
		
		lda pollenX2
		adc #$08
		cmp player.1.rightBBox
		bcs @pollen2Player2
		
		lda player.1.pollenCollected
		ina 
		sta player.1.pollenCollected
		
		ClearPollen2
		rts
		
@pollen2Player2:
		lda pollenY2
		adc #$18
		cmp player.2.topBBox
		bcc @pollen2Player3
		
		lda pollenY2
		adc #$08
		cmp player.2.bottomBBox
		bcs @pollen2Player3  
		
		lda pollenX2
		adc #$18
		cmp player.2.leftBBox
		bcc @pollen2Player3  
		
		lda pollenX2
		adc #$08
		cmp player.2.rightBBox
		bcs @pollen2Player3
		
		lda player.2.pollenCollected
		ina
		sta player.2.pollenCollected
		
		ClearPollen2
		rts
		
@pollen2Player3:
		lda pollenY2
		adc #$18
		cmp player.3.topBBox
		bcc @pollen2Player4
		
		lda pollenY2
		adc #$08
		cmp player.3.bottomBBox
		bcs @pollen2Player4 
		
		lda pollenX2
		adc #$18
		cmp player.3.leftBBox
		bcc @pollen2Player4 
		
		lda pollenX2
		adc #$08
		cmp player.3.rightBBox
		bcs @pollen2Player4
		
		lda player.3.pollenCollected
		ina 
		sta player.3.pollenCollected
		
		ClearPollen2
		rts
		
@pollen2Player4:
		lda pollenY2
		adc #$18
		cmp player.4.topBBox
		bcc @pollen2NoCollision
		
		lda pollenY2
		adc #$08
		cmp player.4.bottomBBox
		bcs @pollen2NoCollision  
		
		lda pollenX2
		adc #$18
		cmp player.4.leftBBox
		bcc @pollen2NoCollision  
		
		lda pollenX2
		adc #$08
		cmp player.4.rightBBox
		bcs @pollen2NoCollision
		
		lda player.4.pollenCollected
		ina 
		sta player.4.pollenCollected
		
		ClearPollen2
		rts

@pollen2NoCollision:
rts


;================================================================

@pollen3CollisionCheck:

@pollen3Player1:
		lda pollenY3
		adc #$18
		cmp player.1.topBBox
		bcc @pollen3Player2
		
		lda pollenY3
		adc #$08
		cmp player.1.bottomBBox
		bcs @pollen3Player2  
		
		lda pollenX3
		adc #$18
		cmp player.1.leftBBox
		bcc @pollen3Player2 
		
		lda pollenX3
		adc #$08
		cmp player.1.rightBBox
		bcs @pollen3Player2
		
		lda player.1.pollenCollected
		ina 
		sta player.1.pollenCollected
		
		ClearPollen3
		rts
		
@pollen3Player2:
		lda pollenY3
		adc #$18
		cmp player.2.topBBox
		bcc @pollen3Player3
		
		lda pollenY3
		adc #$08
		cmp player.2.bottomBBox
		bcs @pollen3Player3  
		
		lda pollenX3
		adc #$18
		cmp player.2.leftBBox
		bcc @pollen3Player3  
		
		lda pollenX3
		adc #$08
		cmp player.2.rightBBox
		bcs @pollen3Player3
		
		lda player.2.pollenCollected
		ina 
		sta player.2.pollenCollected
		
		ClearPollen3
		rts
		
@pollen3Player3:
		lda pollenY3
		adc #$18
		cmp player.3.topBBox
		bcc @pollen3Player4
		
		lda pollenY3
		adc #$08
		cmp player.3.bottomBBox
		bcs @pollen3Player4 
		
		lda pollenX3
		adc #$18
		cmp player.3.leftBBox
		bcc @pollen3Player4 
		
		lda pollenX3
		adc #$08
		cmp player.3.rightBBox
		bcs @pollen3Player4
		
		lda player.3.pollenCollected
		ina 
		sta player.3.pollenCollected
		
		ClearPollen3
		rts
		
@pollen3Player4:
		lda pollenY3
		adc #$18
		cmp player.4.topBBox
		bcc @pollen3NoCollision
		
		lda pollenY3
		adc #$08
		cmp player.4.bottomBBox
		bcs @pollen3NoCollision  
		
		lda pollenX3
		adc #$18
		cmp player.4.leftBBox
		bcc @pollen3NoCollision  
		
		lda pollenX3
		adc #$08
		cmp player.4.rightBBox
		bcs @pollen3NoCollision
		
		lda player.4.pollenCollected
		ina 
		sta player.4.pollenCollected
		
		ClearPollen3
		rts

@pollen3NoCollision:
rts

;================================================================

@pollen4CollisionCheck:

@pollen4Player1:
		lda pollenY4
		adc #$18
		cmp player.1.topBBox
		bcc @pollen4Player2
		
		lda pollenY4
		adc #$08
		cmp player.1.bottomBBox
		bcs @pollen4Player2  
		
		lda pollenX4
		adc #$18
		cmp player.1.leftBBox
		bcc @pollen4Player2 
		
		lda pollenX4
		adc #$08
		cmp player.1.rightBBox
		bcs @pollen4Player2
		
		lda player.1.pollenCollected
		ina 
		sta player.1.pollenCollected
		
		ClearPollen4
		rts
		
@pollen4Player2:
		lda pollenY4
		adc #$18
		cmp player.2.topBBox
		bcc @pollen4Player3
		
		lda pollenY4
		adc #$08
		cmp player.2.bottomBBox
		bcs @pollen4Player3  
		
		lda pollenX4
		adc #$18
		cmp player.2.leftBBox
		bcc @pollen4Player3  
		
		lda pollenX4
		adc #$08
		cmp player.2.rightBBox
		bcs @pollen4Player3
		
		lda player.2.pollenCollected
		ina 
		sta player.2.pollenCollected
		
		ClearPollen4
		rts
		
@pollen4Player3:
		lda pollenY4
		adc #$18
		cmp player.3.topBBox
		bcc @pollen4Player4
		
		lda pollenY4
		adc #$08
		cmp player.3.bottomBBox
		bcs @pollen4Player4 
		
		lda pollenX4
		adc #$18
		cmp player.3.leftBBox
		bcc @pollen4Player4 
		
		lda pollenX4
		adc #$08
		cmp player.3.rightBBox
		bcs @pollen4Player4
		
		lda player.3.pollenCollected
		ina 
		sta player.3.pollenCollected
		
		ClearPollen4
		rts
		
@pollen4Player4:
		lda pollenY4
		adc #$18
		cmp player.4.topBBox
		bcc @pollen4NoCollision
		
		lda pollenY4
		adc #$08
		cmp player.4.bottomBBox
		bcs @pollen4NoCollision  
		
		lda pollenX4
		adc #$18
		cmp player.4.leftBBox
		bcc @pollen4NoCollision  
		
		lda pollenX4
		adc #$08
		cmp player.4.rightBBox
		bcs @pollen4NoCollision
		
		lda player.4.pollenCollected
		ina 
		sta player.4.pollenCollected
		
		ClearPollen4
		rts

@pollen4NoCollision:
rts

;================================================================

.ends