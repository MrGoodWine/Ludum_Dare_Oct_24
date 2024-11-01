;================================================================		
;================================================================	
;================================================================	  
	  
.bank 0 slot 0
.org 0
.section "Player 4 Routine"  
	  
MovementUpdatep4:
	  Rep #$30
	  lda #$0000
	  sep #$20

	  
	  
	   lda player.4.motionState
	  cmp #Bash
	  beq @p4_inBash
	  
	  lda player.4.cooldown
	  cmp #$00
      bne @p4_cooldown
	  
	  
      lda $34 
	  cmp #$80
      beq @p4_bash_state

	 
	  
      jsr p4_set_target_y_velocity
      jsr p4_set_target_x_velocity
	  jsr p4_apply_movement
	  rts
	  
@p4_bash_state:

	  lda #Bash
	  sta player.4.motionState
	  jsr p4_check_bash_direction
	  jsr p4_apply_bash
	  rts

@p4_inBash:

	jsr p4_apply_bash
	rts
	
	
@p4_cooldown
	dea
	sta player.4.cooldown
rts	
	

;================================================================		
;==============Player 1 routine==================================		
;================================================================	
;================================================================	  

p4_check_bash_direction

	  lda player.4.combinedHeading
	  cmp #Angled
	  
      bne @p4check_bash_updown
	  lda #bash_velocity
      sta player.4.targetVelocityY
	  sta player.4.targetVelocityX	
      rts
    @p4check_bash_updown:
	  cmp #UpDown
	  
      bne @p4check_bash_rightleft
	  ldx #bash_velocity
      stx player.4.targetVelocityY
      rts
	@p4check_bash_rightleft:
	  cmp #RightLeft
	  
      bne @p4check_bash_other
	  ldx #bash_velocity
	  stx player.4.targetVelocityX	
rts

@p4check_bash_other	  
rts


	  
p4_set_target_y_velocity
      ; Check if the B button is being pressed and save the state in the X
      ; register

	  Rep #$30
	  lda #$0000
	  sep #$20
	  ldx #01
	  
   
    @p4check_down: 
      lda #BUTTON_DOWN
	  sta CurrentButton
      and $35
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
      and $35
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
    

	 
p4_set_target_x_velocity
      ; Check if the B button is being pressed and save the state in the X
      ; register

	  Rep #$30
	  lda #$0000
	  sep #$20
	  ldx #01
	  
   
    @p4check_right: 
      lda #BUTTON_RIGHT
	  sta CurrentButton
      and $35
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
      and $35
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
    

	
p4_apply_movement
	  
	  
	@p4_right_down_move:
	  lda $35
	  cmp #$05 ;right down
	  bne @p4_right_up_move
	  lda player.4.positionX_Lo
	  adc player.4.targetVelocityX
	  sta player.4.positionX_Lo	 
	  sta player.4.spriteX_Lo
	  lda player.4.positionY_Lo
	  adc player.4.targetVelocityY
	  sta player.4.positionY_Lo	 
	  sta player.4.spriteY_Lo	
	  lda #$A2
	  sta player.4.animationFrame
      lda player.4.priorityPalette	
	  and #$BF
	  ora #$80	  
	  sta player.4.priorityPalette
	  
	  lda player.4.animationTimer
	  ina
	  sta player.4.animationTimer
	  
	  lda #Angled
	  sta player.4.combinedHeading
	  
	  lda #RightDown
	  sta player.4.headingSpecific
	  
	  lda #Walk
	  sta player.4.motionState
	  
	  
	  jmp @p4_set_clear_bytes	
	  
	@p4_right_up_move:
	  cmp #$09 ;right up
	  bne @p4_left_up_move
	  lda player.4.positionX_Lo
	  adc player.4.targetVelocityX
	  sta player.4.positionX_Lo	 
	  sta player.4.spriteX_Lo
	  lda player.4.positionY_Lo
	  sbc player.4.targetVelocityY
	  sbc player.4.targetVelocityY
	  sta player.4.positionY_Lo	 
	  sta player.4.spriteY_Lo
	  lda #$A2
	  sta player.4.animationFrame
	  lda player.4.priorityPalette	
	  and #$3F
	  sta player.4.priorityPalette
	  
	  lda player.4.animationTimer
	  ina
	  sta player.4.animationTimer
	  
	  lda #Angled
	  sta player.4.combinedHeading
	  
	  lda #RightUp
	  sta player.4.headingSpecific
	  
	  lda #Walk
	  sta player.4.motionState
	  
	  jmp @p4_set_clear_bytes	
	  
	@p4_left_up_move:
	  cmp #$0A ;left up
	  bne @p4_left_down_move
	  lda player.4.positionY_Lo
	  sbc player.4.targetVelocityY
	  sbc player.4.targetVelocityY
	  sta player.4.positionY_Lo	 
	  sta player.4.spriteY_Lo
	  lda player.4.positionX_Lo
	  sbc player.4.targetVelocityX
	  sbc player.4.targetVelocityX
	  sta player.4.positionX_Lo	 
	  sta player.4.spriteX_Lo	
	  lda #$A2
	  sta player.4.animationFrame
	  lda player.4.priorityPalette	
	  and #$7F
	  ora #$40	  
	  sta player.4.priorityPalette
	  
	  lda player.4.animationTimer
	  ina
	  sta player.4.animationTimer
	  
	  lda #Angled
	  sta player.4.combinedHeading
	  lda #LeftUp
	  sta player.4.headingSpecific
	  
	  lda #Walk
	  sta player.4.motionState
	  
	  jmp @p4_set_clear_bytes	
	  
	@p4_left_down_move:
	  cmp #$06 ;left down
	  bne @p4_up_move
	  lda player.4.positionX_Lo
	  sbc player.4.targetVelocityX
	  sbc player.4.targetVelocityX
	  sta player.4.positionX_Lo	 
	  sta player.4.spriteX_Lo	
	  lda player.4.positionY_Lo
	  adc player.4.targetVelocityY
	  sta player.4.positionY_Lo	 
	  sta player.4.spriteY_Lo	
	  lda #$A2
	  sta player.4.animationFrame
	  lda player.4.priorityPalette	
	  ora #$C0
	  sta player.4.priorityPalette
	  
	  lda player.4.animationTimer
	  ina
	  sta player.4.animationTimer
	  
	  lda #Angled
	  sta player.4.combinedHeading
	  lda #LeftDown
	  sta player.4.headingSpecific
	  
	  lda #Walk
	  sta player.4.motionState
	  
	  jmp @p4_set_clear_bytes
	  
	@p4_up_move:

	  cmp #$08 ;up
	  bne @p4_left_move  
	  lda player.4.positionY_Lo
	  sbc player.4.targetVelocityY
	  sbc player.4.targetVelocityY
	  sta player.4.positionY_Lo	 
	  sta player.4.spriteY_Lo
	  lda #$96
	  sta player.4.animationFrame
	  lda player.4.priorityPalette
	  and #$3F
	  sta player.4.priorityPalette
	  
	  lda player.4.animationTimer
	  ina
	  sta player.4.animationTimer
	  
	  lda #UpDown
	  sta player.4.combinedHeading
	  
	  lda #Walk
	  sta player.4.motionState
	  lda #Up
	  sta player.4.headingSpecific
	  
	  jmp @p4_set_clear_bytes
	  
	@p4_left_move:
	  cmp #$02 ;left
	  bne @p4_down_move  
	  lda player.4.positionX_Lo
	  sbc player.4.targetVelocityX
	  sbc player.4.targetVelocityX
	  sta player.4.positionX_Lo	 
	  sta player.4.spriteX_Lo
	  lda #$9C
	  sta player.4.animationFrame
	  lda player.4.priorityPalette	
	  and #$7F
	  ora #$40
	  sta player.4.priorityPalette
	  
	  lda player.4.animationTimer
	  ina
	  sta player.4.animationTimer
	  
	  lda #RightLeft
	  sta player.4.combinedHeading
	  lda #Left
	  sta player.4.headingSpecific
	  
	  lda #Walk
	  sta player.4.motionState
	  
	  jmp @p4_set_clear_bytes	  
	  
	@p4_down_move:  
	  cmp #$04 ;down
	  bne @p4_right_move
	  lda player.4.positionY_Lo
	  adc player.4.targetVelocityY
	  sta player.4.positionY_Lo	 
	  sta player.4.spriteY_Lo
	  lda #$96
	  sta player.4.animationFrame
	  lda player.4.priorityPalette	
	  ora #$80
	  and #$BF
	  sta player.4.priorityPalette
	 
	 lda player.4.animationTimer
	  ina
	  sta player.4.animationTimer
	  
	  lda #UpDown
	  sta player.4.combinedHeading
	  lda #Down
	  sta player.4.headingSpecific
	  
	  lda #Walk
	  sta player.4.motionState
	 
	  jmp @p4_set_clear_bytes	
	  
	@p4_right_move:
	  cmp #$01 ;right
	  bne  @p4_set_clear_bytes
	  lda player.4.positionX_Lo
	  adc player.4.targetVelocityX
	  sta player.4.positionX_Lo	 
	  sta player.4.spriteX_Lo
	  lda #$9C
	  sta player.4.animationFrame
	  lda player.4.priorityPalette
	  and #$3F
	  sta player.4.priorityPalette
	  
	  lda #RightLeft
	  sta player.4.combinedHeading
	  lda #Right
	  sta player.4.headingSpecific
	  
	  lda #Walk
	  sta player.4.motionState
	  
	  jmp @p4_set_clear_bytes		  
	  


	@p4_set_clear_bytes:	
	  
	 
	  
rts
	  
	  
p4_apply_bash


	@p4_right_down_bash:
	  lda player.4.headingSpecific 
	  cmp #RightDown ;right down
	  bne @p4_right_up_bash
	  lda player.4.positionX_Lo
	  adc player.4.targetVelocityX
	  sta player.4.positionX_Lo	 
	  sta player.4.spriteX_Lo
	  lda player.4.positionY_Lo
	  adc player.4.targetVelocityY
	  sta player.4.positionY_Lo	 
	  sta player.4.spriteY_Lo	
	  lda #$B6
	  sta player.4.animationFrame
      lda player.4.priorityPalette	
	  and #$BF
	  ora #$80	  
	  sta player.4.priorityPalette
	  
	  lda player.4.animationTimer
	  ina
	  sta player.4.animationTimer
	  
	  lda #Angled
	  sta player.4.combinedHeading
	  
	  lda #Bash
	  sta player.4.motionState
	  
	  
	  
	  jmp @p4_set_clear_bash	
	  
	@p4_right_up_bash:
	  cmp #RightUp ;right up
	  bne @p4_left_up_bash
	  lda player.4.positionX_Lo
	  adc player.4.targetVelocityX
	  sta player.4.positionX_Lo	 
	  sta player.4.spriteX_Lo
	  lda player.4.positionY_Lo
	
	  sbc player.4.targetVelocityY
	  sta player.4.positionY_Lo	 
	  sta player.4.spriteY_Lo
	  lda #$B6
	  sta player.4.animationFrame
	  lda player.4.priorityPalette	
	  and #$3F
	  sta player.4.priorityPalette
	  
	  lda player.4.animationTimer
	  ina
	  sta player.4.animationTimer
	  
	  lda #Angled
	  sta player.4.combinedHeading
	  
	  lda #Bash
	  sta player.4.motionState
	  
	  
	  jmp @p4_set_clear_bash
	  
	@p4_left_up_bash:
	  cmp #LeftUp ;left up
	  bne @p4_left_down_bash
	  lda player.4.positionY_Lo
	 
	  sbc player.4.targetVelocityY
	  sta player.4.positionY_Lo	 
	  sta player.4.spriteY_Lo
	  lda player.4.positionX_Lo
	
	  sbc player.4.targetVelocityX
	  sta player.4.positionX_Lo	 
	  sta player.4.spriteX_Lo	
	  lda #$B6
	  sta player.4.animationFrame
	  lda player.4.priorityPalette	
	  and #$7F
	  ora #$40	  
	  sta player.4.priorityPalette
	  
	  lda player.4.animationTimer
	  ina
	  sta player.4.animationTimer
	  
	  lda #Angled
	  sta player.4.combinedHeading
	  
	  lda #Bash
	  sta player.4.motionState
	  
	  
	  jmp @p4_set_clear_bash	
	  
	@p4_left_down_bash:
	  cmp #LeftDown ;left down
	  bne @p4_up_bash
	  lda player.4.positionX_Lo
	  sbc player.4.targetVelocityX
	 
	  sta player.4.positionX_Lo	 
	  sta player.4.spriteX_Lo	
	  
	  lda player.4.positionY_Lo
	  adc player.4.targetVelocityY
	  sta player.4.positionY_Lo	 
	  sta player.4.spriteY_Lo	
	  lda #$B6
	  sta player.4.animationFrame
	  lda player.4.priorityPalette	
	  ora #$C0
	  sta player.4.priorityPalette
	  
	  lda player.4.animationTimer
	  ina
	  sta player.4.animationTimer
	  
	  lda #Angled
	  sta player.4.combinedHeading
	  
	  lda #Bash
	  sta player.4.motionState
	  
	  
	  jmp @p4_set_clear_bash
	  
	@p4_up_bash:

	  cmp #Up ;up
	  bne @p4_left_bash  
	  lda player.4.positionY_Lo
	
	  sbc player.4.targetVelocityY
	  sta player.4.positionY_Lo	 
	  sta player.4.spriteY_Lo
	  lda #$98
	  sta player.4.animationFrame
	  lda player.4.priorityPalette
	  and #$3F
	  sta player.4.priorityPalette
	  
	  lda player.4.animationTimer
	  ina
	  sta player.4.animationTimer
	  
	  lda #UpDown
	  sta player.4.combinedHeading
	  
	  lda #Bash
	  sta player.4.motionState
	  
	  
	  jmp @p4_set_clear_bash
	  
	@p4_left_bash:
	  cmp #Left ;left
	  bne @p4_down_bash  
	  lda player.4.positionX_Lo
	
	  sbc player.4.targetVelocityX
	  sta player.4.positionX_Lo	 
	  sta player.4.spriteX_Lo
	  lda #$A0
	  sta player.4.animationFrame
	  lda player.4.priorityPalette	
	  and #$7F
	  ora #$40
	  sta player.4.priorityPalette
	  
	  lda player.4.animationTimer
	  ina
	  sta player.4.animationTimer
	  
	  lda #RightLeft
	  sta player.4.combinedHeading
	  
	  lda #Bash
	  sta player.4.motionState
	  
	  
	  
	  jmp @p4_set_clear_bash	  
	  
	@p4_down_bash:  
	  cmp #Down ;down
	  bne @p4_right_bash
	  lda player.4.positionY_Lo
	  adc player.4.targetVelocityY
	  sta player.4.positionY_Lo	 
	  sta player.4.spriteY_Lo
	  lda #$98
	  sta player.4.animationFrame
	  lda player.4.priorityPalette	
	  ora #$80
	  and #$BF
	  sta player.4.priorityPalette
	 
	 lda player.4.animationTimer
	  ina
	  sta player.4.animationTimer
	  
	  lda #UpDown
	  sta player.4.combinedHeading
	  
	  lda #Bash
	  sta player.4.motionState

	 
	  jmp @p4_set_clear_bash	
	  
	  
	  
	@p4_right_bash:
	  cmp #Right ;right
	  bne  @p4_set_clear_bash
	  lda player.4.positionX_Lo
	  adc player.4.targetVelocityX
	  sta player.4.positionX_Lo	 
	  sta player.4.spriteX_Lo
	  lda #$A0
	  sta player.4.animationFrame
	  lda player.4.priorityPalette
	  and #$3F
	  sta player.4.priorityPalette
	  
	  lda #RightLeft
	  sta player.4.combinedHeading
	  
	  lda #Bash
	  sta player.4.motionState
	
	  
	  jmp @p4_set_clear_bash		  
	  


	@p4_set_clear_bash:	
	  ;lda #$0000
	  ;sta player.4.byte21
	  ;sta player.4.byte22
	  ;sta player.4.byte23
	  ;sta player.4.byte24
	  ;sta player.4.byte25
	  ;sta player.4.byte26
	  
	  lda player.4.targetVelocityX
	  cmp #$00
	  bne @p4_bash_end_X
	  
	  
	  lda player.4.targetVelocityY
	  cmp #$00
	  bne @p4_bash_end_Y
	  
	  lda #Still
	  sta player.4.motionState
	  
	  lda #$10
	  sta player.4.cooldown
	  rts
	  
	  
@p4_bash_end_X:
	  
	  dea
	  sta player.4.targetVelocityX
	  
	  lda player.4.targetVelocityY
	  cmp #$00
	  bne @p4_bash_end_Y
	  
	  lda #$10
	  sta player.4.cooldown
	  rts
	  
	  
@p4_bash_end_Y:
	  
	  dea
	  sta player.4.targetVelocityY
	  lda #$10
	  sta player.4.cooldown
rts  
	  
	  
	  
@animUpdate_p4:	
	  lda player.4.animationTimer
	  ina
	  sta player.4.animationTimer
rts	

.ends
