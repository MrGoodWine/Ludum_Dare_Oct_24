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

.DEFINE pollenX1		 $A0
.DEFINE pollenY1		 $A1
.DEFINE pollenTile1	 	 $A2
.DEFINE pollenPal1 		 $A3
.DEFINE pollenX2		 $A4
.DEFINE pollenY2		 $A5
.DEFINE pollenTile2	 	 $A6
.DEFINE pollenPal2 		 $A7
.DEFINE pollenX3		 $A8
.DEFINE pollenY3		 $A9
.DEFINE pollenTile3		 $AA
.DEFINE pollenPal3 		 $AB
.DEFINE pollenX4		 $AC
.DEFINE pollenY4		 $AD
.DEFINE pollenTile4		 $AE
.DEFINE pollenPal4 	 	 $AF

.DEFINE pollen1	$E2
.DEFINE pollen2	$E4

.MACRO SpawnPollen

		lda pollen1
		Sta pollenTile1
		lda \1 
		sta pollenX1
		lda \2
		sta pollenY1
		
		
.ENDM

;================================================================	

.DEFINE BashDustX1		 $B0
.DEFINE BashDustY1		 $B1
.DEFINE BashDustTile1	 $B2
.DEFINE BashDustPal1 	 $B3
.DEFINE BashDustX2		 $B4
.DEFINE BashDustY2		 $B5
.DEFINE BashDustTile2	 $B6
.DEFINE BashDustPal2 	 $B7
.DEFINE BashDustX3		 $B8
.DEFINE BashDustY3		 $B9
.DEFINE BashDustTile3	 $BA
.DEFINE BashDustPal3 	 $BB
.DEFINE BashDustX4		 $BC
.DEFINE BashDustY4		 $BD
.DEFINE BashDustTile4	 $BE
.DEFINE BashDustPal4 	 $BF


SpawnBashDust:



rts




.ends