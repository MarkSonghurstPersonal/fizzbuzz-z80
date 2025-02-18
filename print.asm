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

    ; Wipe the longest possible number of characters in hl to clear up trash - for example, 
    ; if it was previously 100 and we're now printing 99, we need to wipe the line otherwise we get 990
    push hl
    call wipe_number
    pop hl
    call set_screen_xy ; reset the cursor position

    ; Print the number in hl, via rom calls that use bc
    push bc
    ld bc, hl
    push de ; These ROM calls will overwrite de, so we need to save it
    call ROM_CALCSTACK_PUSH
    call ROM_CALCSTACK_DISPLAY
    pop de
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

; wipe_number prints string_wipenumber at the current cursor position
wipe_number:
    ld hl, string_wipenumber
    call print_string
    ret