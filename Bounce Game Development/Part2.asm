INCLUDE Irvine32.inc


.data
List BYTE 2,5,9,11,23,41,57,68,71,82,85
locMsg BYTE "location ", 0
equals BYTE " = ",0

Question BYTE "Which location do you wish to change: ",0

ArrayMsg BYTE "The array is as follows:",0
PrintArray BYTE "array",0

currentY BYTE 0
wantLoc BYTE 0

listsize = 11

.code

print PROC

call crlf

;Outputs "array" on a line
mov edx, OFFSET PrintArray
call writestring
call crlf

;Output the elements in the array
mov ecx, listsize
mov esi, OFFSET List
mov edi, 0

myLoop:
    ;Formats how the output is printed
    mov dh, currentY
    mov dl, 0
	call gotoxy
    
    ;First part of string showing the location of each element
    mov edx, OFFSET locMsg
    call Writestring
    
    ;Element number
    mov eax, edi
    call writedec
    
    ;print the string " = "
    mov edx, OFFSET equals
    call writestring
    
    ;Element value
    mov al, [esi]
    call WriteDec
    
    ;For formatting and index + 1
    inc currentY
    inc edi
    inc esi
loop myLoop

;Formats how the message is printed
call crlf
inc currentY

ret
print ENDP

main PROC

;Output "The array is as follows:" on a line
mov edx, OFFSET ArrayMsg
call writestring
call crlf
inc currentY

;Prints out the array using the print procedure
call print
call crlf


;Outputs question and getting desired location from user/keyboard
mov edx, OFFSET Question
call writeString
call readDec

;Only go to requested location
mov edi, eax
mov ecx, listsize
sub ecx, edi

;Traverse the list to get the location to change input value to zero
mov esi, OFFSET List
add esi, 11
dec esi

L1:
    ;Get left value and store
    dec esi
    mov al, [esi]
	
    ;Put stored left value and put in right value
    inc esi
    mov [esi], al
    dec esi
    
loop L1

;Go to requested location and change to 0
inc esi
mov al, 0
mov [esi], al

call print
call waitmsg
exit

main ENDP
END main