; number_loop subroutine
; iterates through a string of numbers from the value in hl to the value in de
number_loop:
    ld bc, de   ; We decrement bc on each iteration, when it hits zero, the loop is done.
    ;ld bc, de-h1 ; Load bc with the number of loop iterations required
number_loop_iterate:
    ld a, b                 ; Load a with b (the high byte of bc)
    or c                    ; OR a with c (the low byte of bc), if they are both zero, we're done
    jp z, number_loop_end   ; If bc is 0, we're done

    ; Print the number in hl at the coordinates in bc
    push hl
    push bc
    push de
    ld bc, (current_number_xy)
    call print_number_with_cr
    pop de
    pop bc
    pop hl

    ; Delay so we can see the number and FizzBuzz result
    ;call delay

    dec bc                  ; Decrement bc by 1
    inc hl                  ; Increment hl by 1
    jr number_loop_iterate

number_loop_end ret

;delay:
;    ld b,10
;delay0:
;    halt
;    djnz delay0
;    ret