;================================================================		
;================================================================	
;================================================================	  
	  
.bank 0 slot 0
.org 0
.section "Player 2 Routine"  
	  
MovementUpdateP2:
      jsr p2_set_target_y_velocity
      jsr p2_set_target_x_velocity
	  
@p2_up_move:
	  lda $2F
	  cmp #$08 ;up
	  bne @p2_left_move  
	  lda player.2.positionY_Lo
	  sbc player.2.targetVelocityY
	  sbc player.2.targetVelocityY
	  sta player.2.positionY_Lo	 
	  sta player.2.spriteY_Lo
	  jmp @p2_set_clear_bytes
	  
@p2_left_move:
	  cmp #$02 ;left
	  bne @p2_down_move  
	  lda player.2.positionX_Lo
	  sbc player.2.targetVelocityX
	  sbc player.2.targetVelocityX
	  sta player.2.positionX_Lo	 
	  sta player.2.spriteX_Lo
	  jmp @p2_set_clear_bytes	  
	  
@p2_down_move:  
	  cmp #$04 ;down
	  bne @p2_right_move
	  lda player.2.positionY_Lo
	  adc player.2.targetVelocityY
	  sta player.2.positionY_Lo	 
	  sta player.2.spriteY_Lo
	  jmp @p2_set_clear_bytes	
	  
@p2_right_move:
	  cmp #$01 ;right
	  bne  @p2_right_down_move
	  lda player.2.positionX_Lo
	  adc player.2.targetVelocityX
	  sta player.2.positionX_Lo	 
	  sta player.2.spriteX_Lo
jmp @p2_set_clear_bytes		  
	  
@p2_right_down_move:
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
	  jmp @p2_set_clear_bytes	
	  
@p2_left_down_move:
	  cmp #$06 ;left down
	  bne @p2_set_clear_bytes
	  lda player.2.positionX_Lo
	  sbc player.2.targetVelocityX
	  sbc player.2.targetVelocityX
	  sta player.2.positionX_Lo	 
	  sta player.2.spriteX_Lo	
	  lda player.2.positionY_Lo
	  adc player.2.targetVelocityY
	  sta player.2.positionY_Lo	 
	  sta player.2.spriteY_Lo	

@p2_set_clear_bytes:	
	  lda #$0000
	  sta player.2.byte21
	  sta player.2.byte22
	  sta player.2.byte23
	  sta player.2.byte24
	  sta player.2.byte25
	  sta player.2.byte26
	  rts	

	
	

;================================================================		
;==============Player 1 routine==================================		
;================================================================	
;================================================================	  
	  
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
      and SJoy1, X 
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
      and SJoy1, X
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
      and SJoy1, X 
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
    


.ends
