;================================================================		
;================================================================	
;================================================================	  
	  
.bank 0 slot 0
.org 0
.section "Player 1 Routine"  
	  
MovementUpdateP1:
	  Rep #$30
	  lda #$0000
	  sep #$20

	  
	  
	   lda player.1.motionState
	  cmp #Bash
	  beq @P1_inBash
	  
	  lda player.1.cooldown
	  cmp #$00
      bne @P1_cooldown
	  
	  
      lda $2E 
	  cmp #$80
      beq @P1_bash_state

	 
	  
      jsr P1_set_target_y_velocity
      jsr P1_set_target_x_velocity
	  jsr P1_apply_movement
	  rts
	  
@P1_bash_state:

	  lda #Bash
	  sta player.1.motionState
	  jsr P1_check_bash_direction
	  jsr P1_apply_bash
	  rts

@P1_inBash:

	jsr P1_apply_bash
	rts
	
	
@P1_cooldown
	dea
	sta player.1.cooldown
rts	
	

;================================================================		
;==============Player 1 routine==================================		
;================================================================	
;================================================================	  

P1_check_bash_direction

	  lda player.1.combinedHeading
	  cmp #Angled
	  
      bne @p1check_bash_updown
	  lda #bash_velocity
      sta player.1.targetVelocityY
	  sta player.1.targetVelocityX	
      rts
    @p1check_bash_updown:
	  cmp #UpDown
	  
      bne @p1check_bash_rightleft
	  ldx #bash_velocity
      stx player.1.targetVelocityY
      rts
	@p1check_bash_rightleft:
	  cmp #RightLeft
	  
      bne @p1check_bash_other
	  ldx #bash_velocity
	  stx player.1.targetVelocityX	
rts

@p1check_bash_other	  
rts


	  
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
      and $2F
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
      and $2F
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
      and $2F
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
      and $2F
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
    

	
P1_apply_movement
	  
	  
	@p1_right_down_move:
	  lda $2F
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
	  lda #$0C
	  sta player.1.animationFrame
      lda player.1.priorityPalette	
	  and #$BF
	  ora #$80	  
	  sta player.1.priorityPalette
	  
	  lda player.1.animationTimer
	  ina
	  sta player.1.animationTimer
	  
	  lda #Angled
	  sta player.1.combinedHeading
	  
	  lda #RightDown
	  sta player.1.headingSpecific
	  
	  lda #Walk
	  sta player.1.motionState
	  
	  
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
	  lda #$0C
	  sta player.1.animationFrame
	  lda player.1.priorityPalette	
	  and #$3F
	  sta player.1.priorityPalette
	  
	  lda player.1.animationTimer
	  ina
	  sta player.1.animationTimer
	  
	  lda #Angled
	  sta player.1.combinedHeading
	  
	  lda #RightUp
	  sta player.1.headingSpecific
	  
	  lda #Walk
	  sta player.1.motionState
	  
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
	  lda #$0C
	  sta player.1.animationFrame
	  lda player.1.priorityPalette	
	  and #$7F
	  ora #$40	  
	  sta player.1.priorityPalette
	  
	  lda player.1.animationTimer
	  ina
	  sta player.1.animationTimer
	  
	  lda #Angled
	  sta player.1.combinedHeading
	  lda #LeftUp
	  sta player.1.headingSpecific
	  
	  lda #Walk
	  sta player.1.motionState
	  
	  jmp @p1_set_clear_bytes	
	  
	@p1_left_down_move:
	  cmp #$06 ;left down
	  bne @p1_up_move
	  lda player.1.positionX_Lo
	  sbc player.1.targetVelocityX
	  sbc player.1.targetVelocityX
	  sta player.1.positionX_Lo	 
	  sta player.1.spriteX_Lo	
	  lda player.1.positionY_Lo
	  adc player.1.targetVelocityY
	  sta player.1.positionY_Lo	 
	  sta player.1.spriteY_Lo	
	  lda #$0C
	  sta player.1.animationFrame
	  lda player.1.priorityPalette	
	  ora #$C0
	  sta player.1.priorityPalette
	  
	  lda player.1.animationTimer
	  ina
	  sta player.1.animationTimer
	  
	  lda #Angled
	  sta player.1.combinedHeading
	  lda #LeftDown
	  sta player.1.headingSpecific
	  
	  lda #Walk
	  sta player.1.motionState
	  
	  jmp @p1_set_clear_bytes
	  
	@p1_up_move:

	  cmp #$08 ;up
	  bne @p1_left_move  
	  lda player.1.positionY_Lo
	  sbc player.1.targetVelocityY
	  sbc player.1.targetVelocityY
	  sta player.1.positionY_Lo	 
	  sta player.1.spriteY_Lo
	  lda #$00
	  sta player.1.animationFrame
	  lda player.1.priorityPalette
	  and #$3F
	  sta player.1.priorityPalette
	  
	  lda player.1.animationTimer
	  ina
	  sta player.1.animationTimer
	  
	  lda #UpDown
	  sta player.1.combinedHeading
	  
	  lda #Walk
	  sta player.1.motionState
	  lda #Up
	  sta player.1.headingSpecific
	  
	  jmp @p1_set_clear_bytes
	  
	@p1_left_move:
	  cmp #$02 ;left
	  bne @p1_down_move  
	  lda player.1.positionX_Lo
	  sbc player.1.targetVelocityX
	  sbc player.1.targetVelocityX
	  sta player.1.positionX_Lo	 
	  sta player.1.spriteX_Lo
	  lda #$06
	  sta player.1.animationFrame
	  lda player.1.priorityPalette	
	  and #$7F
	  ora #$40
	  sta player.1.priorityPalette
	  
	  lda player.1.animationTimer
	  ina
	  sta player.1.animationTimer
	  
	  lda #RightLeft
	  sta player.1.combinedHeading
	  lda #Left
	  sta player.1.headingSpecific
	  
	  lda #Walk
	  sta player.1.motionState
	  
	  jmp @p1_set_clear_bytes	  
	  
	@p1_down_move:  
	  cmp #$04 ;down
	  bne @p1_right_move
	  lda player.1.positionY_Lo
	  adc player.1.targetVelocityY
	  sta player.1.positionY_Lo	 
	  sta player.1.spriteY_Lo
	  lda #$00
	  sta player.1.animationFrame
	  lda player.1.priorityPalette	
	  ora #$80
	  and #$BF
	  sta player.1.priorityPalette
	 
	 lda player.1.animationTimer
	  ina
	  sta player.1.animationTimer
	  
	  lda #UpDown
	  sta player.1.combinedHeading
	  lda #Down
	  sta player.1.headingSpecific
	  
	  lda #Walk
	  sta player.1.motionState
	 
	  jmp @p1_set_clear_bytes	
	  
	@p1_right_move:
	  cmp #$01 ;right
	  bne  @p1_set_clear_bytes
	  lda player.1.positionX_Lo
	  adc player.1.targetVelocityX
	  sta player.1.positionX_Lo	 
	  sta player.1.spriteX_Lo
	  lda #$06
	  sta player.1.animationFrame
	  lda player.1.priorityPalette
	  and #$3F
	  sta player.1.priorityPalette
	  
	  lda #RightLeft
	  sta player.1.combinedHeading
	  lda #Right
	  sta player.1.headingSpecific
	  
	  lda #Walk
	  sta player.1.motionState
	  
	  jmp @p1_set_clear_bytes		  
	  


	@p1_set_clear_bytes:	
	  lda #$0000
	  sta player.1.byte21
	  sta player.1.byte22
	  sta player.1.byte23
	  sta player.1.byte24
	  sta player.1.byte25
	  sta player.1.byte26
rts
	  
	  
P1_apply_bash


	@p1_right_down_bash:
	  lda player.1.headingSpecific 
	  cmp #RightDown ;right down
	  bne @p1_right_up_bash
	  lda player.1.positionX_Lo
	  adc player.1.targetVelocityX
	  sta player.1.positionX_Lo	 
	  sta player.1.spriteX_Lo
	  lda player.1.positionY_Lo
	  adc player.1.targetVelocityY
	  sta player.1.positionY_Lo	 
	  sta player.1.spriteY_Lo	
	  lda #$0C
	  sta player.1.animationFrame
      lda player.1.priorityPalette	
	  and #$BF
	  ora #$80	  
	  sta player.1.priorityPalette
	  
	  lda player.1.animationTimer
	  ina
	  sta player.1.animationTimer
	  
	  lda #Angled
	  sta player.1.combinedHeading
	  
	  lda #Bash
	  sta player.1.motionState
	  
	  
	  
	  jmp @p1_set_clear_bash	
	  
	@p1_right_up_bash:
	  cmp #RightUp ;right up
	  bne @p1_left_up_bash
	  lda player.1.positionX_Lo
	  adc player.1.targetVelocityX
	  sta player.1.positionX_Lo	 
	  sta player.1.spriteX_Lo
	  lda player.1.positionY_Lo
	
	  sbc player.1.targetVelocityY
	  sta player.1.positionY_Lo	 
	  sta player.1.spriteY_Lo
	  lda #$0C
	  sta player.1.animationFrame
	  lda player.1.priorityPalette	
	  and #$3F
	  sta player.1.priorityPalette
	  
	  lda player.1.animationTimer
	  ina
	  sta player.1.animationTimer
	  
	  lda #Angled
	  sta player.1.combinedHeading
	  
	  lda #Bash
	  sta player.1.motionState
	  
	  
	  jmp @p1_set_clear_bash
	  
	@p1_left_up_bash:
	  cmp #LeftUp ;left up
	  bne @p1_left_down_bash
	  lda player.1.positionY_Lo
	 
	  sbc player.1.targetVelocityY
	  sta player.1.positionY_Lo	 
	  sta player.1.spriteY_Lo
	  lda player.1.positionX_Lo
	
	  sbc player.1.targetVelocityX
	  sta player.1.positionX_Lo	 
	  sta player.1.spriteX_Lo	
	  lda #$0C
	  sta player.1.animationFrame
	  lda player.1.priorityPalette	
	  and #$7F
	  ora #$40	  
	  sta player.1.priorityPalette
	  
	  lda player.1.animationTimer
	  ina
	  sta player.1.animationTimer
	  
	  lda #Angled
	  sta player.1.combinedHeading
	  
	  lda #Bash
	  sta player.1.motionState
	  
	  
	  jmp @p1_set_clear_bash	
	  
	@p1_left_down_bash:
	  cmp #LeftDown ;left down
	  bne @p1_up_bash
	  lda player.1.positionX_Lo
	  sbc player.1.targetVelocityX
	 
	  sta player.1.positionX_Lo	 
	  sta player.1.spriteX_Lo	
	  
	  lda player.1.positionY_Lo
	  adc player.1.targetVelocityY
	  sta player.1.positionY_Lo	 
	  sta player.1.spriteY_Lo	
	  lda #$0C
	  sta player.1.animationFrame
	  lda player.1.priorityPalette	
	  ora #$C0
	  sta player.1.priorityPalette
	  
	  lda player.1.animationTimer
	  ina
	  sta player.1.animationTimer
	  
	  lda #Angled
	  sta player.1.combinedHeading
	  
	  lda #Bash
	  sta player.1.motionState
	  
	  
	  jmp @p1_set_clear_bash
	  
	@p1_up_bash:

	  cmp #Up ;up
	  bne @p1_left_bash  
	  lda player.1.positionY_Lo
	
	  sbc player.1.targetVelocityY
	  sta player.1.positionY_Lo	 
	  sta player.1.spriteY_Lo
	  lda #$00
	  sta player.1.animationFrame
	  lda player.1.priorityPalette
	  and #$3F
	  sta player.1.priorityPalette
	  
	  lda player.1.animationTimer
	  ina
	  sta player.1.animationTimer
	  
	  lda #UpDown
	  sta player.1.combinedHeading
	  
	  lda #Bash
	  sta player.1.motionState
	  
	  
	  jmp @p1_set_clear_bash
	  
	@p1_left_bash:
	  cmp #Left ;left
	  bne @p1_down_bash  
	  lda player.1.positionX_Lo
	
	  sbc player.1.targetVelocityX
	  sta player.1.positionX_Lo	 
	  sta player.1.spriteX_Lo
	  lda #$06
	  sta player.1.animationFrame
	  lda player.1.priorityPalette	
	  and #$7F
	  ora #$40
	  sta player.1.priorityPalette
	  
	  lda player.1.animationTimer
	  ina
	  sta player.1.animationTimer
	  
	  lda #RightLeft
	  sta player.1.combinedHeading
	  
	  lda #Bash
	  sta player.1.motionState
	  
	  
	  
	  jmp @p1_set_clear_bash	  
	  
	@p1_down_bash:  
	  cmp #Down ;down
	  bne @p1_right_bash
	  lda player.1.positionY_Lo
	  adc player.1.targetVelocityY
	  sta player.1.positionY_Lo	 
	  sta player.1.spriteY_Lo
	  lda #$00
	  sta player.1.animationFrame
	  lda player.1.priorityPalette	
	  ora #$80
	  and #$BF
	  sta player.1.priorityPalette
	 
	 lda player.1.animationTimer
	  ina
	  sta player.1.animationTimer
	  
	  lda #UpDown
	  sta player.1.combinedHeading
	  
	  lda #Bash
	  sta player.1.motionState

	 
	  jmp @p1_set_clear_bash	
	  
	  
	  
	@p1_right_bash:
	  cmp #Right ;right
	  bne  @p1_set_clear_bash
	  lda player.1.positionX_Lo
	  adc player.1.targetVelocityX
	  sta player.1.positionX_Lo	 
	  sta player.1.spriteX_Lo
	  lda #$06
	  sta player.1.animationFrame
	  lda player.1.priorityPalette
	  and #$3F
	  sta player.1.priorityPalette
	  
	  lda #RightLeft
	  sta player.1.combinedHeading
	  
	  lda #Bash
	  sta player.1.motionState
	
	  
	  jmp @p1_set_clear_bash		  
	  


	@p1_set_clear_bash:	
	  ;lda #$0000
	  ;sta player.1.byte21
	  ;sta player.1.byte22
	  ;sta player.1.byte23
	  ;sta player.1.byte24
	  ;sta player.1.byte25
	  ;sta player.1.byte26
	  
	  lda player.1.targetVelocityX
	  cmp #$00
	  bne @p1_bash_end_X
	  
	  
	  lda player.1.targetVelocityY
	  cmp #$00
	  bne @p1_bash_end_Y
	  
	  lda #Still
	  sta player.1.motionState
	  
	  lda #$20
	  sta player.1.cooldown
	  rts
	  
	  
@p1_bash_end_X:
	  
	  dea
	  sta player.1.targetVelocityX
	  
	  lda player.1.targetVelocityY
	  cmp #$00
	  bne @p1_bash_end_Y
	  
	  lda #$20
	  sta player.1.cooldown
	  rts
	  
	  
@p1_bash_end_Y:
	  
	  dea
	  sta player.1.targetVelocityY
	  lda #$20
	  sta player.1.cooldown
rts  
	  
	  
	  
@animUpdate_P1:	
	  lda player.1.animationTimer
	  ina
	  sta player.1.animationTimer
rts	

.ends
