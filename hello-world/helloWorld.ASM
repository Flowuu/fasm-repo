format PE console    ; define PE file format

include 'win32a.inc' ; include set of macros and definitions


entry start          ; define the entry point

section '.text' code readable executable
        start:       ; entry
             push msgHelloWorld    ; push msg on stack
             call [printf]         ; call printf()
             add esp, 0x4          ; clean up stack

             push cmdPause         ; push cmdPause on stack
             call [system]         ; call system()
             add esp, 0x4          ; clean up

             push 0x0              ; push 0
             call [ExitProcess]    ; call ExitProcess()


section '.data' code readable writeable
        msgHelloWorld   db 'hello world!', 0xA, 0x0 ; define "hello world!" + "\n" + "\0"
        cmdPause        db 'pause', 0               ; define "pause" + "\0"

section '.idata' import data readable writeable
        ; import library
        library kernel32, 'kernel32.dll', \
                msvcrt, 'msvcrt.dll'


        ; import functions
        import kernel32, \
               ExitProcess, 'ExitProcess'

        import msvcrt, \
               printf, 'printf', \
               system, 'system'