INCLUDE Irvine32.inc

.data
inputMsg BYTE "Which Fibonacci number do you wish : ",0
outputMsg BYTE "Fibonacci value = ",0

.code
main PROC

mov edx, OFFSET inputMsg
call WriteString
call ReadDec

call crlf

mov ECX, EAX
sub ecx, 2

mov edx, 1
mov ebx, 1


L1:
    mov eax, edx
    add eax, ebx
    mov edx, ebx
    mov ebx, eax
        
loop L1

mov edx, OFFSET outputMsg
call WriteString
call WriteDec

call crlf
call crlf

call WaitMsg
call clrscr
exit

main ENDP
END main

