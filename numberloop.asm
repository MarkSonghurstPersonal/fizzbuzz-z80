; number_loop subroutine
; iterates through a string of numbers from the value in de to the value in hl
number_loop:

    ; Calculate the total number of loop iterations required and store it in bc
    push hl
    sbc hl, de
    ld bc, hl
    pop hl
number_loop_iterate:
    ld a, b                 ; Load a with b (the high byte of bc)
    or c                    ; OR a with c (the low byte of bc), if they are both zero, we're done
    jp z, number_loop_end   ; If bc is 0, we're done

    ; Print the iteration counter in bc to the coordinates loaded into bc
    push hl
    push bc
    ld hl, bc
    ld bc, (iteration_xy)
    call print_number_with_cr
    pop bc
    pop hl

    ; Print the number in hl at the coordinates in bc
    push hl
    push bc
    ld hl, de
    ld bc, (current_number_xy)
    call print_number_with_cr
    pop bc
    pop hl

    ; Delay so we can see the number and FizzBuzz result
    ;push bc
    ;call delay
    ;pop bc

    dec bc                  ; Decrement bc by 1
    inc de                  ; Increment de by 1
    jr number_loop_iterate

number_loop_end ret

delay:
    ; code below isn't working - TODO: fix this
    ld b,10
delay0:
    halt
    djnz delay0
    ret