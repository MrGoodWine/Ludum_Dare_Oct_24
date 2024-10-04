;============================================================================
; SetupVideo -- Set the video mode for the demo
;----------------------------------------------------------------------------
; In: None
;----------------------------------------------------------------------------
; Out: None
;----------------------------------------------------------------------------
SetupVideo:
	php

	rep #$10		;A/mem = 8bit, X/Y=16bit
	sep #$20
      
	lda #$63		;Sprites 16x16 or 32x32, character data at $6000 (word address)
					;$2101  wb++?- 
					;     sssnnbbb
					;     sss       = Object size:
					;           000 =  8x8  and 16x16 sprites
					;           001 =  8x8  and 32x32 sprites
					;           010 =  8x8  and 64x64 sprites
					;           011 = 16x16 and 32x32 sprites
					;           100 = 16x16 and 64x64 sprites
					;           101 = 32x32 and 64x64 sprites
					;           110 = 16x32 and 32x64 sprites ('undocumented')
					;           111 = 16x32 and 32x32 sprites ('undocumented')
					;        nn     = Name Select
					;          bbb  = Name Base Select (Addr>>14)	
      sta $2101         

	lda #$12		;Set video mode 2, 16x16 tiles (256 color BG1, 4 color BG2)
      sta $2105         

	lda #$00		;Set BG1's Tile Map VRAM offset to $0000 (word address)
      sta $2107		;   and the Tile Map size to 64 tiles x 64 tiles

	lda #$52		;Set BG1's Character VRAM offset to $2000 (word address)
      sta $210B		;Set BG2's Character VRAM offset to $5000 (word address)

	lda #$58		;Set BG2's Tile Map VRAM offset to $5800 (word address)
      sta $2108		;   and the Tile Map size to 32 tiles x 32 tiles

	lda #$13		;Turn on BG1 and BG2 and Sprites
      sta $212C

      lda #$0F		;Turn on screen, full brightness
      sta $2100		

	lda #$FF		;Scroll BG2 down 1 pixel
	sta $2110
	sta $2110         

	plp
	rts

;