INCLUDE Irvine32.inc

.data
inputMsg BYTE " What fibonnaci number do you wish ? = ",0
fib DWORD ?

.code
main PROC
mov EDX, offset inputMsg
call WriteString
call ReadDec
mov fib, AL
call crlf

mov EAX, 1
add EAX, 1

mov ECX, 0
L1:
   mov EBX,
   add EAX, 


main ENDP
END main