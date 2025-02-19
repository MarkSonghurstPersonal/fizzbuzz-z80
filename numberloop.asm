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
    dec hl ; dec 1 from the number so it's 0-based for printing
    ld bc, (iteration_xy)
    call print_number_with_cr
    pop bc
    pop hl

    ; Print the number in de at the coordinates in bc
    push hl
    push bc
    ld hl, de
    inc hl ; inc 1 from the number so it's 1-based for printing
    ld bc, (current_number_xy)
    call print_number_with_cr
    pop bc
    pop hl

    ; Halt until the next interrupt, so we can see the number and FizzBuzz result
    halt

    dec bc                  ; Decrement bc by 1
    inc de                  ; Increment de by 1
    jr number_loop_iterate

number_loop_end ret
