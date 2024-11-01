



;================================================================		
;================================================================	
;================================================================	
.bank 0 slot 0
.org 0
.section "Spawn Sprites"  

;================================================================	


;$0000	XXXXXXXX	YYYYYYYY		X=Xpos (bits 0-7) Y=Ypos										Sprite 0
;$0001	TTTTTTTT	YXPPCCCT		T=Tile Y=yflip X=xflip P=priority compared to BG C=palette +128	Sprite 0

;$0100	SXSXSXSX	(no 2nd byte)	S=LargeSize (1=Large size) sprite X=Xpos (bit 8)				Sprite 0-3
;$0101	SXSXSXSX	(no 2nd byte)	S=LargeSize (1=Large size) sprite X=Xpos (bit 8)				Sprite 4-7

.DEFINE pollen1Timer	$50
.DEFINE pollen2Timer	$51
.DEFINE pollen3Timer	$52
.DEFINE pollen4Timer	$53
.DEFINE newPollen1X		$54
.DEFINE newPollen1Y		$55
.DEFINE newPollen2X		$56
.DEFINE newPollen2Y		$57
.DEFINE newPollen3X		$58
.DEFINE newPollen3Y		$59
.DEFINE newPollen4X		$5A
.DEFINE newPollen4Y		$5B

.DEFINE PollenRNGIndex	$5C

.DEFINE PollenRNGBank	$0100

.DEFINE pollenX1		 $60
.DEFINE pollenY1		 $61
.DEFINE pollenTile1	 	 $62
.DEFINE pollenPal1 		 $63
.DEFINE pollenX2		 $64
.DEFINE pollenY2		 $65
.DEFINE pollenTile2	 	 $66
.DEFINE pollenPal2 		 $67
.DEFINE pollenX3		 $68
.DEFINE pollenY3		 $69
.DEFINE pollenTile3		 $6A
.DEFINE pollenPal3 		 $6B
.DEFINE pollenX4		 $6C
.DEFINE pollenY4		 $6D
.DEFINE pollenTile4		 $6E
.DEFINE pollenPal4 	 	 $6F



;.DEFINE pollen1	$D2
;.DEFINE pollen2	$D4
InitializePollen:
	lda #$78
	sta newPollen1X
	lda #$58
	sta newPollen1Y
	
	lda #$78
	sta newPollen2X
	lda #$98
	sta newPollen2Y
	
	lda #$58
	sta newPollen3X
	lda #$78
	sta newPollen3Y
	
	lda #$98
	sta newPollen4X
	lda #$78
	sta newPollen4Y
	
	
	
	
	php	

	rep	#$30	;16bit mem/A, 16 bit X/Y

	ldx #$0000
	
_clr:
	lda $877A, x
	sta PollenRNGBank, x	
	inx
	cpx #$00FE
	bne _clr	
	
	

	plp
	
	
rts

UpdatePollen:
sep #$20
	jsr UpdatePollen1
	jsr UpdatePollen2
	jsr UpdatePollen3
	jsr UpdatePollen4

	lda PollenRNGIndex
	ina
	sta PollenRNGIndex
rts


.MACRO SpawnPollen1

		lda \1 
		sta pollenX1
		lda \2
		sta pollenY1
		lda #$D4
		sta pollenTile1
		lda #$38
		sta pollenPal1
		ldx PollenRNGIndex
		lda PollenRNGBank, x
		inx
		stx PollenRNGIndex
		sta pollen1Timer

		
.ENDM

.MACRO ClearPollen1

		lda #$EF
		sta pollenX1
		lda #$EF
		sta pollenY1
		lda #$D4
		sta pollenTile1
		lda #$38
		sta pollenPal1
.ENDM	



.MACRO SpawnPollen2

		lda \1 
		sta pollenX2
		lda \2
		sta pollenY2
		lda #$D4
		sta pollenTile2
		lda #$38
		sta pollenPal2
		ldx PollenRNGIndex
		lda PollenRNGBank, x
		inx
		stx PollenRNGIndex
		sta pollen2Timer
		
.ENDM

.MACRO ClearPollen2

		lda #$EF
		sta pollenX2
		lda #$EF
		sta pollenY2
		lda #$D4
		sta pollenTile2
		lda #$38
		sta pollenPal2
		
.ENDM

.MACRO SpawnPollen3

		lda \1 
		sta pollenX3
		lda \2
		sta pollenY3
		lda #$D4
		sta pollenTile3
		lda #$38
		sta pollenPal3
		ldx PollenRNGIndex
		lda PollenRNGBank, x
		inx
		stx PollenRNGIndex
		sta pollen3Timer
		
.ENDM

.MACRO ClearPollen3

		lda #$EF
		sta pollenX3
		lda #$EF
		sta pollenY3
		lda #$D4
		sta pollenTile3
		lda #$38
		sta pollenPal3
		
.ENDM
.MACRO SpawnPollen4

		lda \1 
		sta pollenX4
		lda \2
		sta pollenY4
		lda #$D4
		sta pollenTile4
		lda #$38
		sta pollenPal4
		ldx PollenRNGIndex
		lda PollenRNGBank, x
		inx
		stx PollenRNGIndex
		sta pollen4Timer
		
.ENDM

.MACRO ClearPollen4

		lda #$EF
		sta pollenX4
		lda #$EF
		sta pollenY4
		lda #$D4
		sta pollenTile4
		lda #$38
		sta pollenPal4
		
.ENDM





UpdatePollen1:

		clc
		lda pollen1Timer
		cmp #$05
		bcs @UP1
		
		ldx PollenRNGIndex
		lda PollenRNGBank, x
		sta newPollen1X
		inx
		lda PollenRNGBank, x
		sta newPollen1Y
		stx PollenRNGIndex
		SpawnPollen1 newPollen1X, newPollen1Y
	
		rts
@UP1:
		dea 
		sta pollen1Timer
		
		rts
		
		
UpdatePollen2:

		clc
		lda pollen2Timer
		cmp #$05
		bcs @UP2
		
		ldx PollenRNGIndex
		lda PollenRNGBank, x
		sta newPollen2X
		inx
		lda PollenRNGBank, x
		sta newPollen2Y
		stx PollenRNGIndex
		SpawnPollen2 newPollen2X, newPollen2Y
	
		rts
@UP2:

		dea 
		sta pollen2Timer
		
		rts
		
		
UpdatePollen3:

		clc
		lda pollen3Timer
		cmp #$05
		bcs @UP3
		ldx PollenRNGIndex
		lda PollenRNGBank, x
		sta newPollen3X
		inx
		lda PollenRNGBank, x
		sta newPollen3Y
		stx PollenRNGIndex
		SpawnPollen3 newPollen3X, newPollen3Y
	
		rts
@UP3:

		dea 
		sta pollen3Timer
		
		rts
		
		
UpdatePollen4:

		clc
		lda pollen4Timer
		cmp #$05
		bcs @UP4
		ldx PollenRNGIndex
		lda PollenRNGBank, x
		sta newPollen4X
		inx
		lda PollenRNGBank, x
		sta newPollen4Y
		stx PollenRNGIndex
		SpawnPollen4 newPollen4X, newPollen4Y
		rts
@UP4:

		
		dea 
		sta pollen4Timer
		
		rts




;================================================================	

.DEFINE BashDustX1		 $70
.DEFINE BashDustY1		 $71
.DEFINE BashDustTile1	 $72
.DEFINE BashDustPal1 	 $73
.DEFINE BashDustX2		 $74
.DEFINE BashDustY2		 $75
.DEFINE BashDustTile2	 $76
.DEFINE BashDustPal2 	 $77
.DEFINE BashDustX3		 $78
.DEFINE BashDustY3		 $79
.DEFINE BashDustTile3	 $7A
.DEFINE BashDustPal3 	 $7B
.DEFINE BashDustX4		 $7C
.DEFINE BashDustY4		 $7D
.DEFINE BashDustTile4	 $7E
.DEFINE BashDustPal4 	 $7F


.MACRO SpawnBashDust

		lda \1 
		sta BashDustX1
		lda \2
		sta BashDustY1
		
		
.ENDM

rts






.ends