; print_string subroutine
; Assumes HL points to the string to be printed
; stops printing when it reaches NULL (0)
print_string:
    ld a, (hl)
    cp 0
    jr z, print_string_end
    rst $10
    inc hl
    jr print_string
print_string_end ret

; print_string_with_cr subroutine
; Assumes HL points to the string to be printed
; stops printing when it reaches NULL (0)
; prints a carriage return after the string.
print_string_with_cr:
    call print_string
    ld a, 13 ; 13 is the ASCII code for CR
    rst $10
    ret