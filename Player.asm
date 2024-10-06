
.DEFINE initialSpriteX 			$99
.DEFINE initialVelocityX 		$00
.DEFINE initialPositionX_LO 	$77
.DEFINE initialPositionX_HI		$00
.DEFINE initialSpriteY 			$99
.DEFINE initialVelocityY 		$00
.DEFINE jumpVelocity			$DD
.DEFINE initialPositionY_LO 	$00
.DEFINE initialPositionY_HI 	$00
.DEFINE initID					$00

.DEFINE right_velocity 			$01
.DEFINE left_velocity 			$01
.DEFINE down_velocity 			$01
.DEFINE up_velocity 			$01


  ;Heading
.DEFINE Right	0
.DEFINE Left	1
.DEFINE Down	0
.DEFINE Up		1

  ;MotionState
.DEFINE Standing	0
.DEFINE Walk		1
.DEFINE Pivot		2
.DEFINE Airborne	3

  ;IdleState
.DEFINE Still	0
.DEFINE Blink1	1
.DEFINE Still2	2
.DEFINE Blink2	3

  ;Jump
.DEFINE FloorHeight			$009F
.DEFINE InitialVelocity		$C8
.DEFINE MaxFallSpeed		$40

.DEFINE isButtonHeld 		$00

.DEFINE CurrentButton 		$28

.STRUCT playerCharacter 
	
	;spriteX 		DW ;48
	;velocityX 		DW ;0
	;positionX_LO 	DW ;$00
	;positionX_HI	DW ;$03
	;spriteY 		DW ;143
	;velocityY 		DW ;0
	;positionY_LO 	DW ;$F0
	;positionY_HI 	DW ;$08

	playerID			DB ;C0
	targetVelocityX   	DB ;C1
	targetVelocityY   	DB ;C2
	velocityX        	DB ;C3
	byte21				DB ;D4
	positionX_Lo       	DB ;C4
	positionX_Hi       	DB ;C5
	byte22				DB ;D4
	byte23				DB ;D5

	spriteX_Lo       	DB ;C6
	spriteX_Hi       	DB ;C7
	headingX          	DB ;C8

	velocityY        	DB ;C9
	byte24				DB ;D6
	
	positionY_Lo        DB ;CA
	positionY_Hi        DB ;CB
	byte25				DB ;D7
	byte26				DB ;D8
	
	spriteY_Lo       	DB ;CC
	spriteY_Hi       	DB ;CD
	headingY          	DB ;CE

	motionState      	DB ;CF
	animationFrame   	DB ;D0
	animationTimer   	DB ;D1
	idleState         	DB ;D2
	idleTimer        	DB ;D3
	



	combinedHeading		DB ;D9
	priorityPalette		DB ;DA
	byte29				DB ;DB
	byte30				DB ;DC
	byte31				DB ;DE
	byte32				DB ;DF
	


.ENDST

.ENUM $C0
player INSTANCEOF playerCharacter 5
.ENDE

.bank 0 slot 0
.org 0
.section "Player Initialize"
;--------------------------------------

PlayerInit:
    
	
	;rol initID
	;rol initID
	;rol initID
	;rol initID
	;rol initID
	;ldy initID
	cpx #$01
	bne +
	stx player.1.playerID
    jsr init_x_p1
    jsr init_y_p1
+	cpx #$02
	bne +
	stx player.2.playerID
	jsr init_x_p2
    jsr init_y_p2
+	cpx #$03
	bne +
	stx player.3.playerID
	jsr init_x_p3
    jsr init_y_p3
+	cpx #$04
	bne +
	stx player.4.playerID
	jsr init_x_p4
    jsr init_y_p4
+	
	
    ;jsr init_sprites
	rts

init_x_p1:
    lda #$20
    sta player.1.spriteX_Lo
    sta player.1.positionX_Lo
    lda #initialVelocityX
    sta player.1.velocityX
    rts



init_y_p1:
    lda #$20
    sta player.1.spriteY_Lo
    sta player.1.positionY_Lo
    lda #initialVelocityY
    sta player.1.velocityY
	lda #Airborne
    sta player.1.motionState
	lda #$00
	sta player.1.animationFrame
	lda #$30
	sta player.1.priorityPalette
    rts
	
	
	
init_x_p2:
    lda #$D0
    sta player.2.spriteX_Lo
    sta player.2.positionX_Lo
    lda #initialVelocityX
    sta player.2.velocityX
    rts
	

init_y_p2:
    lda #$20
    sta player.2.spriteY_Lo
    sta player.2.positionY_Lo
    lda #initialVelocityY
    sta player.2.velocityY
	lda #Airborne
    sta player.2.motionState
	lda #$32
	sta player.2.animationFrame
	lda #$32
	sta player.2.priorityPalette
    rts
	

init_x_p3:
    lda #$20
    sta player.3.spriteX_Lo
    sta player.3.positionX_Lo
    lda #initialVelocityX
    sta player.3.velocityX
    rts
	

init_y_p3:
    lda #$C0
    sta player.3.spriteY_Lo
    sta player.3.positionY_Lo
    lda #initialVelocityY
    sta player.3.velocityY
	lda #Airborne
    sta player.3.motionState
	lda #$64
	sta player.3.animationFrame
	lda #$34
	sta player.3.priorityPalette
    rts
	
	
init_x_p4:
    lda #$D0
    sta player.4.spriteX_Lo
    sta player.4.positionX_Lo
    lda #initialVelocityX
    sta player.4.velocityX
    rts
	

init_y_p4:
    lda #$C0 
    sta player.4.spriteY_Lo
    sta player.4.positionY_Lo
    lda #initialVelocityY
    sta player.4.velocityY
	lda #Airborne
    sta player.4.motionState
	lda #$96
	sta player.4.animationFrame
	lda #$36
	sta player.4.priorityPalette
    rts
	
.ends	
	
	

   
   
