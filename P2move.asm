;================================================================		
;================================================================	
;================================================================	  
	  
.bank 0 slot 0
.org 0
.section "Player 2 Routine"  
	  
MovementUpdatep2:
	  Rep #$30
	  lda #$0000
	  sep #$20

	  
	  
	   lda player.2.motionState
	  cmp #Bash
	  beq @p2_inBash
	  
	  lda player.2.cooldown
	  cmp #$00
      bne @p2_cooldown
	  
	  
      lda $30 
	  cmp #$80
      beq @p2_bash_state

	 
	  
      jsr p2_set_target_y_velocity
      jsr p2_set_target_x_velocity
	  jsr p2_apply_movement
	  rts
	  
@p2_bash_state:

	  lda #Bash
	  sta player.2.motionState
	  jsr p2_check_bash_direction
	  jsr p2_apply_bash
	  rts

@p2_inBash:

	jsr p2_apply_bash
	rts
	
	
@p2_cooldown
	dea
	sta player.2.cooldown
rts	
	

;================================================================		
;==============Player 1 routine==================================		
;================================================================	
;================================================================	  

p2_check_bash_direction

	  lda player.2.combinedHeading
	  cmp #Angled
	  
      bne @p2check_bash_updown
	  lda #bash_velocity
      sta player.2.targetVelocityY
	  sta player.2.targetVelocityX	
      rts
    @p2check_bash_updown:
	  cmp #UpDown
	  
      bne @p2check_bash_rightleft
	  ldx #bash_velocity
      stx player.2.targetVelocityY
      rts
	@p2check_bash_rightleft:
	  cmp #RightLeft
	  
      bne @p2check_bash_other
	  ldx #bash_velocity
	  stx player.2.targetVelocityX	
rts

@p2check_bash_other	  
rts


	  
p2_set_target_y_velocity
      ; Check if the B button is being pressed and save the state in the X
      ; register

	  Rep #$30
	  lda #$0000
	  sep #$20
	  ldx #01
	  
   
    @p2check_down: 
      lda #BUTTON_DOWN
	  sta CurrentButton
      and $31
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
      and $31
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
    

	 
p2_set_target_x_velocity
      ; Check if the B button is being pressed and save the state in the X
      ; register

	  Rep #$30
	  lda #$0000
	  sep #$20
	  ldx #01
	  
   
    @p2check_right: 
      lda #BUTTON_RIGHT
	  sta CurrentButton
      and $31
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
      and $31
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
    

	
p2_apply_movement
	  
	  
	@p2_right_down_move:
	  lda $31
	  cmp #$05 ;right down
	  bne @p2_right_up_move
	  lda player.2.positionX_Lo
	  adc player.2.targetVelocityX
	  sta player.2.positionX_Lo	 
	  sta player.2.spriteX_Lo
	  lda player.2.positionY_Lo
	  adc player.2.targetVelocityY
	  sta player.2.positionY_Lo	 
	  sta player.2.spriteY_Lo	
	  lda #$3E
	  sta player.2.animationFrame
      lda player.2.priorityPalette	
	  and #$BF
	  ora #$80	  
	  sta player.2.priorityPalette
	  
	  lda player.2.animationTimer
	  ina
	  sta player.2.animationTimer
	  
	  lda #Angled
	  sta player.2.combinedHeading
	  
	  lda #RightDown
	  sta player.2.headingSpecific
	  
	  lda #Walk
	  sta player.2.motionState
	  
	  
	  jmp @p2_set_clear_bytes	
	  
	@p2_right_up_move:
	  cmp #$09 ;right up
	  bne @p2_left_up_move
	  lda player.2.positionX_Lo
	  adc player.2.targetVelocityX
	  sta player.2.positionX_Lo	 
	  sta player.2.spriteX_Lo
	  lda player.2.positionY_Lo
	  sbc player.2.targetVelocityY
	  sbc player.2.targetVelocityY
	  sta player.2.positionY_Lo	 
	  sta player.2.spriteY_Lo
	  lda #$3E
	  sta player.2.animationFrame
	  lda player.2.priorityPalette	
	  and #$3F
	  sta player.2.priorityPalette
	  
	  lda player.2.animationTimer
	  ina
	  sta player.2.animationTimer
	  
	  lda #Angled
	  sta player.2.combinedHeading
	  
	  lda #RightUp
	  sta player.2.headingSpecific
	  
	  lda #Walk
	  sta player.2.motionState
	  
	  jmp @p2_set_clear_bytes	
	  
	@p2_left_up_move:
	  cmp #$0A ;left up
	  bne @p2_left_down_move
	  lda player.2.positionY_Lo
	  sbc player.2.targetVelocityY
	  sbc player.2.targetVelocityY
	  sta player.2.positionY_Lo	 
	  sta player.2.spriteY_Lo
	  lda player.2.positionX_Lo
	  sbc player.2.targetVelocityX
	  sbc player.2.targetVelocityX
	  sta player.2.positionX_Lo	 
	  sta player.2.spriteX_Lo	
	  lda #$3E
	  sta player.2.animationFrame
	  lda player.2.priorityPalette	
	  and #$7F
	  ora #$40	  
	  sta player.2.priorityPalette
	  
	  lda player.2.animationTimer
	  ina
	  sta player.2.animationTimer
	  
	  lda #Angled
	  sta player.2.combinedHeading
	  lda #LeftUp
	  sta player.2.headingSpecific
	  
	  lda #Walk
	  sta player.2.motionState
	  
	  jmp @p2_set_clear_bytes	
	  
	@p2_left_down_move:
	  cmp #$06 ;left down
	  bne @p2_up_move
	  lda player.2.positionX_Lo
	  sbc player.2.targetVelocityX
	  sbc player.2.targetVelocityX
	  sta player.2.positionX_Lo	 
	  sta player.2.spriteX_Lo	
	  lda player.2.positionY_Lo
	  adc player.2.targetVelocityY
	  sta player.2.positionY_Lo	 
	  sta player.2.spriteY_Lo	
	  lda #$3E
	  sta player.2.animationFrame
	  lda player.2.priorityPalette	
	  ora #$C0
	  sta player.2.priorityPalette
	  
	  lda player.2.animationTimer
	  ina
	  sta player.2.animationTimer
	  
	  lda #Angled
	  sta player.2.combinedHeading
	  lda #LeftDown
	  sta player.2.headingSpecific
	  
	  lda #Walk
	  sta player.2.motionState
	  
	  jmp @p2_set_clear_bytes
	  
	@p2_up_move:

	  cmp #$08 ;up
	  bne @p2_left_move  
	  lda player.2.positionY_Lo
	  sbc player.2.targetVelocityY
	  sbc player.2.targetVelocityY
	  sta player.2.positionY_Lo	 
	  sta player.2.spriteY_Lo
	  lda #$32
	  sta player.2.animationFrame
	  lda player.2.priorityPalette
	  and #$3F
	  sta player.2.priorityPalette
	  
	  lda player.2.animationTimer
	  ina
	  sta player.2.animationTimer
	  
	  lda #UpDown
	  sta player.2.combinedHeading
	  
	  lda #Walk
	  sta player.2.motionState
	  lda #Up
	  sta player.2.headingSpecific
	  
	  jmp @p2_set_clear_bytes
	  
	@p2_left_move:
	  cmp #$02 ;left
	  bne @p2_down_move  
	  lda player.2.positionX_Lo
	  sbc player.2.targetVelocityX
	  sbc player.2.targetVelocityX
	  sta player.2.positionX_Lo	 
	  sta player.2.spriteX_Lo
	  lda #$38
	  sta player.2.animationFrame
	  lda player.2.priorityPalette	
	  and #$7F
	  ora #$40
	  sta player.2.priorityPalette
	  
	  lda player.2.animationTimer
	  ina
	  sta player.2.animationTimer
	  
	  lda #RightLeft
	  sta player.2.combinedHeading
	  lda #Left
	  sta player.2.headingSpecific
	  
	  lda #Walk
	  sta player.2.motionState
	  
	  jmp @p2_set_clear_bytes	  
	  
	@p2_down_move:  
	  cmp #$04 ;down
	  bne @p2_right_move
	  lda player.2.positionY_Lo
	  adc player.2.targetVelocityY
	  sta player.2.positionY_Lo	 
	  sta player.2.spriteY_Lo
	  lda #$32
	  sta player.2.animationFrame
	  lda player.2.priorityPalette	
	  ora #$80
	  and #$BF
	  sta player.2.priorityPalette
	 
	 lda player.2.animationTimer
	  ina
	  sta player.2.animationTimer
	  
	  lda #UpDown
	  sta player.2.combinedHeading
	  lda #Down
	  sta player.2.headingSpecific
	  
	  lda #Walk
	  sta player.2.motionState
	 
	  jmp @p2_set_clear_bytes	
	  
	@p2_right_move:
	  cmp #$01 ;right
	  bne  @p2_set_clear_bytes
	  lda player.2.positionX_Lo
	  adc player.2.targetVelocityX
	  sta player.2.positionX_Lo	 
	  sta player.2.spriteX_Lo
	  lda #$38
	  sta player.2.animationFrame
	  lda player.2.priorityPalette
	  and #$3F
	  sta player.2.priorityPalette
	  
	  lda #RightLeft
	  sta player.2.combinedHeading
	  lda #Right
	  sta player.2.headingSpecific
	  
	  lda #Walk
	  sta player.2.motionState
	  
	  jmp @p2_set_clear_bytes		  
	  


	@p2_set_clear_bytes:	
	 
	 
	 
rts
	  
	  
p2_apply_bash


	@p2_right_down_bash:
	  lda player.2.headingSpecific 
	  cmp #RightDown ;right down
	  bne @p2_right_up_bash
	  lda player.2.positionX_Lo
	  adc player.2.targetVelocityX
	  sta player.2.positionX_Lo	 
	  sta player.2.spriteX_Lo
	  lda player.2.positionY_Lo
	  adc player.2.targetVelocityY
	  sta player.2.positionY_Lo	 
	  sta player.2.spriteY_Lo	
	  lda #$52
	  sta player.2.animationFrame
      lda player.2.priorityPalette	
	  and #$BF
	  ora #$80	  
	  sta player.2.priorityPalette
	  
	  lda player.2.animationTimer
	  ina
	  sta player.2.animationTimer
	  
	  lda #Angled
	  sta player.2.combinedHeading
	  
	  lda #Bash
	  sta player.2.motionState
	  
	  
	  
	  jmp @p2_set_clear_bash	
	  
	@p2_right_up_bash:
	  cmp #RightUp ;right up
	  bne @p2_left_up_bash
	  lda player.2.positionX_Lo
	  adc player.2.targetVelocityX
	  sta player.2.positionX_Lo	 
	  sta player.2.spriteX_Lo
	  lda player.2.positionY_Lo
	
	  sbc player.2.targetVelocityY
	  sta player.2.positionY_Lo	 
	  sta player.2.spriteY_Lo
	  lda #$52
	  sta player.2.animationFrame
	  lda player.2.priorityPalette	
	  and #$3F
	  sta player.2.priorityPalette
	  
	  lda player.2.animationTimer
	  ina
	  sta player.2.animationTimer
	  
	  lda #Angled
	  sta player.2.combinedHeading
	  
	  lda #Bash
	  sta player.2.motionState
	  
	  
	  jmp @p2_set_clear_bash
	  
	@p2_left_up_bash:
	  cmp #LeftUp ;left up
	  bne @p2_left_down_bash
	  lda player.2.positionY_Lo
	 
	  sbc player.2.targetVelocityY
	  sta player.2.positionY_Lo	 
	  sta player.2.spriteY_Lo
	  lda player.2.positionX_Lo
	
	  sbc player.2.targetVelocityX
	  sta player.2.positionX_Lo	 
	  sta player.2.spriteX_Lo	
	  lda #$52
	  sta player.2.animationFrame
	  lda player.2.priorityPalette	
	  and #$7F
	  ora #$40	  
	  sta player.2.priorityPalette
	  
	  lda player.2.animationTimer
	  ina
	  sta player.2.animationTimer
	  
	  lda #Angled
	  sta player.2.combinedHeading
	  
	  lda #Bash
	  sta player.2.motionState
	  
	  
	  jmp @p2_set_clear_bash	
	  
	@p2_left_down_bash:
	  cmp #LeftDown ;left down
	  bne @p2_up_bash
	  lda player.2.positionX_Lo
	  sbc player.2.targetVelocityX
	 
	  sta player.2.positionX_Lo	 
	  sta player.2.spriteX_Lo	
	  
	  lda player.2.positionY_Lo
	  adc player.2.targetVelocityY
	  sta player.2.positionY_Lo	 
	  sta player.2.spriteY_Lo	
	  lda #$52
	  sta player.2.animationFrame
	  lda player.2.priorityPalette	
	  ora #$C0
	  sta player.2.priorityPalette
	  
	  lda player.2.animationTimer
	  ina
	  sta player.2.animationTimer
	  
	  lda #Angled
	  sta player.2.combinedHeading
	  
	  lda #Bash
	  sta player.2.motionState
	  
	  
	  jmp @p2_set_clear_bash
	  
	@p2_up_bash:

	  cmp #Up ;up
	  bne @p2_left_bash  
	  lda player.2.positionY_Lo
	
	  sbc player.2.targetVelocityY
	  sta player.2.positionY_Lo	 
	  sta player.2.spriteY_Lo
	  lda #$36
	  sta player.2.animationFrame
	  lda player.2.priorityPalette
	  and #$3F
	  sta player.2.priorityPalette
	  
	  lda player.2.animationTimer
	  ina
	  sta player.2.animationTimer
	  
	  lda #UpDown
	  sta player.2.combinedHeading
	  
	  lda #Bash
	  sta player.2.motionState
	  
	  
	  jmp @p2_set_clear_bash
	  
	@p2_left_bash:
	  cmp #Left ;left
	  bne @p2_down_bash  
	  lda player.2.positionX_Lo
	
	  sbc player.2.targetVelocityX
	  sta player.2.positionX_Lo	 
	  sta player.2.spriteX_Lo
	  lda #$3C
	  sta player.2.animationFrame
	  lda player.2.priorityPalette	
	  and #$7F
	  ora #$40
	  sta player.2.priorityPalette
	  
	  lda player.2.animationTimer
	  ina
	  sta player.2.animationTimer
	  
	  lda #RightLeft
	  sta player.2.combinedHeading
	  
	  lda #Bash
	  sta player.2.motionState
	  
	  
	  
	  jmp @p2_set_clear_bash	  
	  
	@p2_down_bash:  
	  cmp #Down ;down
	  bne @p2_right_bash
	  lda player.2.positionY_Lo
	  adc player.2.targetVelocityY
	  sta player.2.positionY_Lo	 
	  sta player.2.spriteY_Lo
	  lda #$36
	  sta player.2.animationFrame
	  lda player.2.priorityPalette	
	  ora #$80
	  and #$BF
	  sta player.2.priorityPalette
	 
	 lda player.2.animationTimer
	  ina
	  sta player.2.animationTimer
	  
	  lda #UpDown
	  sta player.2.combinedHeading
	  
	  lda #Bash
	  sta player.2.motionState

	 
	  jmp @p2_set_clear_bash	
	  
	  
	  
	@p2_right_bash:
	  cmp #Right ;right
	  bne  @p2_set_clear_bash
	  lda player.2.positionX_Lo
	  adc player.2.targetVelocityX
	  sta player.2.positionX_Lo	 
	  sta player.2.spriteX_Lo
	  lda #$3C
	  sta player.2.animationFrame
	  lda player.2.priorityPalette
	  and #$3F
	  sta player.2.priorityPalette
	  
	  lda #RightLeft
	  sta player.2.combinedHeading
	  
	  lda #Bash
	  sta player.2.motionState
	
	  
	  jmp @p2_set_clear_bash		  
	  


	@p2_set_clear_bash:	
	  ;lda #$0000
	  ;sta player.2.byte21
	  ;sta player.2.byte22
	  ;sta player.2.byte23
	  ;sta player.2.byte24
	  ;sta player.2.byte25
	  ;sta player.2.byte26
	  
	  lda player.2.targetVelocityX
	  cmp #$00
	  bne @p2_bash_end_X
	  
	  
	  lda player.2.targetVelocityY
	  cmp #$00
	  bne @p2_bash_end_Y
	  
	  lda #Still
	  sta player.2.motionState
	  
	  lda #$20
	  sta player.2.cooldown
	  rts
	  
	  
@p2_bash_end_X:
	  
	  dea
	  sta player.2.targetVelocityX
	  
	  lda player.2.targetVelocityY
	  cmp #$00
	  bne @p2_bash_end_Y
	  
	  lda #$20
	  sta player.2.cooldown
	  rts
	  
	  
@p2_bash_end_Y:
	  
	  dea
	  sta player.2.targetVelocityY
	  lda #$20
	  sta player.2.cooldown
rts  
	  
	  
	  
@animUpdate_p2:	
	  lda player.2.animationTimer
	  ina
	  sta player.2.animationTimer
rts	

.ends
