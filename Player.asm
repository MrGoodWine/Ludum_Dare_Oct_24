
.DEFINE initialSpriteX 			$99
.DEFINE initialVelocityX 		$00
.DEFINE initialPositionX_LO 	$77
.DEFINE initialPositionX_HI		$00
.DEFINE initialSpriteY 			$55
.DEFINE initialVelocityY 		$44
.DEFINE jumpVelocity			$DD
.DEFINE initialPositionY_LO 	$03
.DEFINE initialPositionY_HI 	$00
.DEFINE initID					$00

.DEFINE right_velocity 			$24
.DEFINE left_velocity 			$24


  ;Heading
.DEFINE Right	0
.DEFINE Left	1

  ;MotionState
.DEFINE Standing		0
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

	playerID			DB
	targetVelocityX   	DB ;C1
	velocityX        	DB ;C2
	positionX_Lo       	DB ;C3
	positionX_Hi       	DB ;C4
	spriteX_Lo       	DB ;C5
	spriteX_Hi       	DB ;C6
	heading          	DB ;C7

	velocityY        	DB ;C8
	positionY_Lo        DB ;C9
	positionY_Hi        DB ;CA
	spriteY_Lo       	DB ;CB
	spriteY_Hi       	DB ;CC

	motionState      	DB ;CD
	animationFrame   	DB ;CE
	animationTimer   	DB ;CF
	idleState         	DB 
	idleTimer        	DB 
	byte19				DB
	byte20				DB
	byte21				DB
	byte22				DB
	byte23				DB
	byte24				DB
	byte25				DB
	byte26				DB
	byte27				DB
	byte28				DB
	byte29				DB
	byte30				DB
	byte31				DB
	byte32				DB


.ENDST

.ENUM $C0
player INSTANCEOF playerCharacter 5
.ENDE

.bank 0 slot 0
.org 0
.section "Player Controls"
;--------------------------------------

PlayerInit:
    
	stx initID
	rol initID
	rol initID
	rol initID
	rol initID
	rol initID
	ldy initID
    jsr init_x
    jsr init_y
    ;jsr init_sprites
	rts


init_x:
    lda #initialSpriteX
    sta player.1.spriteX_Lo
    lda #initialPositionX_LO
    sta player.1.positionX_Lo
    lda #initialPositionX_HI
	sta player.1.positionX_Hi
    lda #initialVelocityX
    sta player.1.velocityX
    rts



init_y:
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


;================================================================	  
	  
MovementUpdate:

	  jsr update_vertical_motion
      jsr set_target_x_velocity
      jsr accelerate_x
      jsr apply_velocity_x
      jsr bound_position_x

      rts


update_vertical_motion:
      clc
	  lda player.1.motionState
      cmp #Airborne
	  bcs @airborne_motion
	  
   @check_jump:
	 ldy #1
     lda Joy1Press,y
     cmp #BUTTON_B
     beq @begin_jump
     lda #0
     sta player.1.velocityY
	 
     rts
   @begin_jump:
     sed
     lda #jumpVelocity
     sta player.1.velocityY
	 cld
     lda #Airborne
     sta player.1.motionState

    @airborne_motion:
      jsr update_jump_velocity
      jsr apply_velocity_y
      jsr bound_position_y
      rts
    

update_jump_velocity

   ;   ; Determine if the Y velocity should decelerate quickly or slowly.
   ;   ; The velocity decelerates slowly (1/frame) for up to 24 frames as
   ;   ; long as the player holds the "A Button". After that it goes quickly
   ;   ; (5/frame)
	;  
      ldx #5
      lda player.1.velocityY;
      cmp #$E0
      bpl @decelerateY
      ldy #1
      lda Joy1Press,y ;isButtonHeld
      cmp #BUTTON_B
      beq @decelerateY
      ldx #1
    @decelerateY:
      ; Perform the deceleration (the code above stores the rate in Y)
      txa
      clc
      adc player.1.velocityY;
      bmi @store_velocity
    @check_Falling_speed:
      ; If the velocity is positive, check and cap the falling speed
      cmp #MaxFallSpeed
      bcc @store_velocity
      lda #MaxFallSpeed
    @store_velocity:
      ; Finally store the velocity and exit
      sta player.1.velocityY;
      rts


apply_velocity_y
     REP #$30
	  ;check_jump
	 ldy #1
     lda Joy1Press,y
     and #BUTTON_B
     bne @negative_velocity_y
	  
     @positive_velocity_y:
      clc
	  lda #$00FF
	  and player.1.velocityY
	  sta $03
	  lda player.1.positionY_Lo
      adc $03
      sta player.1.positionY_Lo
	  SEP #$20
	  rts
    
    @negative_velocity_y:
	  clc
	  lda #$00FF
	  and player.1.velocityY
	  sta $03
	  lda player.1.positionY_Lo
      sbc $03
      sta player.1.positionY_Lo
	  SEP #$20
	  rts


bound_position_y
      ; Convert from 12.4 fixed point into screen coordinates
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
      sta player.1.spriteY_Lo
	  lda $01
	  sta player.1.spriteY_Hi
    @check_landing:
    ;  ; Check to see if the player has landed
	  rep #$30
	  lda player.1.spriteY_Lo
      cmp #FloorHeight
      bpl @land
	  lda #Airborne
      sta player.1.motionState
	  sep #$20
      rts
    @land:
    ;  ; Land by re-initializing the Y variables and resetting the  motion state
	  rep #$30
	  lda #FloorHeight
	  sta player.1.spriteY_Lo	  
	  sta player.1.positionY_Lo
      lda #Still
      sta player.1.motionState
	  sep #$20
      rts


set_target_x_velocity
      ; Check if the B button is being pressed and save the state in the X
      ; register

	  Rep #$30
	  lda #$0000
	  sep #$20
	  ldx #01
	  
   
    @check_right: 
      lda #BUTTON_RIGHT
	  sta CurrentButton
      and SJoy1, X
	  tay
	  cpy CurrentButton
      bne @check_left
	  sep #$30
	  lda #$00
	  sta player.1.heading
	  ldx #right_velocity
      stx player.1.targetVelocityX
	  rep #$10
      rts
    @check_left:
	 
      lda #BUTTON_LEFT
	  sta CurrentButton
      and SJoy1, X 
	  tay
	  cpy CurrentButton
      bne @no_direction
	  sep #$30
	  lda #$01
	  sta player.1.heading
      ldx #left_velocity
      stx player.1.targetVelocityX
	  rep #$10
	  
      rts
	  
    @no_direction:
      lda #0
      sta player.1.targetVelocityX
	  
      rts
    


accelerate_x
    ;  lda player.1.motionState;
   ;   cmp Airborne
   ;   bne @accelerate
    @airborne_accel:
      ; When airborne there is no friction, so ignore target velocities of 0
      sep #$20
	  rep #$10
	  
	  
	  lda player.1.targetVelocityX
	  cmp #$00
      bne @check_directional_velocity
	  
	;no_target_velocity
	  lda player.1.heading
	  cmp #$00
      bcs @negative_deccel_x
    @positive_deccel_x:
      ; If moving right, only accelerate if the target velocity is higher
	  lda player.1.velocityX
	  sbc player.1.targetVelocityX
      bmi @decelerate
      rts
    @negative_deccel_x:
      ; Similarly, if moving left only do so if the target velocity is lower
      lda player.1.velocityX
	  sbc player.1.targetVelocityX
      bpl @decelerate
      rts
	  
   
   
   
   
    @check_directional_velocity:
      lda player.1.heading;
	  cmp #$00
      bcc @negative_accel_x
    @positive_accel_x:
      ; If moving right, only accelerate if the target velocity is higher
	  lda player.1.velocityX
	  sbc player.1.targetVelocityX
      bmi @accelerate
      rts
    @negative_accel_x:
      ; Similarly, if moving left only do so if the target velocity is lower
      lda player.1.velocityX
	  sbc player.1.targetVelocityX
      bpl @accelerate
      rts
    
	
	
	
	@accelerate:
     
      lda player.1.velocityX;
      sec
      sbc player.1.targetVelocityX;
      bne @check_greater
      rts
    @check_greater:
      bmi @lesser
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
    @lesser:
     
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
	  
	  
	@decelerate:
     
      lda player.1.velocityX;
      sec
      sbc player.1.targetVelocityX;
      bne @check_greater_dec
      rts
    @check_greater_dec:
      bmi @lesserDec
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
    @lesserDec:
     
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


apply_velocity_x
 
     lda player.1.heading
     cmp #$01
	 beq @negative_velocity_x
	  
     @positive_velocity_x:
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
	 
   @negative_velocity_x:
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


bound_position_x
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
   
   ;   ldy sy
	;  lda player.1.positionX;
   ;   sta $00
   ;   lda player.1.positionX;
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
   ;   ;sta player.1.spriteX;
   ;   ; Check if we are moving left or right (negative or positive respectively)
   ;   lda player.1.velocityX;
   ;   bmi @negative_position_x
   ; @positive_position_x:
   ;   lda $01
   ;   bne @bound_upper
   ;   lda $00
   ;   cmp #239
   ;   bcs @bound_upper
   ;   rts
   ; @bound_upper:
   ;   ; $EF = 239 = 255 - 16, this is the right bound since the screen is 256 pixels
   ;   ; wide and the character is 16 pixels wide.
   ;   ;lda #$EF
   ;   ;sta player.1.spriteX;
   ;   ;lda #$0E
   ;   ;sta player.1.positionX+1;
   ;   ;lda #$F0
   ;   ;sta player.1.positionX;
   ;   ; Finally, set the velocity to 0 since the player is being "stopped"
   ;   ;lda #0
   ;   ;sta player.1.velocityX;
   ;   rts
   ; @negative_position_x:
   ;   ; The negative case is really simple, just check if the high order byte of the
   ;   ; 12.4 fixed point position is negative. If so bound everything to 0.
   ;   ;lda player.1.positionX+1;
   ;   bmi @bound_lower
   ;   rts
   ; @bound_lower:
   ;   ;lda #0
   ;   ;sta player.1.positionX;
   ;   ;sta player.1.positionX+1;
   ;   ;sta player.1.spriteX;
   ;   ;sta player.1.velocityX;
   ;   rts



Sprite_update
   ;   jsr update_motion_state
   ;   jsr update_animation_frame
   ;   jsr update_heading
   ;   jsr update_idle_state
   ;   jsr update_sprite_tiles
   ;   jsr update_sprite_position
      rts
 

update_motion_state
      lda player.1.motionState
      cmp Airborne
      bcc @grounded
    @airborne_motion_state:
      rts
    @grounded:
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
      lda player.1.spriteX_Hi
      beq @stand
      cmp #$EF
      beq @stand
      lda player.1.targetVelocityX;
      cmp player.1.velocityX;
      bne @accelerating
    @steady:
      lda player.1.velocityX;
      beq @stand
      bne @walk_motion_state
    @stand:
      lda Still
      sta player.1.motionState;
      rts
    @accelerating:
      lda BUTTON_LEFT
      ora BUTTON_RIGHT
      and Joy1Press ;isButtonHeld
      beq @walk_motion_state
      lda #%10000000
      and player.1.targetVelocityX;
      sta $00
      lda #%10000000
      and player.1.velocityX;
      cmp $00
      ;beq @walk_motion_state
    @pivot_motion_state:
      lda Pivot
      sta player.1.motionState;
      rts
    @walk_motion_state:
      lda Walk
      sta player.1.motionState;
      rts


update_animation_frame
      ; If V == 0:
      ;   Set initial timer
      ; Else:
      ;   Decrement timer
      ;   If frame timer == 0:
      ;     Reset frame timer based on V
      ;     Increment the frame
      lda player.1.velocityX;
      bne @moving
      ;lda delay_by_velocity
      sta player.1.animationTimer;
      rts
    @moving:
      ;dec player.1.animationTimer;
      beq @next_frame
      rts
    @next_frame:
      ldx player.1.velocityX;
      bpl @transition_state
      lda #0
      sec
      sbc player.1.velocityX;
      tax
    @transition_state:
      ;lda delay_by_velocity, x
      sta player.1.animationTimer;
      lda #1
      eor player.1.animationFrame;
      sta player.1.animationFrame;
      rts
    delay_by_velocity:
      ;.byte 12, 11, 11, 11, 11, 11, 10, 10, 10, 10, 10
      ;.byte 9, 9, 9, 9, 9, 8, 8, 8, 8, 8, 7, 7, 7, 7, 7
      ;.byte 6, 6, 6, 6, 6, 5, 5, 5, 5, 5, 4, 4, 4, 4, 4


update_heading
      ; If the target velocity is 0 then the player isn't pressing left or right and
      ; the heading doesn't need to change.
      lda player.1.targetVelocityX;
      bne @check_heading
      rts
      ; If the target velocity is non-zero, check to see if player is heading in the
      ; desired direction.
    @check_heading:
      asl
      lda #0
      rol
      cmp player.1.heading;
      bne @update_heading
      rts
    @update_heading:
      ; If the desired heading is not equal to the current heading based on the
      ; target velocity, then update the heading.
      sta player.1.heading;
      ; Toggle the "horizontal" mirroring on the character sprites
      lda #%01000000
      ;eor $200 + OAM_ATTR
      ;sta $200 + OAM_ATTR
      ;sta $204 + OAM_ATTR
      rts


update_idle_state
     ; lda player.1.motionState;
     ; cmp Still
     ; beq @update_timer
     ; ;lda timers
     ; sta player.1.idleTimer;
     ; lda Still
     ; sta player.1.idleState;
      rts
    @update_timer:
      ;dec player.1.idleTimer;
      beq @update_state
      rts
    @update_state:
      ldx player.1.idleState;
      inx
      cpx #4
      bne @set_state
      ldx #0
    @set_state:
      stx player.1.idleState;
      ;lda timers, x
      sta player.1.idleTimer;
      rts
    timers:
      ;.byte 245, 10, 10, 10


update_sprite_tiles
      lda player.1.motionState;
      cmp Airborne
      beq @airborne_sptite_tiles
      cmp Pivot
      beq @pivot_sprite_tiles
      cmp Walk
      beq @walk_sprite_tiles
    @still:
      lda player.1.idleState;
      asl
      asl
      clc
      adc player.1.heading;
      tax
      ;lda idle_tiles, x
      ;sta $200 + OAM_TILE
      ;lda idle_tiles + 2, x
      ;sta $204 + OAM_TILE
      rts
    @airborne_sptite_tiles:
      ldx player.1.heading;
      ;lda jumping_tiles, x
      ;sta $200 + OAM_TILE
      ;lda jumping_tiles + 2, x
      ;sta $204 + OAM_TILE
      rts
    @walk_sprite_tiles:
      lda player.1.animationFrame;
      asl
      asl
      clc
      adc player.1.heading;
      tax
      ;lda walk_tiles, x
      ;sta $200 + OAM_TILE
      ;lda walk_tiles +2, x
      ;sta $204 + OAM_TILE
      rts
    @pivot_sprite_tiles:
      ldx player.1.heading;
      ;lda pivot_tiles, x
      ;sta $200 + OAM_TILE
      ;lda pivot_tiles + 2, x
      ;sta $204 + OAM_TILE
      rts
    jumping_tiles:
      ;.byte $88, $8A, $8A, $88
    pivot_tiles:
      ;.byte $98, $9A, $9A, $98 ; Pivot is the same no matter the animation frame
    walk_tiles:
      ;.byte $80, $82, $82, $80 ; Frame 1
      ;.byte $84, $86, $86, $84 ; Frame 2
    idle_tiles:
      ;.byte $80, $82, $82, $80
      ;.byte $9C, $9E, $9E, $9C
      ;.byte $80, $82, $82, $80
      ;.byte $9C, $9E, $9E, $9C


update_sprite_position
      ; This is computed in `bound_position` above, so all we have to do is set
      ; the sprite coordinates appropriately.
      lda player.1.spriteX_Hi
      ;sta $200 + OAM_X
      clc
      adc #8
      ;sta $204 + OAM_X
      lda player.1.spriteY_Hi
      sta $200
      sta $204
      rts 
	  
	  
.ENDS