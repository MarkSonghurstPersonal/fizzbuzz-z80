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
    ei   ; Enable interrupts
    im 1 ; Set interrupt mode 1 (ROM interrupt handler)

    call ROM_CLS

    ld de, (iterate_from)
    ld hl, (iterate_until)
    inc hl ; Increment by 1 so we include the last number

    call number_loop

    ret ; End program


;===========================================================================
; ROM functions
;===========================================================================

; Clears the screen and puts the cursor at the top of the screen
ROM_CLS     equ $0DAF 
; Push the number in bc onto the calculator stack
ROM_CALCSTACK_PUSH equ $2D2B
; Display the top of the calculator stack
ROM_CALCSTACK_DISPLAY equ $2DE3
; Beep the speaker using pitch in hl and duration in de
ROM_BEEP equ $03BD
; Set the border to the colour in a
ROM_BORDER equ $229B

;===========================================================================
; Include modules
;===========================================================================
    include "print.asm"
    include "numberloop.asm"
    include "divide.asm"
    include "beep.asm"
    include "border.asm"

;===========================================================================
; Data
;
; Strings used with print_string must be NULL terminated.
;===========================================================================
string_fizz: 
    db 'Fizz', 0 
string_no_fizz: 
    db '    ', 0 

string_buzz:
    db 'Buzz', 0 
string_no_buzz:
    db '    ', 0 

string_wipenumber
    db '     ', 0
iterate_until:
    defw 250
iterate_from:
    defw 1
current_number_xy:
    defb 0,0    
iteration_xy:
    defb 0,0

;===========================================================================
; Build
;===========================================================================
    SAVESNA "fizzbuzz.sna", main
