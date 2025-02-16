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
    push bc
    ld bc, hl

    ; TODO - if the number is less than 3 digits (>= 99) then the ROM call will print 990 instead of 99
    ; might need to use a different ROM call to print the number when it's low.

    push de ; These ROM calls will overwrite de, so we need to save it
    call ROM_CALCSTACK_PUSH
    call ROM_CALCSTACK_DISPLAY
    pop de

    ; earlier we pushed bc
    pop bc

    ; print a carriage return
    ld a, 13
    rst $10
    ret

; set_screen_xy sets the cursor position to the coordinates in bc
set_screen_xy:
    ld a,22     ; ASCII control code for AT
    rst $10
    ld a,b
    rst $10
    ld a,c
    rst $10
    ret