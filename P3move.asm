;================================================================		
;================================================================	
;================================================================	  
	  
.bank 0 slot 0
.org 0
.section "Player 3 Routine"  
	  
MovementUpdateP3:
      jsr p3_set_target_y_velocity
      jsr p3_set_target_x_velocity
	  
@p3_up_move:
	  lda $2F
	  cmp #$08 ;up
	  bne @p3_left_move  
	  lda player.3.positionY_Lo
	  sbc player.3.targetVelocityY
	  sbc player.3.targetVelocityY
	  sta player.3.positionY_Lo	 
	  sta player.3.spriteY_Lo
	  jmp @p3_set_clear_bytes
	  
@p3_left_move:
	  cmp #$02 ;left
	  bne @p3_down_move  
	  lda player.3.positionX_Lo
	  sbc player.3.targetVelocityX
	  sbc player.3.targetVelocityX
	  sta player.3.positionX_Lo	 
	  sta player.3.spriteX_Lo
	  jmp @p3_set_clear_bytes	  
	  
@p3_down_move:  
	  cmp #$04 ;down
	  bne @p3_right_move
	  lda player.3.positionY_Lo
	  adc player.3.targetVelocityY
	  sta player.3.positionY_Lo	 
	  sta player.3.spriteY_Lo
	  jmp @p3_set_clear_bytes	
	  
@p3_right_move:
	  cmp #$01 ;right
	  bne  @p3_right_down_move
	  lda player.3.positionX_Lo
	  adc player.3.targetVelocityX
	  sta player.3.positionX_Lo	 
	  sta player.3.spriteX_Lo
jmp @p3_set_clear_bytes		  
	  
@p3_right_down_move:
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
	  jmp @p3_set_clear_bytes	
	  
@p3_left_down_move:
	  cmp #$06 ;left down
	  bne @p3_set_clear_bytes
	  lda player.3.positionX_Lo
	  sbc player.3.targetVelocityX
	  sbc player.3.targetVelocityX
	  sta player.3.positionX_Lo	 
	  sta player.3.spriteX_Lo	
	  lda player.3.positionY_Lo
	  adc player.3.targetVelocityY
	  sta player.3.positionY_Lo	 
	  sta player.3.spriteY_Lo	

@p3_set_clear_bytes:	
	  lda #$0000
	  sta player.3.byte21
	  sta player.3.byte22
	  sta player.3.byte23
	  sta player.3.byte24
	  sta player.3.byte25
	  sta player.3.byte26
	  rts	

	
	

;================================================================		
;==============Player 1 routine==================================		
;================================================================	
;================================================================	  
	  
p3_set_target_y_velocity
      ; Check if the B button is being pressed and save the state in the X
      ; register

	  Rep #$30
	  lda #$0000
	  sep #$20
	  
	  
   
    @p3check_down: 
	  ldx #02
      lda #BUTTON_DOWN
	  sta CurrentButton
      and SJoy2, X
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
	  ldx #02
      lda #BUTTON_UP
	  sta CurrentButton
      and SJoy2, X 
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
	  
	  
   
    @p3check_right: 
	  ldx #02
      lda #BUTTON_RIGHT
	  sta CurrentButton
      and SJoy2, X
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
	  ldx #02
      lda #BUTTON_LEFT
	  sta CurrentButton
      and SJoy2, X 
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
    


.ends