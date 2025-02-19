; number_loop
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
   
    ; Print the number in de at the coordinates in bc
    push hl
    push bc
    ld hl, de
    ld bc, (current_number_xy)
    call print_number_with_cr
    pop bc
    pop hl

    call number_loop_fizz
    call delay
    call number_loop_buzz
    call delay
    
    dec bc                  ; Decrement bc by 1
    inc de                  ; Increment de by 1
    jr number_loop_iterate

number_loop_end: 
    ret

delay:
    ; Halt for 10 interrupts, so we can see the number and FizzBuzz result
    push bc
    ld b, 10
delay_continue:   
    halt
    djnz delay_continue
    pop bc
    ret    

number_loop_fizz:
    push hl
    push bc
    ld hl, de
    ld bc, 3
    call is_divisible
    jr z, number_loop_fizz_print
    jr nz, number_loop_fizz_clear
number_loop_fizz_end:
    pop bc
    pop hl
    ret
number_loop_fizz_print:
    push hl
    ld hl, string_fizz  
    call print_string_with_cr 
    pop hl
    call fizz_border
    call fizz_beep
    jr number_loop_fizz_end
number_loop_fizz_clear:
    push hl
    ld hl, string_no_fizz  
    call print_string_with_cr
    call reset_border
    pop hl
    jr number_loop_fizz_end


number_loop_buzz:
    push hl
    push bc
    ld hl, de
    ld bc, 5
    call is_divisible
    jr z, number_loop_buzz_print
    jr nz, number_loop_buzz_clear
number_loop_buzz_end:
    pop bc
    pop hl
    ret
number_loop_buzz_print:
    push hl
    ld hl, string_buzz  
    call print_string_with_cr 
    pop hl
    call buzz_border
    call buzz_beep
    jr number_loop_buzz_end
number_loop_buzz_clear:
    push hl
    ld hl, string_no_buzz  
    call print_string_with_cr
    call reset_border
    pop hl
    jr number_loop_buzz_end
