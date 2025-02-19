fizz_beep:
    push hl
    push de
    ld hl, 133
    ld de, 130
    call ROM_BEEP
    pop de
    pop hl
    ret

buzz_beep:
    push hl
    push de
    ld hl, 551
    ld de, 130
    call ROM_BEEP
    pop de
    pop hl
    ret
