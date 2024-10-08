; Register names based on snes.txt


; Display control 1 [INIDISP]
;
; 7: Forced blanking
; 6-4: n/a
; 3-0: Master brightness (0=black, 15 max)
;
.define INIDISP	$2100

; OAM size register [OBSEL]
; sssnnbbb
;
; s: Size
; n: Name selection (upper 4k word addr)
; b: Base selection (8k word seg. addr)
.define OBSEL	$2101
.define OBSEL_OBJSIZE_SHIFT	5

; OAM address register [OAMADDL/OAMADDH]
; aaaaaaaa r000000m
;
; a: OAM address.
; r: OAM priority rotation.
; m: OAM address MSB.
.define OAMADDL	$2102
.define OAMADDH $2103


.define OAMDATA	$2104

; Screen mode register [BGMODE]
; abcdefff
;
; a: BG4 tile size (0=8x8, 1=16x16)
; b: BG3 tile size (0=8x8, 1=16x16).
; c: BG2 tile size (0=8x8, 1=16x16).
; d: BG1 tile size (0=8x8, 1=16x16).
; e: Highest priority for BG3 in MODE 1.
; f: MODE definition.
.define BGMODE $2105

; Screen pixelation register [MOSAIC]
; xxxxabcd
;
; x: Pixel size (0=Smallest, $F=Largest).
; a: Affect BG4.
; b: Affect BG3.
; c: Affect BG2.
; d: Affect BG1.
;
.define MOSAIC $2106

; BG1 VRAM location register [BG1SC]
; xxxxxxab
; x: Base address
; ab: SC size		(00: 32x32, 01: 64x32, 10: 32x64, 11: 64x64)
.define BG1SC $2107
.define BG2SC $2108
.define BG3SC $2109
.define BG4SC $210A

; BG1 & BG2 VRAM location register [BG12NBA]
; aaaabbbb
; a: Base address for BG2.
; b: Base address for BG1.
.define BG12NBA $210B
.define BG34NBA $210C

; BGx horizontal/vertical scroll register
;
; Write twice: First write (Lower 8 bits), second: upper 3 bits (+5 in mode 7)
.define BG1HOFS $210D
.define BG1VOFS $210E
.define BG2HOFS $210F
.define BG2VOFS $2110

; Video port control [VMAIN]
; i000abcd
; i: 0 = Addr-inc after writing to $2118 or reading from $2139.
;    1 = Addr-inc after writing to $2119 or reading from $213A.
; ab: Full graphic (1: 8for32, 2: 8for64, 3: 8for128)
; cd: Source address increment (0: 1x1, 1: 32x32, 2: 64x64, 3: 128x128)
.define VMAIN $2115

; Video port address
.define VMADDL $2116
.define VMADDH $2117

; Video port data
.define VMDATAL $2118
.define VMDATAH $2119

; TM
; 000abcde
; a: OBJ/OAM disable/enable.
; b: Disable/enable BG4.
; c: Disable/enable BG3.
; d: Disable/enable BG2.
; e: Disable/enable BG1.
.define TM $212C

; CGADSUB
; mrgsabcd
; m: 0 = enable + color-data mode.
;    1 = Enable - color-data mode.
; r:
; g: Affect back area
; s: Affer OBJs
; a: Affect BG4
; b: Affect BG3
; c: Affect BG2
; d: Affect BG1
.define CGADSUB	$2131


.define APUIO0	$2140
.define APUIO1	$2141
.define APUIO2	$2142
.define APUIO3	$2143

.define WMDATA	$2180
.define WMADDL	$2181	; lower 8 bit
.define WMADDM	$2182	; middle 8 bit
.define WMADDH	$2183

; Controller IO/Ports

; 7-3: not used
; 2: OUT2 (no connect?)
; 1: OUT1 (no connect?)
; 0: Strobe to both gamepads
.define JOYWR $4016

; 1: Gameport 1 pin 5 (JOY3)
; 0: Gameport 1 pin 4 (JOY1)
.define JOYA $4016

; 1: Gameport 2, pin 5 (JOY4)
; 0: GAmeport 2, pin 4 (JOY2)
.define JOYB $4017

; 8-bit multiplicand
.define WRMPYA	$4202
; 8-bit mutiplier and start
.define WRMPYB	$4203


; DMA enable register [MDMAEN]
.define MDMAEN	$420B

; Unsigned Division Remainder / Multiply Product (lo.8bit) (R)
.define RDMPYL	$4216
; Unsigned Division Remainder / Multiply Product (up.8bit) (R)
.define RDMPYH	$4217

; DMA Control register (channel 0)
; vh0cbaaa
; v: 0 = CPU memory -> PPU, 1 = PPU -> CPU memory.
; h: For HDMA only: 0 = Absolute addressing, 1 = Indirect addressing
; c: 0 = Auto address inc/decrement, 1 = Fixed address (for VRAM, etc.).
; b: 0 = Automatic increment, 1 = Automatic decrement.
; a: 000 = 1 address write twice: LH.
;    001 = 2 addresses: LH.
;    010 = 1 address write once.
;    011 = 2 addresses write twice: LLHH
;    100 = 4 addresses: LHLH
.define DMAP0 $4300
.define DMAP1 $4310
.define DMAP2 $4320
.define DMAP3 $4330
.define DMAP4 $4340
.define DMAP5 $4350
.define DMAP6 $4360
.define DMAP7 $4370

; DMA Destination register (channel 0)
; xxxxxxxx
; x: Low-byte address.
.define BBAD0 $4301
.define BBAD1 $4311
.define BBAD2 $4321
.define BBAD3 $4331
.define BBAD4 $4341
.define BBAD5 $4351
.define BBAD6 $4361
.define BBAD7 $4371

; DMA Source address (channel 0)
.define A1T0L $4302
.define A1T0H $4303
.define A1T1L $4312
.define A1T1H $4313
.define A1T2L $4322
.define A1T2H $4323

.define A1T7L $4372
.define A1T7H $4373
; todo: other channels

; Source bank address (channel 0)
.define A1B0 $4304
.define A1B1 $4314
.define A1B2 $4324
.define A1B3 $4334
.define A1B4 $4344
.define A1B5 $4354
.define A1B6 $4364
.define A1B7 $4374

; DMA transfer size & HDMA address register
.define DAS0L $4305
.define DAS0H $4306
.define DAS1L $4315
.define DAS1H $4316
.define DAS2L $4325
.define DAS2H $4326
.define DAS7L $4375
.define DAS7H $4376


;;;;;;;;;;;;;;;;;;;

; Constants for BG Map entries

.define BGMAPENT_CHARNO_SHIFT 0
.define BGMAPENT_PALSHIFT 10
.define BGMAPENT_BGPRIO $2000
.define BGMAPENT_YFLIP $4000
.define BGMAPENT_XFLIP $8000


