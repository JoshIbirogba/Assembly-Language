 INCLUDE Irvine32.inc
 
 .data
inputOne  BYTE "Enter the value for x : " , 0
inputTwo  BYTE "Enter the value for y : " , 0
outputOne BYTE "X = " , 0
outputTwo BYTE "Y = " , 0
hexA      BYTE "Hex X     = " , 0
hexB      BYTE "Hex Y     = " , 0
x         DWORD ?
y         DWORD ?
BinX      BYTE "Binary X   = " , 0
BinY      BYTE "Binary Y   = " , 0



.code
main PROC

call clrscr                               ;clears screen

mov edx, OFFSET inputOne                  ;print the prompt
call WriteString

call ReadInt                              ;reads an integer value from the keyboard/user
mov x,eax ; store good value

mov edx, OFFSET inputTwo                  ;print the prompt
call WriteString

call ReadInt                              ;reads an integer value from the keyboard/user
mov y,eax ; store good value

call crlf

mov edx, OFFSET outputOne           ;prints the value of x
call WriteString
mov eax, x
call WriteDec
call crlf

mov edx, OFFSET outputTwo                ;prints the value of y
call WriteString
mov eax, y
call WriteDec
call crlf
call crlf


mov edx, OFFSET hexA           ;prints the value of  hex x
call WriteString
mov eax, x
call WriteHex
call crlf

mov edx, OFFSET hexB           ;prints the value of  hex y
call WriteString
mov eax, y
call WriteHex
call crlf
call crlf


mov edx, OFFSET BinX           ;prints the value of  Binary X 
call WriteString
mov eax, x
call WriteBin
call crlf


mov edx, OFFSET BinY           ;prints the value of  Binary Y
call WriteString
mov eax, y
call WriteBin
call crlf


call WaitMsg                             ;keeps console up/active
call clrscr
exit

main ENDP
END main