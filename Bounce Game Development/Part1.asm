INCLUDE Irvine32.inc

.data

aList DWORD 0,1,3,12 dup (?)
FibMsg BYTE "Fibonacci number ", 0
Msg BYTE " = " ,0


.code

main PROC

mov ecx, 40
sub ecx, 2

mov edx, 1
mov ebx, 1

mov esi, OFFSET aList

L1:
    mov eax, edx
    add eax, ebx
    mov edx, ebx
    mov ebx, eax
    mov [esi], eax
    add esi,4
    
loop L1

mov ecx, 41
mov esi, OFFSET aList

mov dh, 0
L2:
    mov edx, OFFSET FibMsg
    call WriteString
    mov eax, esi
    call WriteDec
    
    mov edx, OFFSET Msg
    call WriteString
    mov eax, [esi]
    call WriteDec
    call crlf
    add esi, 4
    inc dh
    
loop L2

call Waitmsg
exit

main ENDP
END main