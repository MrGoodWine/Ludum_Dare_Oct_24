
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
	byte28				DB ;DA
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
    lda #initialSpriteX
    sta player.1.spriteX_Lo
    lda #initialPositionX_LO
    sta player.1.positionX_Lo
    lda #initialPositionX_HI
	sta player.1.positionX_Hi
    lda #initialVelocityX
    sta player.1.velocityX
    rts



init_y_p1:
    lda #initialSpriteY 
    sta player.1.spriteY_Lo
    lda #initialPositionY_LO
    sta player.1.positionY_Lo
    lda #initialPositionY_HI
	sta player.1.positionY_Hi
    lda #initialVelocityY
    sta player.1.velocityY
	lda #Airborne
    sta player.1.motionState
    rts
	
init_x_p2:
    lda #initialSpriteX
    sta player.2.spriteX_Lo
    lda #initialPositionX_LO
    sta player.2.positionX_Lo
    lda #initialPositionX_HI
	sta player.2.positionX_Hi
    lda #initialVelocityX
    sta player.2.velocityX
    rts



init_y_p2:
	lda #initialSpriteY
    lda #initialSpriteY 
    sta player.2.spriteY_Hi
    lda #initialPositionY_LO
    sta player.2.positionY_Lo
    lda #initialPositionY_HI
	sta player.2.positionY_Hi
    lda #initialVelocityY
    sta player.2.velocityY
	lda #Airborne
    sta player.2.motionState
    rts
	
init_x_p3:
    lda #initialSpriteX
    sta player.3.spriteX_Lo
    lda #initialPositionX_LO
    sta player.3.positionX_Lo
    lda #initialPositionX_HI
	sta player.3.positionX_Hi
    lda #initialVelocityX
    sta player.3.velocityX
    rts



init_y_p3:
	lda #initialSpriteY
    lda #initialSpriteY 
    sta player.3.spriteY_Hi
    lda #initialPositionY_LO
    sta player.3.positionY_Lo
    lda #initialPositionY_HI
	sta player.3.positionY_Hi
    lda #initialVelocityY
    sta player.3.velocityY
	lda #Airborne
    sta player.3.motionState
    rts
	
init_x_p4:
    lda #initialSpriteX
    sta player.4.spriteX_Lo
    lda #initialPositionX_LO
    sta player.4.positionX_Lo
    lda #initialPositionX_HI
	sta player.4.positionX_Hi
    lda #initialVelocityX
    sta player.4.velocityX
    rts



init_y_p4:
	lda #initialSpriteY
    lda #initialSpriteY 
    sta player.4.spriteY_Hi
    lda #initialPositionY_LO
    sta player.4.positionY_Lo
    lda #initialPositionY_HI
	sta player.4.positionY_Hi
    lda #initialVelocityY
    sta player.4.velocityY
	lda #Airborne
    sta player.4.motionState
    rts
	
	
.ends	
	
	
;================================================================		
;================================================================	
;================================================================	  
	  
.bank 0 slot 0
.org 0
.section "Player 1 Routine"  
	  
MovementUpdateP1:
      jsr P1_set_target_y_velocity
      jsr P1_set_target_x_velocity
	  
@p1_up_move:
	  lda $2F
	  cmp #$08 ;up
	  bne @p1_left_move  
	  lda player.1.positionY_Lo
	  sbc player.1.targetVelocityY
	  sbc player.1.targetVelocityY
	  sta player.1.positionY_Lo	 
	  sta player.1.spriteY_Lo
	  jmp @p1_set_clear_bytes
	  
@p1_left_move:
	  cmp #$02 ;left
	  bne @p1_down_move  
	  lda player.1.positionX_Lo
	  sbc player.1.targetVelocityX
	  sbc player.1.targetVelocityX
	  sta player.1.positionX_Lo	 
	  sta player.1.spriteX_Lo
	  jmp @p1_set_clear_bytes	  
	  
@p1_down_move:  
	  cmp #$04 ;down
	  bne @p1_right_move
	  lda player.1.positionY_Lo
	  adc player.1.targetVelocityY
	  sta player.1.positionY_Lo	 
	  sta player.1.spriteY_Lo
	  jmp @p1_set_clear_bytes	
	  
@p1_right_move:
	  cmp #$01 ;right
	  bne  @p1_right_down_move
	  lda player.1.positionX_Lo
	  adc player.1.targetVelocityX
	  sta player.1.positionX_Lo	 
	  sta player.1.spriteX_Lo
jmp @p1_set_clear_bytes		  
	  
@p1_right_down_move:
	  cmp #$05 ;right down
	  bne @p1_right_up_move
	  lda player.1.positionX_Lo
	  adc player.1.targetVelocityX
	  sta player.1.positionX_Lo	 
	  sta player.1.spriteX_Lo
	  lda player.1.positionY_Lo
	  adc player.1.targetVelocityY
	  sta player.1.positionY_Lo	 
	  sta player.1.spriteY_Lo	
	  jmp @p1_set_clear_bytes	
	  
@p1_right_up_move:
	  cmp #$09 ;right up
	  bne @p1_left_up_move
	  lda player.1.positionX_Lo
	  adc player.1.targetVelocityX
	  sta player.1.positionX_Lo	 
	  sta player.1.spriteX_Lo
	  lda player.1.positionY_Lo
	  sbc player.1.targetVelocityY
	  sbc player.1.targetVelocityY
	  sta player.1.positionY_Lo	 
	  sta player.1.spriteY_Lo
	  jmp @p1_set_clear_bytes	
	  
@p1_left_up_move:
	  cmp #$0A ;left up
	  bne @p1_left_down_move
	  lda player.1.positionY_Lo
	  sbc player.1.targetVelocityY
	  sbc player.1.targetVelocityY
	  sta player.1.positionY_Lo	 
	  sta player.1.spriteY_Lo
	  lda player.1.positionX_Lo
	  sbc player.1.targetVelocityX
	  sbc player.1.targetVelocityX
	  sta player.1.positionX_Lo	 
	  sta player.1.spriteX_Lo	
	  jmp @p1_set_clear_bytes	
	  
@p1_left_down_move:
	  cmp #$06 ;left down
	  bne @p1_set_clear_bytes
	  lda player.1.positionX_Lo
	  sbc player.1.targetVelocityX
	  sbc player.1.targetVelocityX
	  sta player.1.positionX_Lo	 
	  sta player.1.spriteX_Lo	
	  lda player.1.positionY_Lo
	  adc player.1.targetVelocityY
	  sta player.1.positionY_Lo	 
	  sta player.1.spriteY_Lo	

@p1_set_clear_bytes:	
	  lda #$0000
	  sta player.1.byte21
	  sta player.1.byte22
	  sta player.1.byte23
	  sta player.1.byte24
	  sta player.1.byte25
	  sta player.1.byte26
	  rts	

	
	

;================================================================		
;==============Player 1 routine==================================		
;================================================================	
;================================================================	  
	  
P1_set_target_y_velocity
      ; Check if the B button is being pressed and save the state in the X
      ; register

	  Rep #$30
	  lda #$0000
	  sep #$20
	  ldx #01
	  
   
    @p1check_down: 
      lda #BUTTON_DOWN
	  sta CurrentButton
      and SJoy1, X
	  tay
	  cpy CurrentButton
      bne @p1check_up
	  sep #$30
	  lda #$00
	  sta player.1.headingY
	  ldx #down_velocity
      stx player.1.targetVelocityY
	  rep #$10
      rts
    @p1check_up:
	 
      lda #BUTTON_UP
	  sta CurrentButton
      and SJoy1, X 
	  tay
	  cpy CurrentButton
      bne @p1no_Y_direction
	  sep #$30
	  lda #$01
	  sta player.1.headingY
      ldx #down_velocity
      stx player.1.targetVelocityY
	  rep #$10
	  
      rts
	  
    @p1no_Y_direction:
      lda #0
      sta player.1.targetVelocityY
	  
      rts
    

	 
P1_set_target_x_velocity
      ; Check if the B button is being pressed and save the state in the X
      ; register

	  Rep #$30
	  lda #$0000
	  sep #$20
	  ldx #01
	  
   
    @p1check_right: 
      lda #BUTTON_RIGHT
	  sta CurrentButton
      and SJoy1, X
	  tay
	  cpy CurrentButton
      bne @p1check_left
	  sep #$30
	  lda #$00
	  sta player.1.headingX
	  ldx #right_velocity
      stx player.1.targetVelocityX
	  rep #$10
      rts
	  
	  
    @p1check_left:
      lda #BUTTON_LEFT
	  sta CurrentButton
      and SJoy1, X 
	  tay
	  cpy CurrentButton
      bne @p1no_direction
	  sep #$30
	  lda #$01
	  sta player.1.headingX
      ldx #left_velocity
      stx player.1.targetVelocityX
	  rep #$10
      rts
	  
    @p1no_direction:
      lda #0
      sta player.1.targetVelocityX
      rts
    


.ends

   
   
