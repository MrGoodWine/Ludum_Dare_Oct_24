
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
.DEFINE bash_velocity 			$08


  ;Heading
  
  
  
  
.DEFINE RightDown	$00
.DEFINE RightUp		$01
.DEFINE LeftDown	$02
.DEFINE LeftUp		$03
.DEFINE Right		$04
.DEFINE Up			$05
.DEFINE Down		$06
.DEFINE Left		$07

.DEFINE Angled		$08
.DEFINE UpDown 		$09
.DEFINE RightLeft	$0A

  ;MotionState
.DEFINE Standing	0
.DEFINE Walk		1
.DEFINE Bash		2

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
	

	playerID			DB ;80
	targetVelocityX   	DB ;81
	targetVelocityY   	DB ;82
	velocityX        	DB ;83
	byte21				DB ;84
	positionX_Lo       	DB ;85
	positionX_Hi       	DB ;86
	leftBBox			DB ;87
	rightBBox			DB ;88
	spriteX_Lo       	DB ;89
	spriteX_Hi       	DB ;8A
	headingX          	DB ;8B
	velocityY        	DB ;8C
	byte24				DB ;8D
	positionY_Lo        DB ;8E
	positionY_Hi        DB ;8F
	topBBox				DB ;90
	bottomBBox			DB ;91
	isColliding			DB ;92
	spriteY_Lo       	DB ;93
	spriteY_Hi       	DB ;94
	headingY          	DB ;95
	motionState      	DB ;96
	animationFrame   	DB ;97
	animationTimer   	DB ;98
	idleState         	DB ;99
	idleTimer        	DB ;9A
	combinedHeading		DB ;9B
	priorityPalette		DB ;9C
	headingSpecific		DB ;9D
	cooldown			DB ;9E
	pollenCollected		DB ;9F
	
	


.ENDST

.ENUM $80
player INSTANCEOF playerCharacter 5
.ENDE

.bank 0 slot 0
.org 0
.section "Player Initialize"
;--------------------------------------

PlayerInit:
    
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
	lda #Standing
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
	lda #Standing
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
	lda #Standing
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
	lda #Standing
    sta player.4.motionState
	lda #$96
	sta player.4.animationFrame
	lda #$36
	sta player.4.priorityPalette
    rts
	
.ends	
	
	

   
   
