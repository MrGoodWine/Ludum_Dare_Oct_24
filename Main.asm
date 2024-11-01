;------------------------------------------------------------------------
;-  Written by: Neviksti
;-     This was coded as an example for Darrok (from the zsnes message
;-     boards) who was interested in learning more about the SNES 
;-     hardware and language.
;-
;-     If you use my code, please share your creations with me
;-     as I am always curious :)
;------------------------------------------------------------------------

;=== Include MemoryMap, VectorTable, HeaderInfo ===
.INCLUDE "header.asm"

;=== Include Library Routines & Macros ===
.INCLUDE "LoadGraphics.asm"
.INCLUDE "InitSNES.asm"
.INCLUDE "2input.asm"
.INCLUDE "Sprites.asm"
.INCLUDE "Strings.asm"
.INCLUDE "Player.asm"
.INCLUDE "P1move.asm"
.INCLUDE "P2move.asm"
.INCLUDE "P3move.asm"
.INCLUDE "P4move.asm"
.INCLUDE "VBLANK.asm"
.INCLUDE "SetupVideo.asm"
.INCLUDE "SpawnSprites.asm"
.INCLUDE "collision.asm"
.INCBIN "pattern.bin"




;==============================================================================
; main
;==============================================================================



;==============================================================================
; main
;==============================================================================

;.DEFINE MapX		$18
;.DEFINE MapY		$1A
.DEFINE CurrentFrame	(SpriteBuf1+sframe)

.DEFINE FrameWait		$1C

.DEFINE InputCMP	$1F
.DEFINE p1ScoreR $20
.DEFINE p1ScoreW $21
.DEFINE p2ScoreR $22
.DEFINE p2ScoreW $23
.DEFINE p3ScoreR $24
.DEFINE p3ScoreW $25
.DEFINE p4ScoreR $26
.DEFINE p4ScoreW $27

.BANK 0 SLOT 0
.ORG 0
.SECTION "MainCode"

Main:

@reset:
	InitializeSNES

	rep #$10		;A/mem = 8bit, X/Y=16bit
	sep #$20

	; Load the first SPC
	lda 	#0
	;jsr 	LoadSPC
   	
	;Load palette to make our pictures look correct
	LoadPalette	BG_Palette

	; Load 16x14 tiles = 224 tiles = 448 words = 7168 bytes
	LoadBlockToVRAM	BackgroundMap, $0000, $2000
	
	; Load 384 tiles * (8bit color) = 0x6000 bytes
	LoadBlockToVRAM	BackgroundPics, $2000, $6000	
	
	; Load 128 tiles * (2bit color = 2 planes) = 2048 bytes
	
	LoadBlockToVRAM	HudPics, $5000, $0800
	LoadBlockToVRAM	ASCIITiles, $5200, $0800	
	
	LoadBlockToVRAM	HudMap, $6000, $0400
	
	; Load 16 16x16 tiles * (4bit color = 4 planes) = 4096 bytes
	LoadBlockToVRAM	SpriteTiles1, $6000, $2000	
	
	; LoadBlockToVRAM	SpriteTiles2, $6020, $400
	; LoadBlockToVRAM	SpriteTiles2, $8000, $2000



	;Set the priority bit of all the BG2 tiles
	LDA #$80
	STA $2115		;set up the VRAM so we can write just to the high byte
	LDX #$5800
	STX $2116
	LDX #$0400		;32x32 tiles = 1024
	LDA #$20
Next_tile:
	STA $2119
	DEX
	BNE Next_tile
	
	JSR SpriteInit	;setup the sprite buffer
	JSR JoyInit		;setup joypads and enable NMI
	
	
	
	
	
	
	
		.DEFINE numberofplayers $10
	;.DEFINE initID $0000
  
  
	ldx #$0000
	stx initID
	ldy #$0000
	CLC
  
  @initjumpback:
  	jsr PlayerInit 
	INX
	lda #$0005
	sta numberofplayers
	CPX numberofplayers
	CLC
	BNE @initjumpback
	
	

;====================================================================================
	;setup our walking sprite
	;put him in the center of the screen
	lda #$0	
	sta SpriteBuf1+sx1
	lda #$0	
	sta SpriteBuf1+sy1

	;put sprites #0 on screen
	lda #$AA
	sta SpriteBuf2

	;set the sprite to the highest priority
	lda player.1.animationFrame
	sta SpriteBuf1+stile1
	lda player.1.priorityPalette			
	sta SpriteBuf1+sprioritypalette1

;====================================================================================
	;setup our walking sprite
	;put him in the center of the screen
	lda #$0	
	sta SpriteBuf1+sx2
	lda #$0	
	sta SpriteBuf1+sy2


	;set the sprite to the highest priority
	lda player.2.animationFrame
	sta SpriteBuf1+stile2
	lda player.2.priorityPalette			
	sta SpriteBuf1+sprioritypalette2

;====================================================================================
		;setup our walking sprite
	;put him in the center of the screen
	lda #$0	
	sta SpriteBuf1+sx3
	lda #$0	
	sta SpriteBuf1+sy3


	;set the sprite to the highest priority
	lda player.3.animationFrame
	sta SpriteBuf1+stile3
	lda player.3.priorityPalette			
	sta SpriteBuf1+sprioritypalette3

;====================================================================================

		;setup our walking sprite
	;put him in the center of the screen
	lda #$0	
	sta SpriteBuf1+sx4
	lda #$0	
	sta SpriteBuf1+sy4



	;set the sprite to the highest priority
	lda player.4.animationFrame
	sta SpriteBuf1+stile4
	lda player.4.priorityPalette			
	sta SpriteBuf1+sprioritypalette4

;====================================================================================
	
	;setup the video modes and such, then turn on the screen
	JSR SetupVideo	
	
	jsr InitializePollen
	SpawnPollen1 newPollen1X, newPollen1Y
	SpawnPollen2 newPollen2X, newPollen2Y
	SpawnPollen3 newPollen3X, newPollen3Y
	SpawnPollen4 newPollen4X, newPollen4Y


InfiniteLoop:
	rep #$10
	lda #$81
	nop
	sta $4200
	
	
	wai     ;<============== Wait for VBLANK
	
	sep #$20
	lda #$0000


	SetCursorPos 6, 10
	lda player.1.pollenCollected
	sta p1ScoreR
	ldy #p1ScoreR
	PrintString "P1 POLLEN = %b   "
	SetCursorPos 07, 10
	lda player.2.pollenCollected
	sta p2ScoreR
	ldy #p2ScoreR
	PrintString "P2 POLLEN = %b    "
	SetCursorPos 08, 10
	lda player.3.pollenCollected
	sta p3ScoreR
	ldy #p3ScoreR
	PrintString "P3 POLLEN = %b   "
	SetCursorPos 09, 10
	lda player.4.pollenCollected
	sta p4ScoreR
	ldy #p4ScoreR
	PrintString "P4 POLLEN = %b   "
	
	
	
	
	
	
	;See what buttons were pressed
	ldx #$0000
	jsr MovementUpdateP1
	jsr MovementUpdatep2
	jsr MovementUpdatep3
	jsr MovementUpdatep4
	
	jsr CollisionCalc
	
	
	jsr SpriteUpdate
	jsr UpdatePollen

	
	lda $35
	cmp #$30
	beq @jumpToReset
	
	ldy #01
	nop
	sep #$30
	
	JMP InfiniteLoop	;Do this forever
	
@jumpToReset:	
jmp @reset
	
	.ENDS
;==========================================================================================

.BANK 1 SLOT 0
.ORG 0
.SECTION "CharacterData"

;Map data
BackgroundMap:
	.INCBIN ".\\Tilemaps\\bg.bin"
	
HudMap:	
	.INCBIN ".\\Tilemaps\\bg2.bin"

;Color data
BG_Palette:
	.INCBIN ".\\Pictures\\bg.cgr"
	.INCBIN ".\\Pictures\\bird-seed-font.cgr"
	.INCBIN ".\\Pictures\\hud.cgr"
	.INCBIN ".\\Pictures\\dummy_palette03.cgr"
	.INCBIN ".\\Pictures\\dummy_palette04.cgr"
	.INCBIN ".\\Pictures\\dummy_palette05.cgr"
	.INCBIN ".\\Pictures\\dummy_palette06.cgr"
	.INCBIN ".\\Pictures\\dummy_palette07.cgr"
	.INCBIN ".\\Pictures\\ant.cgr"
	.INCBIN ".\\Pictures\\aphid.cgr"
	.INCBIN ".\\Pictures\\firefly.cgr"
	.INCBIN ".\\Pictures\\ladybug.cgr"
	
	.INCBIN ".\\Pictures\\bash.cgr"
	;.INCBIN ".\\Pictures\\pollen.cgr"

SpriteTiles1:
		
		.INCBIN ".\\Pictures\\ant.vra"
		.INCBIN ".\\Pictures\\aphid.vra"
		.INCBIN ".\\Pictures\\firefly.vra"
		.INCBIN ".\\Pictures\\ladybug.vra"
		
		.INCBIN ".\\Pictures\\bash.vra"
		;.INCBIN ".\\Pictures\\pollen.vra"
		
	
SpriteTiles2:
	
	

ASCIITiles:
	.INCBIN ".\\Pictures\\bird-seed-font.vra"
	;.INCBIN ".\\Pictures\\ascii.pic"

.ENDS

;==========================================================================================

.BANK 4 SLOT 0
.ORG 0
.SECTION "BG_CharacterData"

;character data
BackgroundPics:
	.INCBIN ".\\Pictures\\bg.vra"
	
	
HudPics:
	
	.INCBIN ".\\Pictures\\bird-seed-font.vra"
	.INCBIN ".\\Pictures\\hud.vra"
.ENDS

;==========================================================================================
