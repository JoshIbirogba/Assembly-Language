INCLUDE Irvine32.inc

.data
esitmp 	 DWORD 0
Intro    BYTE "The array is as follows:",0
loc_msg  BYTE "location ",0
arr		 BYTE "array",0
equals   BYTE " = ",0
count	 DWORD 0
loc_ptr  DWORD ?   ;to get the location from the user to make changes
value    BYTE 0
tmp		 BYTE 0
sorted   BYTE 88, 2, 9, 11, 77, 41, 68, 57, 71, 85, 89

listsize = (lengthof sorted)
.code
main PROC
call clrscr
mov edx, offset Intro
call WriteString
call crlf
call crlf

mov edx, offset arr
call WriteString
call crlf

call print ; procedure to print all the elements of the array
call crlf

call Sort


call crlf

mov count,0

call print
 

exit
main ENDP


;printing the elements of arrays
print PROC

call crlf
mov esi,0
;mov eax, listsize

mov ecx, listsize
L1:

mov edx, offset loc_msg
call writeString

mov eax, count
call writeDec

mov edx, offset equals
call writeString
inc count ;count++

movsx eax, sorted[esi]
call writeDec
inc esi

call crlf
loop L1
RET
print ENDP

;sort
Sort PROC
	mov esi, 0
	mov ecx, (listsize)
	
comp:
	add esi, 1
	
	mov esitmp, esi
	mov ecx, esi
	mov esi, 1
intLoop:
			mov al, sorted[esi]
			mov dl, sorted[esi - 1]
			cmp al, dl
			jle swap
			inc esi
		contComp:
loop intLoop
		mov esi, esitmp
	
	;mov ecx, loc_ptr
	mov eax, ecx
	call w
	loop comp
	jmp sortRET
	
	swap:
		mov bl, sorted[esi - 1]
		mov tmp , bl
		
		mov bl, sorted[esi];2
		
		mov sorted[esi - 1], bl ; sorted[j] =  sorted[i] 
		mov bl, tmp
		mov sorted[esi], bl ; sorted[i] = tmp
		jmp contComp

sortRET:
RET
Sort ENDP

END main
