; print_string subroutine
; Assumes hl points to the string to be printed
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
; Assumes hl points to the string to be printed
; stops printing when it reaches NULL (0)
; prints a carriage return after the string.
print_string_with_cr:
    call print_string
    ld a, 13 ; 13 is the ASCII code for CR
    rst $10
    ret

; print_number_with_cr subroutine
; prints the number in hl to the screen at the coordinates in bc
print_number_with_cr:
    call set_screen_xy
    ld bc, hl
    call ROM_CALCSTACK_PUSH
    call ROM_CALCSTACK_DISPLAY

    ; print a carriage return
    ld a, 13
    rst $10
    ret

; set_screen_xy sets the cursor position to the coordinates in b,c
set_screen_xy:
    ld a,22     ; ASCII control code for AT
    rst $10
    ld a,b
    rst $10
    ld a,c
    rst $10
    ret