.BANK 0 SLOT 0
.ORG 0
.SECTION "MainCode"

Main:
    InitializeSNES

    ; Set A/mem to 8-bit mode, X/Y to 16-bit mode
    rep #$10
    sep #$20

    ; Load SPC data for music
    lda #$00
    sta $2140        ; Set the SPC port to communicate

    ; Load the music into SPC
    JSR LoadMusic

    ; Play the music in loop
    JSR PlayMusicLoop

InfiniteLoop:
    wai              ; Wait for VBLANK
    JMP InfiniteLoop ; Keep looping forever

.ENDS


.BANK 0 SLOT 0
.ORG 0
.SECTION "MusicPlayerCode" SEMIFREE

; Load the music data into SPC700 memory using DMA
LoadMusic:
    LDA #$00
    STA $2140         ; Reset SPC port 0
    
    ; Set SPC transfer source
    LDX #$0000
    STX $2141         ; Write source address to SPC

    ; Load the music file into the SPC
    LDA #$7F
    STA $2142         ; Write data to SPC to start playing

    LDA #$00
    STA $2143         ; SPC control
    RTS               ; Return from subroutine

; Play the music in a loop by restarting once it ends
PlayMusicLoop:
    LDA #$01
    STA $2140         ; Send play command to SPC

Loop:
    LDA $2142         ; Check if music has ended
    BEQ RestartMusic  ; If ended, restart

    WAI               ; Wait for VBLANK
    BRA Loop          ; Loop indefinitely

RestartMusic:
    JSR LoadMusic     ; Reload the music data
    BRA Loop          ; Continue looping the music

.ENDS


.BANK 1 SLOT 0
.ORG 0
.SECTION "MusicData"

    ; Load the music file from the 'Music' folder
    .INCBIN "Music/doop.gsm"

.ENDS
