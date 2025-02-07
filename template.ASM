format PE console    ; define PE file format

include 'win32a.inc' ; include set of macros and definitions


entry start          ; define the entry point

section '.text' code readable executable
        start:       ; entry
             push cmdPause
             call [system]
             add esp, 0x4

             push 0x0
             call [ExitProcess]


section '.data' code readable writeable
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