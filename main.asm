;===========================================================================
; Main program
;===========================================================================

    DEVICE ZXSPECTRUM48
    SLDOPT COMMENT WPMEM, LOGPOINT, ASSERTION

    org $8000

;===========================================================================
; main routine - the code execution starts here.
;===========================================================================
main:
    call ROM_CLS

    ld de, (iterate_from)
    ld hl, (iterate_until)
    call number_loop

;    ld hl, string_fizz  
;    call print_string_with_cr 

    ;ld hl, string_buzz
    ;call print_string 

    ret                 ; End program



;===========================================================================
; ROM functions
;===========================================================================

; Clears the screen and puts the cursor at the top of the screen
ROM_CLS     equ $0DAF 
; Push the number in bc onto the calculator stack
ROM_CALCSTACK_PUSH equ $2D2B
; Display the top of the calculator stack
ROM_CALCSTACK_DISPLAY equ $2DE3

;===========================================================================
; Include modules
;===========================================================================
    include "print.asm"
    include "numberloop.asm"

;===========================================================================
; Data
;
; Strings used with print_string must be NULL terminated.
;===========================================================================
string_fizz: 
    db 'Fizz', 0 
string_buzz:
    db 'Buzz', 0 
string_wipenumber
    db '     ', 0
iterate_until:
    defw 500
iterate_from:
    defw 0
current_number_xy:
    defb 5,3    
iteration_xy:
    defb 0,0

;===========================================================================
; Build
;===========================================================================
    SAVESNA "fizzbuzz.sna", main
