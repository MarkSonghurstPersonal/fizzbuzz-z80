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

    ld HL, string_fizz  ; Load the address of the string into HL
    call print_string_with_cr   ; Call the subroutine to print the string


    ld HL, string_buzz
    call print_string 

    ret                 ; End program



;===========================================================================
; ROM functions
;===========================================================================

; Clears the screen and puts the cursor at the top of the screen
ROM_CLS     equ $0DAF 

;===========================================================================
; Include modules
;===========================================================================
    include "printstring.asm"


;===========================================================================
; Static data
;
; Strings used with print_string must be NULL terminated.
;===========================================================================
string_fizz:
    db 'Fizz', 0 
string_buzz:
    db 'Buzz', 0 




    
;===========================================================================
; Build
;===========================================================================
    SAVESNA "fizzbuzz.sna", main
