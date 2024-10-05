
.DEFINE initialSpriteX 			$99
.DEFINE initialVelocityX 		$00
.DEFINE initialPositionX_LO 	$77
.DEFINE initialPositionX_HI		$00
.DEFINE initialSpriteY 			$55
.DEFINE initialVelocityY 		$00
.DEFINE jumpVelocity			$DD
.DEFINE initialPositionY_LO 	$44
.DEFINE initialPositionY_HI 	$00
.DEFINE initID					$00

.DEFINE right_velocity 			$12
.DEFINE left_velocity 			$12
.DEFINE down_velocity 			$12
.DEFINE up_velocity 			$12


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
	positionX_Lo       	DB ;C4
	positionX_Hi       	DB ;C5
	spriteX_Lo       	DB ;C6
	spriteX_Hi       	DB ;C7
	headingX          	DB ;C8

	velocityY        	DB ;C9
	positionY_Lo        DB ;CA
	positionY_Hi        DB ;CB
	spriteY_Lo       	DB ;CC
	spriteY_Hi       	DB ;CD
	headingY          	DB ;CE

	motionState      	DB ;CF
	animationFrame   	DB ;D0
	animationTimer   	DB ;D1
	idleState         	DB ;D2
	idleTimer        	DB ;D3
	byte21				DB ;D4
	byte22				DB ;D4
	byte23				DB ;D5
	byte24				DB ;D6
	byte25				DB ;D7
	byte26				DB ;D8
	byte27				DB ;D9
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
    lda #initialSpriteY 
    sta player.1.spriteY_Hi
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
      jsr P1_accelerate_y
      jsr P1_apply_velocity_y
      ;jsr P1_bound_position_y
	 
      jsr P1_set_target_x_velocity
      jsr P1_accelerate_x
      ;jsr P1_apply_velocity_x
      ;jsr P1_bound_position_x
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
    


P1_accelerate_y

	

    ;  lda player.1.motionState;
    @p1airborne_accel:
      ; When airborne there is no friction, so ignore target velocities of 0
      sep #$20
	  rep #$10
	  
	  
	  lda player.1.targetVelocityY
	  cmp #$00
      bne @p1check_directional_velocity_y
	  
	;no_target_velocity
	  lda player.1.headingY
	  cmp #$00
      bcs @p1negative_deccel_y
    @p1positive_deccel_y:
      ; If moving right, only accelerate if the target velocity is higher
	  lda player.1.velocityY
	  sbc player.1.targetVelocityY
      bmi @p1decelerate_y
      rts
    @p1negative_deccel_y:
      ; Similarly, if moving left only do so if the target velocity is lower
      lda player.1.velocityY
	  sbc player.1.targetVelocityY
      bpl @p1decelerate_y
      rts
	  
      
   
    @p1check_directional_velocity_y:
      lda player.1.headingY
	  cmp #$00
      bcc @p1negative_accel_y
    @p1positive_accel_y:
      ; If moving right, only accelerate if the target velocity is higher
	  lda player.1.velocityY
	  sbc player.1.targetVelocityY
      bmi @p1accelerate_y
      rts
    @p1negative_accel_y:
      ; Similarly, if moving left only do so if the target velocity is lower
      lda player.1.velocityY
	  sbc player.1.targetVelocityY
      bpl @p1accelerate_y
      rts
    
		
	@p1accelerate_y:
     
      lda player.1.velocityY;
      sec
      sbc player.1.targetVelocityY;
      bne @p1check_greater_y
      rts
    @p1check_greater_y:
      bmi @p1lesser_y
	  rep #$30
	  lda #$00FF
	  and player.1.velocityY
	  tax 
	  sep #$10
      dex
	  stx player.1.velocityY;	
	  rep #$30
	  sep #$20	  
      rts
    @p1lesser_y:
     
	  rep #$30
	  lda #$00FF
	  and player.1.velocityY
	  tax 
	  sep #$10
      inx
	  stx player.1.velocityY;	
	  rep #$30
	  sep #$20  
      rts
	  
	  
	@p1decelerate_y:
     
      lda player.1.velocityY;
      sec
      sbc player.1.targetVelocityY;
      bne @p1check_greater_dec_y
      rts
    @p1check_greater_dec_y:
	 lda player.1.velocityY;
      sec
      sbc player.1.targetVelocityY;
      bmi @p1lesserDec_y
	  rep #$30
	  lda #$00FF
	  and player.1.velocityY
	  tax 
	  sep #$10
      dex
	  dex
	  stx player.1.velocityY;	
	  rep #$30
	  sep #$20	  
      rts
    @p1lesserDec_y:
     
	  rep #$30
	  lda #$00FF
	  and player.1.velocityY
	  tax 
	  sep #$10
      inx
	  inx
	  stx player.1.velocityY;	
	  rep #$30
	  sep #$20  
      rts


P1_apply_velocity_y
 
     lda player.1.headingY
     cmp #$01
	 beq @p1negative_velocity_Y
	  
     @p1positive_velocity_Y:
      REP #$30
	  clc
	  lda #$0000
	  and player.1.velocityY
	  sta $03
	  lda player.1.positionY_Lo
      adc $03
      sta player.1.positionY_Lo;
	  SEP #$20
	  rts
	 
   @p1negative_velocity_Y:
      REP #$30
	  clc
	  lda #$0000
	  and player.1.velocityY
	  sta $03
	  lda player.1.positionY_Lo
      sbc $03
      sta player.1.positionY_Lo;
	  SEP #$20
	  rts


P1_bound_position_y
   ;   ; Convert the fixed point position coordinate into screen coordinates
   
    ldy #$01
      lda player.1.positionY_Lo
      sta $00
      lda player.1.positionY_Lo, Y
      sta $01
      lsr $01
      ror $00
      lsr $01
      ror $00
      lsr $01
      ror $00
      lsr $01
      ror $00
      lda $00
	  cmp #$FF
	  bpl @clamp_bottom
      sta player.1.spriteY_Lo
	  lda $01
	  sta player.1.spriteY_Hi
	  rts
	  @clamp_bottom:
	  lda #$FF
	  sta player.1.spriteY_Lo
	  lda #$00
	  sta player.1.spriteY_Hi
	  rts
	  
	  
;================================================================		
;================================================================	
;================================================================	
;================================================================	 
	  

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
    


P1_accelerate_x

      sep #$20
	  rep #$10
	  
	  
	  lda player.1.targetVelocityX
	  cmp #$00
      bne @p1check_directional_velocity
	  
	;no_target_velocity
	  lda player.1.headingX
	  cmp #$00
      bcs @p1negative_deccel_x
	  
    @p1positive_deccel_x:; If moving right, only accelerate if the target velocity is higher
	  lda player.1.velocityX
	  sbc player.1.targetVelocityX
      bmi @p1decelerate
      rts
	  
    @p1negative_deccel_x:; Similarly, if moving left only do so if the target velocity is lower
      lda player.1.velocityX
	  sbc player.1.targetVelocityX
      bpl @p1decelerate
      rts
	  
      
    @p1check_directional_velocity:
      lda player.1.headingX
	  cmp #$00
      bcc @p1negative_accel_x
	  
	  
    @p1positive_accel_x:; If moving right, only accelerate if the target velocity is higher
	  lda player.1.velocityX
	  sbc player.1.targetVelocityX
      bmi @p1accelerate
      rts
	  
	  
    @p1negative_accel_x:
      ; Similarly, if moving left only do so if the target velocity is lower
      lda player.1.velocityX
	  sbc player.1.targetVelocityX
      bpl @p1accelerate
      rts
    
		
	
	@p1accelerate:
      lda player.1.velocityX;
      sec
      sbc player.1.targetVelocityX;
      bne @p1check_greater
      rts
	  
    @p1check_greater:
      bmi @p1lesser
	  rep #$30
	  lda #$00FF
	  and player.1.velocityX
	  tax 
	  sep #$10
      dex
	  stx player.1.velocityX;	
	  rep #$30
	  sep #$20	  
      rts
	  
    @p1lesser:
      rep #$30
	  lda #$00FF
	  and player.1.velocityX
	  tax 
	  sep #$10
      inx
	  stx player.1.velocityX;	
	  rep #$30
	  sep #$20  
      rts
	  
	  
	@p1decelerate:
      lda player.1.velocityX;
      sec
      sbc player.1.targetVelocityX;
      bne @p1check_greater_dec
      rts
	  
    @p1check_greater_dec:
      bmi @p1lesserDec
	  rep #$30
	  lda #$00FF
	  and player.1.velocityX
	  tax 
	  sep #$10
      dex
	  dex
	  stx player.1.velocityX;	
	  rep #$30
	  sep #$20	  
      rts
	  
    @p1lesserDec:
      rep #$30
	  lda #$00FF
	  and player.1.velocityX
	  tax 
	  sep #$10
      inx
	  inx
	  stx player.1.velocityX;	
	  rep #$30
	  sep #$20  
      rts


P1_apply_velocity_x
 
     lda player.1.headingX
     cmp #$01
	 beq @p1negative_velocity_x
	  
     @p1positive_velocity_x:
      REP #$30
	  clc
	  lda #$00FF
	  and player.1.velocityX
	  sta $03
	  lda player.1.positionX_Lo
      adc $03
      sta player.1.positionX_Lo;
	  SEP #$20
	  rts
	 
   @p1negative_velocity_x:
      REP #$30
	  clc
	  lda #$00FF
	  and player.1.velocityX
	  sta $03
	  lda player.1.positionX_Lo
      sbc $03
      sta player.1.positionX_Lo;
	  SEP #$20
	  rts


P1_bound_position_x
   ;   ; Convert the fixed point position coordinate into screen coordinates
   
    ldy #$01
      lda player.1.positionX_Lo
      sta $00
      lda player.1.positionX_Lo, Y
      sta $01
      lsr $01
      ror $00
      lsr $01
      ror $00
      lsr $01
      ror $00
      lsr $01
      ror $00
      lda $00
      sta player.1.spriteX_Lo
	  lda $01
	  sta player.1.spriteX_Hi

.ends

   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
.bank 0 slot 0
.org 0
.section "Player 2 Routine"  	
	    
MovementUpdateP2:
      jsr P2_set_target_y_velocity
      jsr P2_accelerate_y
      jsr P2_apply_velocity_y
      jsr P2_bound_position_y
      jsr P2_set_target_x_velocity
      jsr P2_accelerate_x
      jsr P2_apply_velocity_x
      jsr P2_bound_position_x
      rts
	  

	  
	  
;================================================================		
;==============Player 2 routine==================================	
;================================================================	
;================================================================	  
	  
P2_set_target_y_velocity
      ; Check if the B button is being pressed and save the state in the X
      ; register

	  Rep #$30
	  lda #$0000
	  sep #$20
	  ldx #01
	  
   
    @p2check_down: 
      lda #BUTTON_DOWN
	  sta CurrentButton
      and SJoy1, X
	  tay
	  cpy CurrentButton
      bne @p2check_up
	  sep #$30
	  lda #$00
	  sta player.2.headingY
	  ldx #down_velocity
      stx player.2.targetVelocityY
	  rep #$10
      rts
    @p2check_up:
	 
      lda #BUTTON_UP
	  sta CurrentButton
      and SJoy2, X 
	  tay
	  cpy CurrentButton
      bne @p2no_Y_direction
	  sep #$30
	  lda #$01
	  sta player.2.headingY
      ldx #down_velocity
      stx player.2.targetVelocityY
	  rep #$10
	  
      rts
	  
    @p2no_Y_direction:
      lda #0
      sta player.2.targetVelocityY
	  
      rts
    


P2_accelerate_y
    ;  lda player.2.motionState;
    @p2airborne_accel:
      ; When airborne there is no friction, so ignore target velocities of 0
      sep #$20
	  rep #$10
	  
	  
	  lda player.2.targetVelocityY
	  cmp #$00
      bne @p2check_directional_velocity_y
	  
	;no_target_velocity
	  lda player.2.headingY
	  cmp #$00
      bcs @p2negative_deccel_y
    @p2positive_deccel_y:
      ; If moving right, only accelerate if the target velocity is higher
	  lda player.2.velocityY
	  sbc player.2.targetVelocityY
      bmi @p2decelerate_y
      rts
    @p2negative_deccel_y:
      ; Similarly, if moving left only do so if the target velocity is lower
      lda player.2.velocityY
	  sbc player.2.targetVelocityY
      bpl @p2decelerate_y
      rts
	  
      
   
    @p2check_directional_velocity_y:
      lda player.2.headingY
	  cmp #$00
      bcc @p2negative_accel_y
    @p2positive_accel_y:
      ; If moving right, only accelerate if the target velocity is higher
	  lda player.2.velocityY
	  sbc player.2.targetVelocityY
      bmi @p2accelerate_y
      rts
    @p2negative_accel_y:
      ; Similarly, if moving left only do so if the target velocity is lower
      lda player.2.velocityY
	  sbc player.2.targetVelocityY
      bpl @p2accelerate_y
      rts
    
		
	@p2accelerate_y:
     
      lda player.2.velocityY;
      sec
      sbc player.2.targetVelocityY;
      bne @p2check_greater_y
      rts
    @p2check_greater_y:
      bmi @p2lesser_y
	  rep #$30
	  lda #$00FF
	  and player.2.velocityY
	  tax 
	  sep #$10
      dex
	  stx player.2.velocityY;	
	  rep #$30
	  sep #$20	  
      rts
    @p2lesser_y:
     
	  rep #$30
	  lda #$00FF
	  and player.2.velocityY
	  tax 
	  sep #$10
      inx
	  stx player.2.velocityY;	
	  rep #$30
	  sep #$20  
      rts
	  
	  
	@p2decelerate_y:
     
      lda player.2.velocityY;
      sec
      sbc player.2.targetVelocityY;
      bne @p2check_greater_dec_y
      rts
    @p2check_greater_dec_y:
      bmi @p2lesserDec_y
	  rep #$30
	  lda #$00FF
	  and player.2.velocityY
	  tax 
	  sep #$10
      dex
	  dex
	  stx player.2.velocityY;	
	  rep #$30
	  sep #$20	  
      rts
    @p2lesserDec_y:
     
	  rep #$30
	  lda #$00FF
	  and player.2.velocityY
	  tax 
	  sep #$10
      inx
	  inx
	  stx player.2.velocityY;	
	  rep #$30
	  sep #$20  
      rts


P2_apply_velocity_y
 
     lda player.2.headingY
     cmp #$01
	 beq @p2negative_velocity_Y
	  
     @p2positive_velocity_Y:
      REP #$30
	  clc
	  lda #$00FF
	  and player.2.velocityY
	  sta $03
	  lda player.2.positionY_Lo
      adc $03
      sta player.2.positionY_Lo;
	  SEP #$20
	  rts
	 
   @p2negative_velocity_Y:
      REP #$30
	  clc
	  lda #$00FF
	  and player.2.velocityY
	  sta $03
	  lda player.2.positionY_Lo
      sbc $03
      sta player.2.positionY_Lo;
	  SEP #$20
	  rts


P2_bound_position_y
   ;   ; Convert the fixed point position coordinate into screen coordinates
   
    ldy #$01
      lda player.2.positionY_Lo
      sta $00
      lda player.2.positionY_Lo, Y
      sta $01
      lsr $01
      ror $00
      lsr $01
      ror $00
      lsr $01
      ror $00
      lsr $01
      ror $00
      lda $00
      sta player.2.spriteY_Lo
	  lda $01
	  sta player.2.spriteY_Hi
	 
;================================================================	
;================================================================	 
	  

P2_set_target_x_velocity
      ; Check if the B button is being pressed and save the state in the X
      ; register

	  Rep #$30
	  lda #$0000
	  sep #$20
	  ldx #01
	  
   
    @p2check_right: 
      lda #BUTTON_RIGHT
	  sta CurrentButton
      and SJoy2, X
	  tay
	  cpy CurrentButton
      bne @p2check_left
	  sep #$30
	  lda #$00
	  sta player.2.headingX
	  ldx #right_velocity
      stx player.2.targetVelocityX
	  rep #$10
      rts
    @p2check_left:
	 
      lda #BUTTON_LEFT
	  sta CurrentButton
      and SJoy2, X 
	  tay
	  cpy CurrentButton
      bne @p2no_direction
	  sep #$30
	  lda #$01
	  sta player.2.headingX
      ldx #left_velocity
      stx player.2.targetVelocityX
	  rep #$10
	  
      rts
	  
    @p2no_direction:
      lda #0
      sta player.2.targetVelocityX
	  
      rts
    


P2_accelerate_x
    ;  lda player.2.motionState;
   ;   cmp Airborne
   ;   bne @p2accelerate
    ;@p2airborne_accel:
      ; When airborne there is no friction, so ignore target velocities of 0
      sep #$20
	  rep #$10
	  
	  
	  lda player.2.targetVelocityX
	  cmp #$00
      bne @p2check_directional_velocity
	  
	;no_target_velocity
	  lda player.2.headingX
	  cmp #$00
      bcs @p2negative_deccel_x
    @p2positive_deccel_x:
      ; If moving right, only accelerate if the target velocity is higher
	  lda player.2.velocityX
	  sbc player.2.targetVelocityX
      bmi @p2decelerate
      rts
    @p2negative_deccel_x:
      ; Similarly, if moving left only do so if the target velocity is lower
      lda player.2.velocityX
	  sbc player.2.targetVelocityX
      bpl @p2decelerate
      rts
	  
      
    @p2check_directional_velocity:
      lda player.2.headingX
	  cmp #$00
      bcc @p2negative_accel_x
    @p2positive_accel_x:
      ; If moving right, only accelerate if the target velocity is higher
	  lda player.2.velocityX
	  sbc player.2.targetVelocityX
      bmi @p2accelerate
      rts
    @p2negative_accel_x:
      ; Similarly, if moving left only do so if the target velocity is lower
      lda player.2.velocityX
	  sbc player.2.targetVelocityX
      bpl @p2accelerate
      rts
    
		
	
	@p2accelerate:
     
      lda player.2.velocityX;
      sec
      sbc player.2.targetVelocityX;
      bne @p2check_greater
      rts
    @p2check_greater:
      bmi @p2lesser
	  rep #$30
	  lda #$00FF
	  and player.2.velocityX
	  tax 
	  sep #$10
      dex
	  stx player.2.velocityX;	
	  rep #$30
	  sep #$20	  
      rts
    @p2lesser:
     
	  rep #$30
	  lda #$00FF
	  and player.2.velocityX
	  tax 
	  sep #$10
      inx
	  stx player.2.velocityX;	
	  rep #$30
	  sep #$20  
      rts
	  
	  
	@p2decelerate:
     
      lda player.2.velocityX;
      sec
      sbc player.2.targetVelocityX;
      bne @p2check_greater_dec
      rts
    @p2check_greater_dec:
      bmi @p2lesserDec
	  rep #$30
	  lda #$00FF
	  and player.2.velocityX
	  tax 
	  sep #$10
      dex
	  dex
	  stx player.2.velocityX;	
	  rep #$30
	  sep #$20	  
      rts
    @p2lesserDec:
     
	  rep #$30
	  lda #$00FF
	  and player.2.velocityX
	  tax 
	  sep #$10
      inx
	  inx
	  stx player.2.velocityX;	
	  rep #$30
	  sep #$20  
      rts


P2_apply_velocity_x
 
     lda player.2.headingX
     cmp #$01
	 beq @p2negative_velocity_x
	  
     @p2positive_velocity_x:
      REP #$30
	  clc
	  lda #$00FF
	  and player.2.velocityX
	  sta $03
	  lda player.2.positionX_Lo
      adc $03
      sta player.2.positionX_Lo;
	  SEP #$20
	  rts
	 
   @p2negative_velocity_x:
      REP #$30
	  clc
	  lda #$00FF
	  and player.2.velocityX
	  sta $03
	  lda player.2.positionX_Lo
      sbc $03
      sta player.2.positionX_Lo;
	  SEP #$20
	  rts


P2_bound_position_x
   ;   ; Convert the fixed point position coordinate into screen coordinates
   
    ldy #$01
      lda player.2.positionX_Lo
      sta $00
      lda player.2.positionX_Lo, Y
      sta $01
      lsr $01
      ror $00
      lsr $01
      ror $00
      lsr $01
      ror $00
      lsr $01
      ror $00
      lda $00
      sta player.2.spriteX_Lo
	  lda $01
	  sta player.2.spriteX_Hi
   
   ;   ldy sy
	;  lda player.2.positionX;
   ;   sta $00
   ;   lda player.2.positionX;
   ;   sta $01
   ;   lsr $01
   ;   ror $00
   ;   lsr $01
   ;   ror $00
   ;   lsr $01
   ;   ror $00
   ;   lsr $01
   ;   ror $00
   ;   ; Assume that everything is fine and save the sprite position
   ;   lda $00
   ;   ;sta player.2.spriteX;
   ;   ; Check if we are moving left or right (negative or positive respectively)
   ;   lda player.2.velocityX;
   ;   bmi @p2negative_position_x
   ; @p2positive_position_x:
   ;   lda $01
   ;   bne @p2bound_upper
   ;   lda $00
   ;   cmp #239
   ;   bcs @p2bound_upper
   ;   rts
   ; @p2bound_upper:
   ;   ; $EF = 239 = 255 - 16, this is the right bound since the screen is 256 pixels
   ;   ; wide and the character is 16 pixels wide.
   ;   ;lda #$EF
   ;   ;sta player.2.spriteX;
   ;   ;lda #$0E
   ;   ;sta player.2.positionX+1;
   ;   ;lda #$F0
   ;   ;sta player.2.positionX;
   ;   ; Finally, set the velocity to 0 since the player is being "stopped"
   ;   ;lda #0
   ;   ;sta player.2.velocityX;
   ;   rts
   ; @p2negative_position_x:
   ;   ; The negative case is really simple, just check if the high order byte of the
   ;   ; 12.4 fixed point position is negative. If so bound everything to 0.
   ;   ;lda player.2.positionX+1;
   ;   bmi @p2bound_lower
   ;   rts
   ; @p2bound_lower:
   ;   ;lda #0
   ;   ;sta player.2.positionX;
   ;   ;sta player.2.positionX+1;
   ;   ;sta player.2.spriteX;
   ;   ;sta player.2.velocityX;
   ;   rts



P2_Sprite_update
   ;   jsr update_motion_state
   ;   jsr update_animation_frame
   ;   jsr update_heading
   ;   jsr update_idle_state
   ;   jsr update_sprite_tiles
   ;   jsr update_sprite_position
      rts
 

P2_update_motion_state
      lda player.2.motionState
      cmp Airborne
      bcc @p2grounded
    @p2airborne_motion_state:
      rts
    @p2grounded:
      ; If spriteX == 0: STILL    // Left bound animation fix
      ; If spriteX == MAX: STILL  // Right bound animation fix
      ; If T = V:
      ;   // Steady motion
      ;   If T == 0: STILL
      ;   Else: WALK
      ; If T <> V:
      ;   // Accelerating
      ;   If <- or -> being pressed:
      ;     If T > 0 && V < 0: PIVOT
      ;     If T < 0 && V > 0: PIVOT
      ;   Else: WALK
      lda player.2.spriteX_Hi
      beq @p2stand
      cmp #$EF
      beq @p2stand
      lda player.2.targetVelocityX;
      cmp player.2.velocityX;
      bne @p2accelerating
    @p2steady:
      lda player.2.velocityX;
      beq @p2stand
      bne @p2walk_motion_state
    @p2stand:
      lda Still
      sta player.2.motionState;
      rts
    @p2accelerating:
      lda BUTTON_LEFT
      ora BUTTON_RIGHT
      and Joy1Press ;isButtonHeld
      beq @p2walk_motion_state
      lda #%10000000
      and player.2.targetVelocityX;
      sta $00
      lda #%10000000
      and player.2.velocityX;
      cmp $00
      ;beq @p2walk_motion_state
    @p2pivot_motion_state:
      lda Pivot
      sta player.2.motionState;
      rts
    @p2walk_motion_state:
      lda Walk
      sta player.2.motionState;
      rts


P2_update_animation_frame
      ; If V == 0:
      ;   Set initial timer
      ; Else:
      ;   Decrement timer
      ;   If frame timer == 0:
      ;     Reset frame timer based on V
      ;     Increment the frame
      lda player.2.velocityX;
      bne @p2moving
      ;lda delay_by_velocity
      sta player.2.animationTimer;
      rts
    @p2moving:
      ;dec player.2.animationTimer;
      beq @p2next_frame
      rts
    @p2next_frame:
      ldx player.2.velocityX;
      bpl @p2transition_state
      lda #0
      sec
      sbc player.2.velocityX;
      tax
    @p2transition_state:
      ;lda delay_by_velocity, x
      sta player.2.animationTimer;
      lda #1
      eor player.2.animationFrame;
      sta player.2.animationFrame;
      rts
    ;delay_by_velocity:
      ;.byte 12, 11, 11, 11, 11, 11, 10, 10, 10, 10, 10
      ;.byte 9, 9, 9, 9, 9, 8, 8, 8, 8, 8, 7, 7, 7, 7, 7
      ;.byte 6, 6, 6, 6, 6, 5, 5, 5, 5, 5, 4, 4, 4, 4, 4


P2_update_heading
      ; If the target velocity is 0 then the player isn't pressing left or right and
      ; the heading doesn't need to change.
      lda player.2.targetVelocityX;
      bne @p2check_headingX
      rts
      ; If the target velocity is non-zero, check to see if player is heading in the
      ; desired direction.
    @p2check_headingX:
      asl
      lda #0
      rol
      cmp player.2.headingX;
      bne @p2update_headingX
      rts
    @p2update_headingX:
      ; If the desired heading is not equal to the current heading based on the
      ; target velocity, then update the heading.
      sta player.2.headingX;
      ; Toggle the "horizontal" mirroring on the character sprites
      lda #%01000000
      ;eor $200 + OAM_ATTR
      ;sta $200 + OAM_ATTR
      ;sta $204 + OAM_ATTR
      rts


P2_update_idle_state
     ; lda player.2.motionState;
     ; cmp Still
     ; beq @p2update_timer
     ; ;lda ;timers
     ; sta player.2.idleTimer;
     ; lda Still
     ; sta player.2.idleState;
      rts
    @p2update_timer:
      ;dec player.2.idleTimer;
      beq @p2update_state
      rts
    @p2update_state:
      ldx player.2.idleState;
      inx
      cpx #4
      bne @p2set_state
      ldx #0
    @p2set_state:
      stx player.2.idleState;
      ;lda ;timers, x
      sta player.2.idleTimer;
      rts
    ;timers:
      ;.byte 245, 10, 10, 10


P2_update_sprite_tiles
      lda player.2.motionState;
      cmp Airborne
      beq @p2airborne_sptite_tiles
      cmp Pivot
      beq @p2pivot_sprite_tiles
      cmp Walk
      beq @p2walk_sprite_tiles
    @p2still:
      lda player.2.idleState;
      asl
      asl
      clc
      adc player.2.headingX;
      tax
      ;lda idle_tiles, x
      ;sta $200 + OAM_TILE
      ;lda idle_tiles + 2, x
      ;sta $204 + OAM_TILE
      rts
    @p2airborne_sptite_tiles:
      ldx player.2.headingX;
      ;lda jumping_tiles, x
      ;sta $200 + OAM_TILE
      ;lda jumping_tiles + 2, x
      ;sta $204 + OAM_TILE
      rts
    @p2walk_sprite_tiles:
      lda player.2.animationFrame;
      asl
      asl
      clc
      adc player.2.headingX;
      tax
      ;lda walk_tiles, x
      ;sta $200 + OAM_TILE
      ;lda walk_tiles +2, x
      ;sta $204 + OAM_TILE
      rts
    @p2pivot_sprite_tiles:
      ldx player.2.headingX;
      ;lda pivot_tiles, x
      ;sta $200 + OAM_TILE
      ;lda pivot_tiles + 2, x
      ;sta $204 + OAM_TILE
      rts
    ;jumping_tiles:
      ;.byte $88, $8A, $8A, $88
    ;pivot_tiles:
      ;.byte $98, $9A, $9A, $98 ; Pivot is the same no matter the animation frame
   ; walk_tiles:
      ;.byte $80, $82, $82, $80 ; Frame 1
      ;.byte $84, $86, $86, $84 ; Frame 2
    ;idle_tiles:
      ;.byte $80, $82, $82, $80
      ;.byte $9C, $9E, $9E, $9C
      ;.byte $80, $82, $82, $80
      ;.byte $9C, $9E, $9E, $9C


P2_update_sprite_position
      ; This is computed in `bound_position` above, so all we have to do is set
      ; the sprite coordinates appropriately.
      lda player.2.spriteX_Hi
      ;sta $200 + OAM_X
      clc
      adc #8
      ;sta $204 + OAM_X
      lda player.2.spriteY_Hi
      sta $200
      sta $204
      rts 
	 
.ends

.bank 0 slot 0
.org 0
.section "Player 3 Routine"  	
	 	  
MovementUpdateP3:
      jsr P3_set_target_y_velocity
      jsr P3_accelerate_y
      jsr P3_apply_velocity_y
      jsr P3_bound_position_y
      jsr P3_set_target_x_velocity
      jsr P3_accelerate_x
      jsr P3_apply_velocity_x
      jsr P3_bound_position_x
      rts

	 
;================================================================		
;==============Player 3 routine==================================	
;================================================================	
;================================================================	  
	  
P3_set_target_y_velocity
      ; Check if the B button is being pressed and save the state in the X
      ; register

	  Rep #$30
	  lda #$0000
	  sep #$20
	  ldx #01
	  
   
    @p3check_down: 
      lda #BUTTON_DOWN
	  sta CurrentButton
      and SJoy3, X
	  tay
	  cpy CurrentButton
      bne @p3check_up
	  sep #$30
	  lda #$00
	  sta player.3.headingY
	  ldx #down_velocity
      stx player.3.targetVelocityY
	  rep #$10
      rts
    @p3check_up:
	 
      lda #BUTTON_UP
	  sta CurrentButton
      and SJoy3, X 
	  tay
	  cpy CurrentButton
      bne @p3no_Y_direction
	  sep #$30
	  lda #$01
	  sta player.3.headingY
      ldx #down_velocity
      stx player.3.targetVelocityY
	  rep #$10
	  
      rts
	  
    @p3no_Y_direction:
      lda #0
      sta player.3.targetVelocityY
	  
      rts
    


P3_accelerate_y
    ;  lda player.3.motionState;
    @p3airborne_accel:
      ; When airborne there is no friction, so ignore target velocities of 0
      sep #$20
	  rep #$10
	  
	  
	  lda player.3.targetVelocityY
	  cmp #$00
      bne @p3check_directional_velocity_y
	  
	;no_target_velocity
	  lda player.3.headingY
	  cmp #$00
      bcs @p3negative_deccel_y
    @p3positive_deccel_y:
      ; If moving right, only accelerate if the target velocity is higher
	  lda player.3.velocityY
	  sbc player.3.targetVelocityY
      bmi @p3decelerate_y
      rts
    @p3negative_deccel_y:
      ; Similarly, if moving left only do so if the target velocity is lower
      lda player.3.velocityY
	  sbc player.3.targetVelocityY
      bpl @p3decelerate_y
      rts
	  
      
   
    @p3check_directional_velocity_y:
      lda player.3.headingY
	  cmp #$00
      bcc @p3negative_accel_y
    @p3positive_accel_y:
      ; If moving right, only accelerate if the target velocity is higher
	  lda player.3.velocityY
	  sbc player.3.targetVelocityY
      bmi @p3accelerate_y
      rts
    @p3negative_accel_y:
      ; Similarly, if moving left only do so if the target velocity is lower
      lda player.3.velocityY
	  sbc player.3.targetVelocityY
      bpl @p3accelerate_y
      rts
    
		
	@p3accelerate_y:
     
      lda player.3.velocityY;
      sec
      sbc player.3.targetVelocityY;
      bne @p3check_greater_y
      rts
    @p3check_greater_y:
      bmi @p3lesser_y
	  rep #$30
	  lda #$00FF
	  and player.3.velocityY
	  tax 
	  sep #$10
      dex
	  stx player.3.velocityY;	
	  rep #$30
	  sep #$20	  
      rts
    @p3lesser_y:
     
	  rep #$30
	  lda #$00FF
	  and player.3.velocityY
	  tax 
	  sep #$10
      inx
	  stx player.3.velocityY;	
	  rep #$30
	  sep #$20  
      rts
	  
	  
	@p3decelerate_y:
     
      lda player.3.velocityY;
      sec
      sbc player.3.targetVelocityY;
      bne @p3check_greater_dec_y
      rts
    @p3check_greater_dec_y:
      bmi @p3lesserDec_y
	  rep #$30
	  lda #$00FF
	  and player.3.velocityY
	  tax 
	  sep #$10
      dex
	  dex
	  stx player.3.velocityY;	
	  rep #$30
	  sep #$20	  
      rts
    @p3lesserDec_y:
     
	  rep #$30
	  lda #$00FF
	  and player.3.velocityY
	  tax 
	  sep #$10
      inx
	  inx
	  stx player.3.velocityY;	
	  rep #$30
	  sep #$20  
      rts


P3_apply_velocity_y
 
     lda player.3.headingY
     cmp #$01
	 beq @p3negative_velocity_Y
	  
     @p3positive_velocity_Y:
      REP #$30
	  clc
	  lda #$00FF
	  and player.3.velocityY
	  sta $03
	  lda player.3.positionY_Lo
      adc $03
      sta player.3.positionY_Lo;
	  SEP #$20
	  rts
	 
   @p3negative_velocity_Y:
      REP #$30
	  clc
	  lda #$00FF
	  and player.3.velocityY
	  sta $03
	  lda player.3.positionY_Lo
      sbc $03
      sta player.3.positionY_Lo;
	  SEP #$20
	  rts


P3_bound_position_y
   ;   ; Convert the fixed point position coordinate into screen coordinates
   
    ldy #$01
      lda player.3.positionY_Lo
      sta $00
      lda player.3.positionY_Lo, Y
      sta $01
      lsr $01
      ror $00
      lsr $01
      ror $00
      lsr $01
      ror $00
      lsr $01
      ror $00
      lda $00
      sta player.3.spriteY_Lo
	  lda $01
	  sta player.3.spriteY_Hi
	  	
;================================================================	
;================================================================	 
	  

P3_set_target_x_velocity
      ; Check if the B button is being pressed and save the state in the X
      ; register

	  Rep #$30
	  lda #$0000
	  sep #$20
	  ldx #01
	  
   
    @p3check_right: 
      lda #BUTTON_RIGHT
	  sta CurrentButton
      and SJoy3, X
	  tay
	  cpy CurrentButton
      bne @p3check_left
	  sep #$30
	  lda #$00
	  sta player.3.headingX
	  ldx #right_velocity
      stx player.3.targetVelocityX
	  rep #$10
      rts
    @p3check_left:
	 
      lda #BUTTON_LEFT
	  sta CurrentButton
      and SJoy3, X 
	  tay
	  cpy CurrentButton
      bne @p3no_direction
	  sep #$30
	  lda #$01
	  sta player.3.headingX
      ldx #left_velocity
      stx player.3.targetVelocityX
	  rep #$10
	  
      rts
	  
    @p3no_direction:
      lda #0
      sta player.3.targetVelocityX
	  
      rts
    


P3_accelerate_x
    ;  lda player.3.motionState;
   ;   cmp Airborne
   ;   bne @p3accelerate
    ;@p3airborne_accel:
      ; When airborne there is no friction, so ignore target velocities of 0
      sep #$20
	  rep #$10
	  
	  
	  lda player.3.targetVelocityX
	  cmp #$00
      bne @p3check_directional_velocity
	  
	;no_target_velocity
	  lda player.3.headingX
	  cmp #$00
      bcs @p3negative_deccel_x
    @p3positive_deccel_x:
      ; If moving right, only accelerate if the target velocity is higher
	  lda player.3.velocityX
	  sbc player.3.targetVelocityX
      bmi @p3decelerate
      rts
    @p3negative_deccel_x:
      ; Similarly, if moving left only do so if the target velocity is lower
      lda player.3.velocityX
	  sbc player.3.targetVelocityX
      bpl @p3decelerate
      rts
	  
      
    @p3check_directional_velocity:
      lda player.3.headingX
	  cmp #$00
      bcc @p3negative_accel_x
    @p3positive_accel_x:
      ; If moving right, only accelerate if the target velocity is higher
	  lda player.3.velocityX
	  sbc player.3.targetVelocityX
      bmi @p3accelerate
      rts
    @p3negative_accel_x:
      ; Similarly, if moving left only do so if the target velocity is lower
      lda player.3.velocityX
	  sbc player.3.targetVelocityX
      bpl @p3accelerate
      rts
    
		
	
	@p3accelerate:
     
      lda player.3.velocityX;
      sec
      sbc player.3.targetVelocityX;
      bne @p3check_greater
      rts
    @p3check_greater:
      bmi @p3lesser
	  rep #$30
	  lda #$00FF
	  and player.3.velocityX
	  tax 
	  sep #$10
      dex
	  stx player.3.velocityX;	
	  rep #$30
	  sep #$20	  
      rts
    @p3lesser:
     
	  rep #$30
	  lda #$00FF
	  and player.3.velocityX
	  tax 
	  sep #$10
      inx
	  stx player.3.velocityX;	
	  rep #$30
	  sep #$20  
      rts
	  
	  
	@p3decelerate:
     
      lda player.3.velocityX;
      sec
      sbc player.3.targetVelocityX;
      bne @p3check_greater_dec
      rts
    @p3check_greater_dec:
      bmi @p3lesserDec
	  rep #$30
	  lda #$00FF
	  and player.3.velocityX
	  tax 
	  sep #$10
      dex
	  dex
	  stx player.3.velocityX;	
	  rep #$30
	  sep #$20	  
      rts
    @p3lesserDec:
     
	  rep #$30
	  lda #$00FF
	  and player.3.velocityX
	  tax 
	  sep #$10
      inx
	  inx
	  stx player.3.velocityX;	
	  rep #$30
	  sep #$20  
      rts


P3_apply_velocity_x
 
     lda player.3.headingX
     cmp #$01
	 beq @p3negative_velocity_x
	  
     @p3positive_velocity_x:
      REP #$30
	  clc
	  lda #$00FF
	  and player.3.velocityX
	  sta $03
	  lda player.3.positionX_Lo
      adc $03
      sta player.3.positionX_Lo;
	  SEP #$20
	  rts
	 
   @p3negative_velocity_x:
      REP #$30
	  clc
	  lda #$00FF
	  and player.3.velocityX
	  sta $03
	  lda player.3.positionX_Lo
      sbc $03
      sta player.3.positionX_Lo;
	  SEP #$20
	  rts


P3_bound_position_x
   ;   ; Convert the fixed point position coordinate into screen coordinates
   
    ldy #$01
      lda player.3.positionX_Lo
      sta $00
      lda player.3.positionX_Lo, Y
      sta $01
      lsr $01
      ror $00
      lsr $01
      ror $00
      lsr $01
      ror $00
      lsr $01
      ror $00
      lda $00
      sta player.3.spriteX_Lo
	  lda $01
	  sta player.3.spriteX_Hi
   
   ;   ldy sy
	;  lda player.3.positionX;
   ;   sta $00
   ;   lda player.3.positionX;
   ;   sta $01
   ;   lsr $01
   ;   ror $00
   ;   lsr $01
   ;   ror $00
   ;   lsr $01
   ;   ror $00
   ;   lsr $01
   ;   ror $00
   ;   ; Assume that everything is fine and save the sprite position
   ;   lda $00
   ;   ;sta player.3.spriteX;
   ;   ; Check if we are moving left or right (negative or positive respectively)
   ;   lda player.3.velocityX;
   ;   bmi @p3negative_position_x
   ; @p3positive_position_x:
   ;   lda $01
   ;   bne @p3bound_upper
   ;   lda $00
   ;   cmp #239
   ;   bcs @p3bound_upper
   ;   rts
   ; @p3bound_upper:
   ;   ; $EF = 239 = 255 - 16, this is the right bound since the screen is 256 pixels
   ;   ; wide and the character is 16 pixels wide.
   ;   ;lda #$EF
   ;   ;sta player.3.spriteX;
   ;   ;lda #$0E
   ;   ;sta player.3.positionX+1;
   ;   ;lda #$F0
   ;   ;sta player.3.positionX;
   ;   ; Finally, set the velocity to 0 since the player is being "stopped"
   ;   ;lda #0
   ;   ;sta player.3.velocityX;
   ;   rts
   ; @p3negative_position_x:
   ;   ; The negative case is really simple, just check if the high order byte of the
   ;   ; 12.4 fixed point position is negative. If so bound everything to 0.
   ;   ;lda player.3.positionX+1;
   ;   bmi @p3bound_lower
   ;   rts
   ; @p3bound_lower:
   ;   ;lda #0
   ;   ;sta player.3.positionX;
   ;   ;sta player.3.positionX+1;
   ;   ;sta player.3.spriteX;
   ;   ;sta player.3.velocityX;
   ;   rts



P3_Sprite_update
   ;   jsr update_motion_state
   ;   jsr update_animation_frame
   ;   jsr update_heading
   ;   jsr update_idle_state
   ;   jsr update_sprite_tiles
   ;   jsr update_sprite_position
      rts
 

P3_update_motion_state
      lda player.3.motionState
      cmp Airborne
      bcc @p3grounded
    @p3airborne_motion_state:
      rts
    @p3grounded:
      ; If spriteX == 0: STILL    // Left bound animation fix
      ; If spriteX == MAX: STILL  // Right bound animation fix
      ; If T = V:
      ;   // Steady motion
      ;   If T == 0: STILL
      ;   Else: WALK
      ; If T <> V:
      ;   // Accelerating
      ;   If <- or -> being pressed:
      ;     If T > 0 && V < 0: PIVOT
      ;     If T < 0 && V > 0: PIVOT
      ;   Else: WALK
      lda player.3.spriteX_Hi
      beq @p3stand
      cmp #$EF
      beq @p3stand
      lda player.3.targetVelocityX;
      cmp player.3.velocityX;
      bne @p3accelerating
    @p3steady:
      lda player.3.velocityX;
      beq @p3stand
      bne @p3walk_motion_state
    @p3stand:
      lda Still
      sta player.3.motionState;
      rts
    @p3accelerating:
      lda BUTTON_LEFT
      ora BUTTON_RIGHT
      and Joy1Press ;isButtonHeld
      beq @p3walk_motion_state
      lda #%10000000
      and player.3.targetVelocityX;
      sta $00
      lda #%10000000
      and player.3.velocityX;
      cmp $00
      ;beq @p3walk_motion_state
    @p3pivot_motion_state:
      lda Pivot
      sta player.3.motionState;
      rts
    @p3walk_motion_state:
      lda Walk
      sta player.3.motionState;
      rts


P3_update_animation_frame
      ; If V == 0:
      ;   Set initial timer
      ; Else:
      ;   Decrement timer
      ;   If frame timer == 0:
      ;     Reset frame timer based on V
      ;     Increment the frame
      lda player.3.velocityX;
      bne @p3moving
      ;lda delay_by_velocity
      sta player.3.animationTimer;
      rts
    @p3moving:
      ;dec player.3.animationTimer;
      beq @p3next_frame
      rts
    @p3next_frame:
      ldx player.3.velocityX;
      bpl @p3transition_state
      lda #0
      sec
      sbc player.3.velocityX;
      tax
    @p3transition_state:
      ;lda delay_by_velocity, x
      sta player.3.animationTimer;
      lda #1
      eor player.3.animationFrame;
      sta player.3.animationFrame;
      rts
    ;delay_by_velocity:
      ;.byte 12, 11, 11, 11, 11, 11, 10, 10, 10, 10, 10
      ;.byte 9, 9, 9, 9, 9, 8, 8, 8, 8, 8, 7, 7, 7, 7, 7
      ;.byte 6, 6, 6, 6, 6, 5, 5, 5, 5, 5, 4, 4, 4, 4, 4


P3_update_heading
      ; If the target velocity is 0 then the player isn't pressing left or right and
      ; the heading doesn't need to change.
      lda player.3.targetVelocityX;
      bne @p3check_headingX
      rts
      ; If the target velocity is non-zero, check to see if player is heading in the
      ; desired direction.
    @p3check_headingX:
      asl
      lda #0
      rol
      cmp player.3.headingX;
      bne @p3update_headingX
      rts
    @p3update_headingX:
      ; If the desired heading is not equal to the current heading based on the
      ; target velocity, then update the heading.
      sta player.3.headingX;
      ; Toggle the "horizontal" mirroring on the character sprites
      lda #%01000000
      ;eor $200 + OAM_ATTR
      ;sta $200 + OAM_ATTR
      ;sta $204 + OAM_ATTR
      rts


P3_update_idle_state
     ; lda player.3.motionState;
     ; cmp Still
     ; beq @p3update_timer
     ; ;lda ;timers
     ; sta player.3.idleTimer;
     ; lda Still
     ; sta player.3.idleState;
      rts
    @p3update_timer:
      ;dec player.3.idleTimer;
      beq @p3update_state
      rts
    @p3update_state:
      ldx player.3.idleState;
      inx
      cpx #4
      bne @p3set_state
      ldx #0
    @p3set_state:
      stx player.3.idleState;
      ;lda ;timers, x
      sta player.3.idleTimer;
      rts
    ;timers:
      ;.byte 245, 10, 10, 10


P3_update_sprite_tiles
      lda player.3.motionState;
      cmp Airborne
      beq @p3airborne_sptite_tiles
      cmp Pivot
      beq @p3pivot_sprite_tiles
      cmp Walk
      beq @p3walk_sprite_tiles
    @p3still:
      lda player.3.idleState;
      asl
      asl
      clc
      adc player.3.headingX;
      tax
      ;lda idle_tiles, x
      ;sta $200 + OAM_TILE
      ;lda idle_tiles + 2, x
      ;sta $204 + OAM_TILE
      rts
    @p3airborne_sptite_tiles:
      ldx player.3.headingX;
      ;lda jumping_tiles, x
      ;sta $200 + OAM_TILE
      ;lda jumping_tiles + 2, x
      ;sta $204 + OAM_TILE
      rts
    @p3walk_sprite_tiles:
      lda player.3.animationFrame;
      asl
      asl
      clc
      adc player.3.headingX;
      tax
      ;lda walk_tiles, x
      ;sta $200 + OAM_TILE
      ;lda walk_tiles +2, x
      ;sta $204 + OAM_TILE
      rts
    @p3pivot_sprite_tiles:
      ldx player.3.headingX;
      ;lda pivot_tiles, x
      ;sta $200 + OAM_TILE
      ;lda pivot_tiles + 2, x
      ;sta $204 + OAM_TILE
      rts
    ;jumping_tiles:
      ;.byte $88, $8A, $8A, $88
    ;pivot_tiles:
      ;.byte $98, $9A, $9A, $98 ; Pivot is the same no matter the animation frame
    ;walk_tiles:
      ;.byte $80, $82, $82, $80 ; Frame 1
      ;.byte $84, $86, $86, $84 ; Frame 2
    ;idle_tiles:
      ;.byte $80, $82, $82, $80
      ;.byte $9C, $9E, $9E, $9C
      ;.byte $80, $82, $82, $80
      ;.byte $9C, $9E, $9E, $9C


P3_update_sprite_position
      ; This is computed in `bound_position` above, so all we have to do is set
      ; the sprite coordinates appropriately.
      lda player.3.spriteX_Hi
      ;sta $200 + OAM_X
      clc
      adc #8
      ;sta $204 + OAM_X
      lda player.3.spriteY_Hi
      sta $200
      sta $204
      rts 

.ends

.bank 0 slot 0
.org 0
.section "Player 4 Routine"  	
	  	  
MovementUpdateP4:
      jsr P3_set_target_y_velocity
      jsr P3_accelerate_y
      jsr P3_apply_velocity_y
      jsr P3_bound_position_y
      jsr P3_set_target_x_velocity
      jsr P3_accelerate_x
      jsr P3_apply_velocity_x
      jsr P3_bound_position_x
      rts
	  	  	  
	  
;================================================================		
;==============Player 4 routine==================================	
;================================================================	
;================================================================	  
	  
P4_set_target_y_velocity
      ; Check if the B button is being pressed and save the state in the X
      ; register

	  Rep #$30
	  lda #$0000
	  sep #$20
	  ldx #01
	  
   
    @p4check_down: 
      lda #BUTTON_DOWN
	  sta CurrentButton
      and SJoy4, X
	  tay
	  cpy CurrentButton
      bne @p4check_up
	  sep #$30
	  lda #$00
	  sta player.4.headingY
	  ldx #down_velocity
      stx player.4.targetVelocityY
	  rep #$10
      rts
    @p4check_up:
	 
      lda #BUTTON_UP
	  sta CurrentButton
      and SJoy4, X 
	  tay
	  cpy CurrentButton
      bne @p4no_Y_direction
	  sep #$30
	  lda #$01
	  sta player.4.headingY
      ldx #down_velocity
      stx player.4.targetVelocityY
	  rep #$10
	  
      rts
	  
    @p4no_Y_direction:
      lda #0
      sta player.4.targetVelocityY
	  
      rts
    


P4_accelerate_y
    ;  lda player.4.motionState;
    @p4airborne_accel:
      ; When airborne there is no friction, so ignore target velocities of 0
      sep #$20
	  rep #$10
	  
	  
	  lda player.4.targetVelocityY
	  cmp #$00
      bne @p4check_directional_velocity_y
	  
	;no_target_velocity
	  lda player.4.headingY
	  cmp #$00
      bcs @p4negative_deccel_y
    @p4positive_deccel_y:
      ; If moving right, only accelerate if the target velocity is higher
	  lda player.4.velocityY
	  sbc player.4.targetVelocityY
      bmi @p4decelerate_y
      rts
    @p4negative_deccel_y:
      ; Similarly, if moving left only do so if the target velocity is lower
      lda player.4.velocityY
	  sbc player.4.targetVelocityY
      bpl @p4decelerate_y
      rts
	  
      
   
    @p4check_directional_velocity_y:
      lda player.4.headingY
	  cmp #$00
      bcc @p4negative_accel_y
    @p4positive_accel_y:
      ; If moving right, only accelerate if the target velocity is higher
	  lda player.4.velocityY
	  sbc player.4.targetVelocityY
      bmi @p4accelerate_y
      rts
    @p4negative_accel_y:
      ; Similarly, if moving left only do so if the target velocity is lower
      lda player.4.velocityY
	  sbc player.4.targetVelocityY
      bpl @p4accelerate_y
      rts
    
		
	@p4accelerate_y:
     
      lda player.4.velocityY;
      sec
      sbc player.4.targetVelocityY;
      bne @p4check_greater_y
      rts
    @p4check_greater_y:
      bmi @p4lesser_y
	  rep #$30
	  lda #$00FF
	  and player.4.velocityY
	  tax 
	  sep #$10
      dex
	  stx player.4.velocityY;	
	  rep #$30
	  sep #$20	  
      rts
    @p4lesser_y:
     
	  rep #$30
	  lda #$00FF
	  and player.4.velocityY
	  tax 
	  sep #$10
      inx
	  stx player.4.velocityY;	
	  rep #$30
	  sep #$20  
      rts
	  
	  
	@p4decelerate_y:
     
      lda player.4.velocityY;
      sec
      sbc player.4.targetVelocityY;
      bne @p4check_greater_dec_y
      rts
    @p4check_greater_dec_y:
      bmi @p4lesserDec_y
	  rep #$30
	  lda #$00FF
	  and player.4.velocityY
	  tax 
	  sep #$10
      dex
	  dex
	  stx player.4.velocityY;	
	  rep #$30
	  sep #$20	  
      rts
    @p4lesserDec_y:
     
	  rep #$30
	  lda #$00FF
	  and player.4.velocityY
	  tax 
	  sep #$10
      inx
	  inx
	  stx player.4.velocityY;	
	  rep #$30
	  sep #$20  
      rts


P4_apply_velocity_y
 
     lda player.4.headingY
     cmp #$01
	 beq @p4negative_velocity_Y
	  
     @p4positive_velocity_Y:
      REP #$30
	  clc
	  lda #$00FF
	  and player.4.velocityY
	  sta $03
	  lda player.4.positionY_Lo
      adc $03
      sta player.4.positionY_Lo;
	  SEP #$20
	  rts
	 
   @p4negative_velocity_Y:
      REP #$30
	  clc
	  lda #$00FF
	  and player.4.velocityY
	  sta $03
	  lda player.4.positionY_Lo
      sbc $03
      sta player.4.positionY_Lo;
	  SEP #$20
	  rts


P4_bound_position_y
   ;   ; Convert the fixed point position coordinate into screen coordinates
   
    ldy #$01
      lda player.4.positionY_Lo
      sta $00
      lda player.4.positionY_Lo, Y
      sta $01
      lsr $01
      ror $00
      lsr $01
      ror $00
      lsr $01
      ror $00
      lsr $01
      ror $00
      lda $00
      sta player.4.spriteY_Lo
	  lda $01
	  sta player.4.spriteY_Hi

;================================================================	
;================================================================	 
	  

P4_set_target_x_velocity
      ; Check if the B button is being pressed and save the state in the X
      ; register

	  Rep #$30
	  lda #$0000
	  sep #$20
	  ldx #01
	  
   
    @p4check_right: 
      lda #BUTTON_RIGHT
	  sta CurrentButton
      and SJoy4, X
	  tay
	  cpy CurrentButton
      bne @p4check_left
	  sep #$30
	  lda #$00
	  sta player.4.headingX
	  ldx #right_velocity
      stx player.4.targetVelocityX
	  rep #$10
      rts
    @p4check_left:
	 
      lda #BUTTON_LEFT
	  sta CurrentButton
      and SJoy4, X 
	  tay
	  cpy CurrentButton
      bne @p4no_direction
	  sep #$30
	  lda #$01
	  sta player.4.headingX
      ldx #left_velocity
      stx player.4.targetVelocityX
	  rep #$10
	  
      rts
	  
    @p4no_direction:
      lda #0
      sta player.4.targetVelocityX
	  
      rts
    


P4_accelerate_x
    ;  lda player.4.motionState;
   ;   cmp Airborne
   ;   bne @p4accelerate
    ;@p4airborne_accel:
      ; When airborne there is no friction, so ignore target velocities of 0
      sep #$20
	  rep #$10
	  
	  
	  lda player.4.targetVelocityX
	  cmp #$00
      bne @p4check_directional_velocity
	  
	;no_target_velocity
	  lda player.4.headingX
	  cmp #$00
      bcs @p4negative_deccel_x
    @p4positive_deccel_x:
      ; If moving right, only accelerate if the target velocity is higher
	  lda player.4.velocityX
	  sbc player.4.targetVelocityX
      bmi @p4decelerate
      rts
    @p4negative_deccel_x:
      ; Similarly, if moving left only do so if the target velocity is lower
      lda player.4.velocityX
	  sbc player.4.targetVelocityX
      bpl @p4decelerate
      rts
	  
      
    @p4check_directional_velocity:
      lda player.4.headingX
	  cmp #$00
      bcc @p4negative_accel_x
    @p4positive_accel_x:
      ; If moving right, only accelerate if the target velocity is higher
	  lda player.4.velocityX
	  sbc player.4.targetVelocityX
      bmi @p4accelerate
      rts
    @p4negative_accel_x:
      ; Similarly, if moving left only do so if the target velocity is lower
      lda player.4.velocityX
	  sbc player.4.targetVelocityX
      bpl @p4accelerate
      rts
    
		
	
	@p4accelerate:
     
      lda player.4.velocityX;
      sec
      sbc player.4.targetVelocityX;
      bne @p4check_greater
      rts
    @p4check_greater:
      bmi @p4lesser
	  rep #$30
	  lda #$00FF
	  and player.4.velocityX
	  tax 
	  sep #$10
      dex
	  stx player.4.velocityX;	
	  rep #$30
	  sep #$20	  
      rts
    @p4lesser:
     
	  rep #$30
	  lda #$00FF
	  and player.4.velocityX
	  tax 
	  sep #$10
      inx
	  stx player.4.velocityX;	
	  rep #$30
	  sep #$20  
      rts
	  
	  
	@p4decelerate:
     
      lda player.4.velocityX;
      sec
      sbc player.4.targetVelocityX;
      bne @p4check_greater_dec
      rts
    @p4check_greater_dec:
      bmi @p4lesserDec
	  rep #$30
	  lda #$00FF
	  and player.4.velocityX
	  tax 
	  sep #$10
      dex
	  dex
	  stx player.4.velocityX;	
	  rep #$30
	  sep #$20	  
      rts
    @p4lesserDec:
     
	  rep #$30
	  lda #$00FF
	  and player.4.velocityX
	  tax 
	  sep #$10
      inx
	  inx
	  stx player.4.velocityX;	
	  rep #$30
	  sep #$20  
      rts


P4_apply_velocity_x
 
     lda player.4.headingX
     cmp #$01
	 beq @p4negative_velocity_x
	  
     @p4positive_velocity_x:
      REP #$30
	  clc
	  lda #$00FF
	  and player.4.velocityX
	  sta $03
	  lda player.4.positionX_Lo
      adc $03
      sta player.4.positionX_Lo;
	  SEP #$20
	  rts
	 
   @p4negative_velocity_x:
      REP #$30
	  clc
	  lda #$00FF
	  and player.4.velocityX
	  sta $03
	  lda player.4.positionX_Lo
      sbc $03
      sta player.4.positionX_Lo;
	  SEP #$20
	  rts


P4_bound_position_x
   ;   ; Convert the fixed point position coordinate into screen coordinates
   
    ldy #$01
      lda player.4.positionX_Lo
      sta $00
      lda player.4.positionX_Lo, Y
      sta $01
      lsr $01
      ror $00
      lsr $01
      ror $00
      lsr $01
      ror $00
      lsr $01
      ror $00
      lda $00
      sta player.4.spriteX_Lo
	  lda $01
	  sta player.4.spriteX_Hi
   
   ;   ldy sy
	;  lda player.4.positionX;
   ;   sta $00
   ;   lda player.4.positionX;
   ;   sta $01
   ;   lsr $01
   ;   ror $00
   ;   lsr $01
   ;   ror $00
   ;   lsr $01
   ;   ror $00
   ;   lsr $01
   ;   ror $00
   ;   ; Assume that everything is fine and save the sprite position
   ;   lda $00
   ;   ;sta player.4.spriteX;
   ;   ; Check if we are moving left or right (negative or positive respectively)
   ;   lda player.4.velocityX;
   ;   bmi @p4negative_position_x
   ; @p4positive_position_x:
   ;   lda $01
   ;   bne @p4bound_upper
   ;   lda $00
   ;   cmp #239
   ;   bcs @p4bound_upper
   ;   rts
   ; @p4bound_upper:
   ;   ; $EF = 239 = 255 - 16, this is the right bound since the screen is 256 pixels
   ;   ; wide and the character is 16 pixels wide.
   ;   ;lda #$EF
   ;   ;sta player.4.spriteX;
   ;   ;lda #$0E
   ;   ;sta player.4.positionX+1;
   ;   ;lda #$F0
   ;   ;sta player.4.positionX;
   ;   ; Finally, set the velocity to 0 since the player is being "stopped"
   ;   ;lda #0
   ;   ;sta player.4.velocityX;
   ;   rts
   ; @p4negative_position_x:
   ;   ; The negative case is really simple, just check if the high order byte of the
   ;   ; 12.4 fixed point position is negative. If so bound everything to 0.
   ;   ;lda player.4.positionX+1;
   ;   bmi @p4bound_lower
   ;   rts
   ; @p4bound_lower:
   ;   ;lda #0
   ;   ;sta player.4.positionX;
   ;   ;sta player.4.positionX+1;
   ;   ;sta player.4.spriteX;
   ;   ;sta player.4.velocityX;
   ;   rts



P4_Sprite_update
   ;   jsr update_motion_state
   ;   jsr update_animation_frame
   ;   jsr update_heading
   ;   jsr update_idle_state
   ;   jsr update_sprite_tiles
   ;   jsr update_sprite_position
      rts
 

P4_update_motion_state
      lda player.4.motionState
      cmp Airborne
      bcc @p4grounded
    @p4airborne_motion_state:
      rts
    @p4grounded:
      ; If spriteX == 0: STILL    // Left bound animation fix
      ; If spriteX == MAX: STILL  // Right bound animation fix
      ; If T = V:
      ;   // Steady motion
      ;   If T == 0: STILL
      ;   Else: WALK
      ; If T <> V:
      ;   // Accelerating
      ;   If <- or -> being pressed:
      ;     If T > 0 && V < 0: PIVOT
      ;     If T < 0 && V > 0: PIVOT
      ;   Else: WALK
      lda player.4.spriteX_Hi
      beq @p4stand
      cmp #$EF
      beq @p4stand
      lda player.4.targetVelocityX;
      cmp player.4.velocityX;
      bne @p4accelerating
    @p4steady:
      lda player.4.velocityX;
      beq @p4stand
      bne @p4walk_motion_state
    @p4stand:
      lda Still
      sta player.4.motionState;
      rts
    @p4accelerating:
      lda BUTTON_LEFT
      ora BUTTON_RIGHT
      and Joy1Press ;isButtonHeld
      beq @p4walk_motion_state
      lda #%10000000
      and player.4.targetVelocityX;
      sta $00
      lda #%10000000
      and player.4.velocityX;
      cmp $00
      ;beq @p4walk_motion_state
    @p4pivot_motion_state:
      lda Pivot
      sta player.4.motionState;
      rts
    @p4walk_motion_state:
      lda Walk
      sta player.4.motionState;
      rts


P4_update_animation_frame
      ; If V == 0:
      ;   Set initial timer
      ; Else:
      ;   Decrement timer
      ;   If frame timer == 0:
      ;     Reset frame timer based on V
      ;     Increment the frame
      lda player.4.velocityX;
      bne @p4moving
      ;lda delay_by_velocity
      sta player.4.animationTimer;
      rts
    @p4moving:
      ;dec player.4.animationTimer;
      beq @p4next_frame
      rts
    @p4next_frame:
      ldx player.4.velocityX;
      bpl @p4transition_state
      lda #0
      sec
      sbc player.4.velocityX;
      tax
    @p4transition_state:
      ;lda delay_by_velocity, x
      sta player.4.animationTimer;
      lda #1
      eor player.4.animationFrame;
      sta player.4.animationFrame;
      rts
    ;delay_by_velocity:
      ;.byte 12, 11, 11, 11, 11, 11, 10, 10, 10, 10, 10
      ;.byte 9, 9, 9, 9, 9, 8, 8, 8, 8, 8, 7, 7, 7, 7, 7
      ;.byte 6, 6, 6, 6, 6, 5, 5, 5, 5, 5, 4, 4, 4, 4, 4


P4_update_heading
      ; If the target velocity is 0 then the player isn't pressing left or right and
      ; the heading doesn't need to change.
      lda player.4.targetVelocityX;
      bne @p4check_headingX
      rts
      ; If the target velocity is non-zero, check to see if player is heading in the
      ; desired direction.
    @p4check_headingX:
      asl
      lda #0
      rol
      cmp player.4.headingX;
      bne @p4update_headingX
      rts
    @p4update_headingX:
      ; If the desired heading is not equal to the current heading based on the
      ; target velocity, then update the heading.
      sta player.4.headingX;
      ; Toggle the "horizontal" mirroring on the character sprites
      lda #%01000000
      ;eor $200 + OAM_ATTR
      ;sta $200 + OAM_ATTR
      ;sta $204 + OAM_ATTR
      rts


P4_update_idle_state
     ; lda player.4.motionState;
     ; cmp Still
     ; beq @p4update_timer
     ; ;lda ;timers
     ; sta player.4.idleTimer;
     ; lda Still
     ; sta player.4.idleState;
      rts
    @p4update_timer:
      ;dec player.4.idleTimer;
      beq @p4update_state
      rts
    @p4update_state:
      ldx player.4.idleState;
      inx
      cpx #4
      bne @p4set_state
      ldx #0
    @p4set_state:
      stx player.4.idleState;
      ;lda ;timers, x
      sta player.4.idleTimer;
      rts
    ;timers:
      ;.byte 245, 10, 10, 10


P4_update_sprite_tiles
      lda player.4.motionState;
      cmp Airborne
      beq @p4airborne_sptite_tiles
      cmp Pivot
      beq @p4pivot_sprite_tiles
      cmp Walk
      beq @p4walk_sprite_tiles
    @p4still:
      lda player.4.idleState;
      asl
      asl
      clc
      adc player.4.headingX;
      tax
      ;lda idle_tiles, x
      ;sta $200 + OAM_TILE
      ;lda idle_tiles + 2, x
      ;sta $204 + OAM_TILE
      rts
    @p4airborne_sptite_tiles:
      ldx player.4.headingX;
      ;lda jumping_tiles, x
      ;sta $200 + OAM_TILE
      ;lda jumping_tiles + 2, x
      ;sta $204 + OAM_TILE
      rts
    @p4walk_sprite_tiles:
      lda player.4.animationFrame;
      asl
      asl
      clc
      adc player.4.headingX;
      tax
      ;lda walk_tiles, x
      ;sta $200 + OAM_TILE
      ;lda walk_tiles +2, x
      ;sta $204 + OAM_TILE
      rts
    @p4pivot_sprite_tiles:
      ldx player.4.headingX;
      ;lda pivot_tiles, x
      ;sta $200 + OAM_TILE
      ;lda pivot_tiles + 2, x
      ;sta $204 + OAM_TILE
      rts
    ;jumping_tiles:
      ;.byte $88, $8A, $8A, $88
    ;pivot_tiles:
      ;.byte $98, $9A, $9A, $98 ; Pivot is the same no matter the animation frame
    ;walk_tiles:
      ;.byte $80, $82, $82, $80 ; Frame 1
      ;.byte $84, $86, $86, $84 ; Frame 2
    ;idle_tiles:
      ;.byte $80, $82, $82, $80
      ;.byte $9C, $9E, $9E, $9C
      ;.byte $80, $82, $82, $80
      ;.byte $9C, $9E, $9E, $9C


P4_update_sprite_position
      ; This is computed in `bound_position` above, so all we have to do is set
      ; the sprite coordinates appropriately.
      lda player.4.spriteX_Hi
      ;sta $200 + OAM_X
      clc
      adc #8
      ;sta $204 + OAM_X
      lda player.4.spriteY_Hi
      sta $200
      sta $204
      rts 	  
.ENDS