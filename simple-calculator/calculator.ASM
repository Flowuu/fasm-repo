format PE console    ; define PE file format

include 'win32a.inc' ; include set of macros and definitions


entry start          ; define the entry point

section '.text' code readable executable
        start:       ; entry
              ; print [fams calculator]
              push msgTitle
              call [printf]
              add esp, 0x4

              ; calculation function
              push [intFirstNum]        ; load numbers on stack
              push [intSecondNum]
              call divFunc              ; call function
              add esp, 0x8              ; stack clean up

              push eax                  ; return value
              push msgOutput            ; "output: %d\n\0"
              call [printf]             ; call printf()
              add esp, 0x8              ; clean stack

              ; call system() with pause
              push cmdPause
              call [system]
              add esp, 0x4

              ; call ExitProcess
              push 0x0
              call [ExitProcess]


        addFunc:
              push ebp                ; save previous base pointer    (stack frame)
              mov  ebp, esp           ; setup new base pointer        (new stack frame)

              mov eax, [ebp + 0x8]    ; load 1st argument to eax
              mov ebx, [ebp + 0xC]    ; load 2st argument to ebx
              add eax, ebx            ; add both arguments

              mov esp, ebp            ; restore stack pointer         (clean stack)
              pop ebp                 ; restore previous base pointer (base pointer)
              ret                     ; return to caller              (address stored on stack)

        subFunc:
              push ebp
              mov  ebp, esp

              mov eax, [ebp + 0x8]
              mov ebx, [ebp + 0xC]
              sub eax, ebx

              mov esp, ebp
              pop ebp
              ret

        divFunc:
              push ebp
              mov  ebp, esp

              mov eax, [ebp + 0x8]
              mov ebx, [ebp + 0xC]
              div ebx

              mov esp, ebp
              pop ebp
              ret

        mulFunc:
              push ebp
              mov  ebp, esp

              mov eax, [ebp + 0x8]
              mov ebx, [ebp + 0xC]
              mul ebx

              mov esp, ebp
              pop ebp
              ret


section '.data' code readable writeable
        msgTitle              db '[fasm calculator]' , 0xA, 0x0
        msgOutput             db 'output: %d'        , 0xA, 0x0
        intFirstNum           dd 9                                ; first input number here!
        intSecondNum          dd 10                               ; second input number here!

        cmdPause              db 'pause', 0x0

section '.idata' import data readable writeable
        ; import libraries
        library kernel32, 'kernel32.dll', \
                msvcrt, 'msvcrt.dll'


        ; import functions
        import kernel32, \
               ExitProcess, 'ExitProcess'

        import msvcrt, \
               printf, 'printf', \
               system, 'system'