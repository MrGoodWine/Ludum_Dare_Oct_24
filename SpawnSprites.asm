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

.MACRO SpawnPollen

		;lda pollen1
		;Sta pollenTile1
		lda \1 
		sta pollenX1
		lda \2
		sta pollenY1
		
		
.ENDM

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

		;lda pollen1
		;Sta pollenTile1
		lda \1 
		sta BashDustX1
		lda \2
		sta BashDustY1
		
		
.ENDM

rts






.ends