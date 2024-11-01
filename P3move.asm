;================================================================		
;================================================================	
;================================================================	  
	  
.bank 0 slot 0
.org 0
.section "Player 3 Routine"  
	  
MovementUpdatep3:
	  Rep #$30
	  lda #$0000
	  sep #$20

	  
	  
	   lda player.3.motionState
	  cmp #Bash
	  beq @p3_inBash
	  
	  lda player.3.cooldown
	  cmp #$00
      bne @p3_cooldown
	  
	  
      lda $32 
	  cmp #$80
      beq @p3_bash_state

	 
	  
      jsr p3_set_target_y_velocity
      jsr p3_set_target_x_velocity
	  jsr p3_apply_movement
	  rts
	  
@p3_bash_state:

	  lda #Bash
	  sta player.3.motionState
	  jsr p3_check_bash_direction
	  jsr p3_apply_bash
	  rts

@p3_inBash:

	jsr p3_apply_bash
	rts
	
	
@p3_cooldown
	dea
	sta player.3.cooldown
rts	
	

;================================================================		
;==============Player 1 routine==================================		
;================================================================	
;================================================================	  

p3_check_bash_direction

	  lda player.3.combinedHeading
	  cmp #Angled
	  
      bne @p3check_bash_updown
	  lda #bash_velocity
      sta player.3.targetVelocityY
	  sta player.3.targetVelocityX	
      rts
    @p3check_bash_updown:
	  cmp #UpDown
	  
      bne @p3check_bash_rightleft
	  ldx #bash_velocity
      stx player.3.targetVelocityY
      rts
	@p3check_bash_rightleft:
	  cmp #RightLeft
	  
      bne @p3check_bash_other
	  ldx #bash_velocity
	  stx player.3.targetVelocityX	
rts

@p3check_bash_other	  
rts


	  
p3_set_target_y_velocity
      ; Check if the B button is being pressed and save the state in the X
      ; register

	  Rep #$30
	  lda #$0000
	  sep #$20
	  ldx #01
	  
   
    @p3check_down: 
      lda #BUTTON_DOWN
	  sta CurrentButton
      and $33
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
      and $33
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
    

	 
p3_set_target_x_velocity
      ; Check if the B button is being pressed and save the state in the X
      ; register

	  Rep #$30
	  lda #$0000
	  sep #$20
	  ldx #01
	  
   
    @p3check_right: 
      lda #BUTTON_RIGHT
	  sta CurrentButton
      and $33
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
      and $33
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
    

	
p3_apply_movement
	  
	  
	@p3_right_down_move:
	  lda $33
	  cmp #$05 ;right down
	  bne @p3_right_up_move
	  lda player.3.positionX_Lo
	  adc player.3.targetVelocityX
	  sta player.3.positionX_Lo	 
	  sta player.3.spriteX_Lo
	  lda player.3.positionY_Lo
	  adc player.3.targetVelocityY
	  sta player.3.positionY_Lo	 
	  sta player.3.spriteY_Lo	
	  lda #$70
	  sta player.3.animationFrame
      lda player.3.priorityPalette	
	  and #$BF
	  ora #$80	  
	  sta player.3.priorityPalette
	  
	  lda player.3.animationTimer
	  ina
	  sta player.3.animationTimer
	  
	  lda #Angled
	  sta player.3.combinedHeading
	  
	  lda #RightDown
	  sta player.3.headingSpecific
	  
	  lda #Walk
	  sta player.3.motionState
	  
	  
	  jmp @p3_set_clear_bytes	
	  
	@p3_right_up_move:
	  cmp #$09 ;right up
	  bne @p3_left_up_move
	  lda player.3.positionX_Lo
	  adc player.3.targetVelocityX
	  sta player.3.positionX_Lo	 
	  sta player.3.spriteX_Lo
	  lda player.3.positionY_Lo
	  sbc player.3.targetVelocityY
	  sbc player.3.targetVelocityY
	  sta player.3.positionY_Lo	 
	  sta player.3.spriteY_Lo
	  lda #$70
	  sta player.3.animationFrame
	  lda player.3.priorityPalette	
	  and #$3F
	  sta player.3.priorityPalette
	  
	  lda player.3.animationTimer
	  ina
	  sta player.3.animationTimer
	  
	  lda #Angled
	  sta player.3.combinedHeading
	  
	  lda #RightUp
	  sta player.3.headingSpecific
	  
	  lda #Walk
	  sta player.3.motionState
	  
	  jmp @p3_set_clear_bytes	
	  
	@p3_left_up_move:
	  cmp #$0A ;left up
	  bne @p3_left_down_move
	  lda player.3.positionY_Lo
	  sbc player.3.targetVelocityY
	  sbc player.3.targetVelocityY
	  sta player.3.positionY_Lo	 
	  sta player.3.spriteY_Lo
	  lda player.3.positionX_Lo
	  sbc player.3.targetVelocityX
	  sbc player.3.targetVelocityX
	  sta player.3.positionX_Lo	 
	  sta player.3.spriteX_Lo	
	  lda #$70
	  sta player.3.animationFrame
	  lda player.3.priorityPalette	
	  and #$7F
	  ora #$40	  
	  sta player.3.priorityPalette
	  
	  lda player.3.animationTimer
	  ina
	  sta player.3.animationTimer
	  
	  lda #Angled
	  sta player.3.combinedHeading
	  lda #LeftUp
	  sta player.3.headingSpecific
	  
	  lda #Walk
	  sta player.3.motionState
	  
	  jmp @p3_set_clear_bytes	
	  
	@p3_left_down_move:
	  cmp #$06 ;left down
	  bne @p3_up_move
	  lda player.3.positionX_Lo
	  sbc player.3.targetVelocityX
	  sbc player.3.targetVelocityX
	  sta player.3.positionX_Lo	 
	  sta player.3.spriteX_Lo	
	  lda player.3.positionY_Lo
	  adc player.3.targetVelocityY
	  sta player.3.positionY_Lo	 
	  sta player.3.spriteY_Lo	
	  lda #$70
	  sta player.3.animationFrame
	  lda player.3.priorityPalette	
	  ora #$C0
	  sta player.3.priorityPalette
	  
	  lda player.3.animationTimer
	  ina
	  sta player.3.animationTimer
	  
	  lda #Angled
	  sta player.3.combinedHeading
	  lda #LeftDown
	  sta player.3.headingSpecific
	  
	  lda #Walk
	  sta player.3.motionState
	  
	  jmp @p3_set_clear_bytes
	  
	@p3_up_move:

	  cmp #$08 ;up
	  bne @p3_left_move  
	  lda player.3.positionY_Lo
	  sbc player.3.targetVelocityY
	  sbc player.3.targetVelocityY
	  sta player.3.positionY_Lo	 
	  sta player.3.spriteY_Lo
	  lda #$64
	  sta player.3.animationFrame
	  lda player.3.priorityPalette
	  and #$3F
	  sta player.3.priorityPalette
	  
	  lda player.3.animationTimer
	  ina
	  sta player.3.animationTimer
	  
	  lda #UpDown
	  sta player.3.combinedHeading
	  
	  lda #Walk
	  sta player.3.motionState
	  lda #Up
	  sta player.3.headingSpecific
	  
	  jmp @p3_set_clear_bytes
	  
	@p3_left_move:
	  cmp #$02 ;left
	  bne @p3_down_move  
	  lda player.3.positionX_Lo
	  sbc player.3.targetVelocityX
	  sbc player.3.targetVelocityX
	  sta player.3.positionX_Lo	 
	  sta player.3.spriteX_Lo
	  lda #$6A
	  sta player.3.animationFrame
	  lda player.3.priorityPalette	
	  and #$7F
	  ora #$40
	  sta player.3.priorityPalette
	  
	  lda player.3.animationTimer
	  ina
	  sta player.3.animationTimer
	  
	  lda #RightLeft
	  sta player.3.combinedHeading
	  lda #Left
	  sta player.3.headingSpecific
	  
	  lda #Walk
	  sta player.3.motionState
	  
	  jmp @p3_set_clear_bytes	  
	  
	@p3_down_move:  
	  cmp #$04 ;down
	  bne @p3_right_move
	  lda player.3.positionY_Lo
	  adc player.3.targetVelocityY
	  sta player.3.positionY_Lo	 
	  sta player.3.spriteY_Lo
	  lda #$64
	  sta player.3.animationFrame
	  lda player.3.priorityPalette	
	  ora #$80
	  and #$BF
	  sta player.3.priorityPalette
	 
	 lda player.3.animationTimer
	  ina
	  sta player.3.animationTimer
	  
	  lda #UpDown
	  sta player.3.combinedHeading
	  lda #Down
	  sta player.3.headingSpecific
	  
	  lda #Walk
	  sta player.3.motionState
	 
	  jmp @p3_set_clear_bytes	
	  
	@p3_right_move:
	  cmp #$01 ;right
	  bne  @p3_set_clear_bytes
	  lda player.3.positionX_Lo
	  adc player.3.targetVelocityX
	  sta player.3.positionX_Lo	 
	  sta player.3.spriteX_Lo
	  lda #$6A
	  sta player.3.animationFrame
	  lda player.3.priorityPalette
	  and #$3F
	  sta player.3.priorityPalette
	  
	  lda #RightLeft
	  sta player.3.combinedHeading
	  lda #Right
	  sta player.3.headingSpecific
	  
	  lda #Walk
	  sta player.3.motionState
	  
	  jmp @p3_set_clear_bytes		  
	  


	@p3_set_clear_bytes:	
	  
	 
	  
rts
	  
	  
p3_apply_bash


	@p3_right_down_bash:
	  lda player.3.headingSpecific 
	  cmp #RightDown ;right down
	  bne @p3_right_up_bash
	  lda player.3.positionX_Lo
	  adc player.3.targetVelocityX
	  sta player.3.positionX_Lo	 
	  sta player.3.spriteX_Lo
	  lda player.3.positionY_Lo
	  adc player.3.targetVelocityY
	  sta player.3.positionY_Lo	 
	  sta player.3.spriteY_Lo	
	  lda #$84
	  sta player.3.animationFrame
      lda player.3.priorityPalette	
	  and #$BF
	  ora #$80	  
	  sta player.3.priorityPalette
	  
	  lda player.3.animationTimer
	  ina
	  sta player.3.animationTimer
	  
	  lda #Angled
	  sta player.3.combinedHeading
	  
	  lda #Bash
	  sta player.3.motionState
	  
	  
	  
	  jmp @p3_set_clear_bash	
	  
	@p3_right_up_bash:
	  cmp #RightUp ;right up
	  bne @p3_left_up_bash
	  lda player.3.positionX_Lo
	  adc player.3.targetVelocityX
	  sta player.3.positionX_Lo	 
	  sta player.3.spriteX_Lo
	  lda player.3.positionY_Lo
	
	  sbc player.3.targetVelocityY
	  sta player.3.positionY_Lo	 
	  sta player.3.spriteY_Lo
	  lda #$84
	  sta player.3.animationFrame
	  lda player.3.priorityPalette	
	  and #$3F
	  sta player.3.priorityPalette
	  
	  lda player.3.animationTimer
	  ina
	  sta player.3.animationTimer
	  
	  lda #Angled
	  sta player.3.combinedHeading
	  
	  lda #Bash
	  sta player.3.motionState
	  
	  
	  jmp @p3_set_clear_bash
	  
	@p3_left_up_bash:
	  cmp #LeftUp ;left up
	  bne @p3_left_down_bash
	  lda player.3.positionY_Lo
	 
	  sbc player.3.targetVelocityY
	  sta player.3.positionY_Lo	 
	  sta player.3.spriteY_Lo
	  lda player.3.positionX_Lo
	
	  sbc player.3.targetVelocityX
	  sta player.3.positionX_Lo	 
	  sta player.3.spriteX_Lo	
	  lda #$84
	  sta player.3.animationFrame
	  lda player.3.priorityPalette	
	  and #$7F
	  ora #$40	  
	  sta player.3.priorityPalette
	  
	  lda player.3.animationTimer
	  ina
	  sta player.3.animationTimer
	  
	  lda #Angled
	  sta player.3.combinedHeading
	  
	  lda #Bash
	  sta player.3.motionState
	  
	  
	  jmp @p3_set_clear_bash	
	  
	@p3_left_down_bash:
	  cmp #LeftDown ;left down
	  bne @p3_up_bash
	  lda player.3.positionX_Lo
	  sbc player.3.targetVelocityX
	 
	  sta player.3.positionX_Lo	 
	  sta player.3.spriteX_Lo	
	  
	  lda player.3.positionY_Lo
	  adc player.3.targetVelocityY
	  sta player.3.positionY_Lo	 
	  sta player.3.spriteY_Lo	
	  lda #$84
	  sta player.3.animationFrame
	  lda player.3.priorityPalette	
	  ora #$C0
	  sta player.3.priorityPalette
	  
	  lda player.3.animationTimer
	  ina
	  sta player.3.animationTimer
	  
	  lda #Angled
	  sta player.3.combinedHeading
	  
	  lda #Bash
	  sta player.3.motionState
	  
	  
	  jmp @p3_set_clear_bash
	  
	@p3_up_bash:

	  cmp #Up ;up
	  bne @p3_left_bash  
	  lda player.3.positionY_Lo
	
	  sbc player.3.targetVelocityY
	  sta player.3.positionY_Lo	 
	  sta player.3.spriteY_Lo
	  lda #$68
	  sta player.3.animationFrame
	  lda player.3.priorityPalette
	  and #$3F
	  sta player.3.priorityPalette
	  
	  lda player.3.animationTimer
	  ina
	  sta player.3.animationTimer
	  
	  lda #UpDown
	  sta player.3.combinedHeading
	  
	  lda #Bash
	  sta player.3.motionState
	  
	  
	  jmp @p3_set_clear_bash
	  
	@p3_left_bash:
	  cmp #Left ;left
	  bne @p3_down_bash  
	  lda player.3.positionX_Lo
	
	  sbc player.3.targetVelocityX
	  sta player.3.positionX_Lo	 
	  sta player.3.spriteX_Lo
	  lda #$6E
	  sta player.3.animationFrame
	  lda player.3.priorityPalette	
	  and #$7F
	  ora #$40
	  sta player.3.priorityPalette
	  
	  lda player.3.animationTimer
	  ina
	  sta player.3.animationTimer
	  
	  lda #RightLeft
	  sta player.3.combinedHeading
	  
	  lda #Bash
	  sta player.3.motionState
	  
	  
	  
	  jmp @p3_set_clear_bash	  
	  
	@p3_down_bash:  
	  cmp #Down ;down
	  bne @p3_right_bash
	  lda player.3.positionY_Lo
	  adc player.3.targetVelocityY
	  sta player.3.positionY_Lo	 
	  sta player.3.spriteY_Lo
	  lda #$68
	  sta player.3.animationFrame
	  lda player.3.priorityPalette	
	  ora #$80
	  and #$BF
	  sta player.3.priorityPalette
	 
	 lda player.3.animationTimer
	  ina
	  sta player.3.animationTimer
	  
	  lda #UpDown
	  sta player.3.combinedHeading
	  
	  lda #Bash
	  sta player.3.motionState

	 
	  jmp @p3_set_clear_bash	
	  
	  
	  
	@p3_right_bash:
	  cmp #Right ;right
	  bne  @p3_set_clear_bash
	  lda player.3.positionX_Lo
	  adc player.3.targetVelocityX
	  sta player.3.positionX_Lo	 
	  sta player.3.spriteX_Lo
	  lda #$6E
	  sta player.3.animationFrame
	  lda player.3.priorityPalette
	  and #$3F
	  sta player.3.priorityPalette
	  
	  lda #RightLeft
	  sta player.3.combinedHeading
	  
	  lda #Bash
	  sta player.3.motionState
	
	  
	  jmp @p3_set_clear_bash		  
	  


	@p3_set_clear_bash:	
	  ;lda #$0000
	  ;sta player.3.byte21
	  ;sta player.3.byte22
	  ;sta player.3.byte23
	  ;sta player.3.byte24
	  ;sta player.3.byte25
	  ;sta player.3.byte26
	  
	  lda player.3.targetVelocityX
	  cmp #$00
	  bne @p3_bash_end_X
	  
	  
	  lda player.3.targetVelocityY
	  cmp #$00
	  bne @p3_bash_end_Y
	  
	  lda #Still
	  sta player.3.motionState
	  
	  lda #$10
	  sta player.3.cooldown
	  rts
	  
	  
@p3_bash_end_X:
	  
	  dea
	  sta player.3.targetVelocityX
	  
	  lda player.3.targetVelocityY
	  cmp #$00
	  bne @p3_bash_end_Y
	  
	  lda #$10
	  sta player.3.cooldown
	  rts
	  
	  
@p3_bash_end_Y:
	  
	  dea
	  sta player.3.targetVelocityY
	  lda #$10
	  sta player.3.cooldown
rts  
	  
	  
	  
@animUpdate_p3:	
	  lda player.3.animationTimer
	  ina
	  sta player.3.animationTimer
rts	

.ends
