; is_divisible takes the 16-bit number in hl and checks if it's divisible by the 16 bit number in bc
; If hl is divisible by bc then the z flag will be set and the accumulator will be zero
is_divisible:
    push de
    ld d, h
    ld e, l      ; Copy hl to de
is_divisible_loop:
    sbc hl, bc   ; hl = hl - bc
    jr c, is_divisible_check  ; If hl < bc, check remainder
    jr is_divisible_loop      ; Keep subtracting
is_divisible_check:
    add hl, bc   ; Restore remainder (hl = hl + bc)
    ld a, h
    or l         ; If hl == 0, it's divisible
    pop de
    ret