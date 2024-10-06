;================================================================		
;================================================================	
;================================================================	  
	  
.bank 0 slot 0
.org 0
.section "Player 4 Routine"  
	  
MovementUpdateP4:
      jsr p4_set_target_y_velocity
      jsr p4_set_target_x_velocity
	  
@p4_up_move:
	  lda $2F
	  cmp #$08 ;up
	  bne @p4_left_move  
	  lda player.4.positionY_Lo
	  sbc player.4.targetVelocityY
	  sbc player.4.targetVelocityY
	  sta player.4.positionY_Lo	 
	  sta player.4.spriteY_Lo
	  jmp @p4_set_clear_bytes
	  
@p4_left_move:
	  cmp #$02 ;left
	  bne @p4_down_move  
	  lda player.4.positionX_Lo
	  sbc player.4.targetVelocityX
	  sbc player.4.targetVelocityX
	  sta player.4.positionX_Lo	 
	  sta player.4.spriteX_Lo
	  jmp @p4_set_clear_bytes	  
	  
@p4_down_move:  
	  cmp #$04 ;down
	  bne @p4_right_move
	  lda player.4.positionY_Lo
	  adc player.4.targetVelocityY
	  sta player.4.positionY_Lo	 
	  sta player.4.spriteY_Lo
	  jmp @p4_set_clear_bytes	
	  
@p4_right_move:
	  cmp #$01 ;right
	  bne  @p4_right_down_move
	  lda player.4.positionX_Lo
	  adc player.4.targetVelocityX
	  sta player.4.positionX_Lo	 
	  sta player.4.spriteX_Lo
jmp @p4_set_clear_bytes		  
	  
@p4_right_down_move:
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
	  jmp @p4_set_clear_bytes	
	  
@p4_left_down_move:
	  cmp #$06 ;left down
	  bne @p4_set_clear_bytes
	  lda player.4.positionX_Lo
	  sbc player.4.targetVelocityX
	  sbc player.4.targetVelocityX
	  sta player.4.positionX_Lo	 
	  sta player.4.spriteX_Lo	
	  lda player.4.positionY_Lo
	  adc player.4.targetVelocityY
	  sta player.4.positionY_Lo	 
	  sta player.4.spriteY_Lo	

@p4_set_clear_bytes:	
	  lda #$0000
	  sta player.4.byte21
	  sta player.4.byte22
	  sta player.4.byte23
	  sta player.4.byte24
	  sta player.4.byte25
	  sta player.4.byte26
	  rts	

	
	

;================================================================		
;==============Player 1 routine==================================		
;================================================================	
;================================================================	  
	  
p4_set_target_y_velocity
      ; Check if the B button is being pressed and save the state in the X
      ; register

	  Rep #$30
	  lda #$0000
	  sep #$20
	  
	  
   
    @p4check_down: 
	  ldx #03
      lda #BUTTON_DOWN
	  sta CurrentButton
      and SJoy3, X
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
	  ldx #03
      lda #BUTTON_UP
	  sta CurrentButton
      and SJoy3, X 
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
	 
	  
   
    @p4check_right: 
	  ldx #03
      lda #BUTTON_RIGHT
	  sta CurrentButton
      and SJoy3, X
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
	  ldx #03
      lda #BUTTON_LEFT
	  sta CurrentButton
      and SJoy3, X 
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
    


.ends