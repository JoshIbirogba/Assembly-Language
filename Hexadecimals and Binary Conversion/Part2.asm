INCLUDE Irvine32.inc

.data
inputmsg   BYTE "Enter a value for EAX : " , 0
register   DWORD ?
outputEAX  BYTE "  EAX = " ,0
outputAX   BYTE "   AX =     " , 0
outputAL   BYTE "   Al =       " , 0
Bvalue     DWORD ?

.code
main PROC

call clrscr

mov edx, OFFSET inputmsg   ;prints the promppt
call writeString
call readDec
mov register, eax 
call crlf

;
mov edx , OFFSET outputEAX    ;prints the value in the EAX register
call writeString 
mov eax, register
mov ebx, 4
call writeHexB
call crlf


;
mov edx , OFFSET outputAX    ;prints the value in the AX register
call writeString 
mov eax, register
mov ebx, 2
call writeHexB
call crlf

;
mov edx , OFFSET outputAl   ;prints the value in the AL register
call writeString 
mov eax, register
mov ebx, 1
call writeHexB
call crlf

main ENDP
END main