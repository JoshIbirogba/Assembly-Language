INCLUDE Irvine32.inc

.data
inputMsg  BYTE "The Fibonacci Sequence for the first 40 members is as follows:  ", 0
answerMsg     BYTE "Fibonacci number ", 0
list	   DWORD 40 dup(?)
Listsize = ($ - list)/4  ;;calculate the size of doubleWord array
equals	   BYTE " = ", 0
numCount   DWORD 0

.code
main PROC

call Clrscr

mov edx, offset inputMsg
call WriteString
mov eax, Listsize
sub eax, 3
mov ecx, eax

;assign location for doubleword values
mov eax, 0 ; x = 0
mov ebx, 1 ; y = 1

;mov esi, offset list
;mov Dword Ptr[esi], 0
;add esi, 4
;mov Dword Ptr[esi], 1
;add esi, 4


mov esi, 0
mov List[esi], 0
add esi, 4
mov List[esi], 1
add esi, 4

; //Fibonacci Operation
fib:
	add eax, ebx ; x + y
	mov edx, eax ; tmp = x + y
	mov List[esi], eax
	mov eax, ebx ; x = y
	mov ebx, edx ; y = tmp
	add esi, 4 ; it is a doubleWord so it needs 4 memory spaaces per number
loop fib

call crlf

mov eax, Listsize
sub eax, 1
mov ecx, eax
mov esi, offset list
mov eax, 0

;//Load and print the fibonacci numbers
L1:
	mov edx, offset answerMsg
	call WriteString
	mov eax, numCount
	call writeDec
	mov edx, offset equals
	call writeString
	mov eax, [esi]
	call WriteDec
	add esi, 4
	inc numCount
	call crlf
loop L1


call crlf
call WaitMsg
exit

main ENDP
END main






 


