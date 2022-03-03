INCLUDE Irvine32.inc

.data
enter_msg  BYTE "The Fibonacci Sequence for the first 40 members is as follows:  ",0
answer     BYTE "Fibonacci number ",0
list1	   DWORD 42 dup(?)
Listsize = ($ - list1)/4
equals	   BYTE " = ",0
numCount   DWORD 0

.code
main PROC

call Clrscr
mov edx, offset enter_msg
call WriteString
mov eax, Listsize
sub eax, 3
mov ecx, eax

mov eax,0 ; x = 0
mov ebx,1 ; y = 1
mov esi, offset list1
mov[esi], eax
add esi,4
mov [esi],ebx
add esi,4
fb:
	add eax, ebx ; x +y
	mov edx, eax ; tmp = x + y
	mov [esi], eax
	mov eax, ebx ; x = y
	mov ebx, edx ; y = tmp
	add esi, 4 ;it is dword so need 4 memory storage per number
loop fb

call crlf
call crlf

mov eax, Listsize
sub eax, 1
mov ecx, eax
mov esi, offset list1
mov eax, 0

loop2:
	mov edx, offset answer
	call writestring
	mov eax, numCount
	call writeDec
	mov edx, offset equals
	call writeString
	mov eax, [esi]
	call WriteDec
	add esi, 4
	inc numCount
	call crlf
loop loop2


call crlf
call WaitMsg
exit

main ENDP
END main