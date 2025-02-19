fizz_border:
    push af
    ld a, 3
    call ROM_BORDER
    pop af
    ret

buzz_border:
    push af
    ld a, 5
    call ROM_BORDER
    pop af
    ret

reset_border:
    
    push af
    ld a, 7
    call ROM_BORDER
    pop af
    ret