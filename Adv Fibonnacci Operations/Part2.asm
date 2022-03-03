INCLUDE Irvine32.inc


.data
inputMsg  BYTE "The array is as follows: ",0
inputMsg1 BYTE " Array List ", 0
inputMsg2 BYTE " location ", 0
inputMsg3 BYTE " = ", 0
inputMsg4 BYTE " Which location do you wish to change: ",0

 

sortedArray BYTE 2,5,9,11,23,41,57,68,71,82,85

.code
main PROC

call Clrscr           ;clear the screen
 
mov edx, OFFSET inputMsg
call WriteString
call crlf

mov edx, OFFSET inputMsg1
call WriteString
call crlf

;create a loop to list the elements
mov ecx, LENGTHOF sortedArray
mov esi, 0

;loop to print out the elements in the array
L1:
        mov edx, OFFSET inputMsg2
        call WriteString
        mov eax, esi
        call WriteDec

        mov edx, OFFSET inputMsg3
        call WriteString
        mov al, sortedArray[esi]
        call WriteDec
        add esi, 1

        call crlf
loop L1

 

;ask user for input for array location change           
mov edx, OFFSET inputMsg4
call WriteString
call ReadDec
mov esi, eax
call crlf

mov ecx, LENGTHOF sortedArray
sub ecx, esi ; initialize no of times array will run


;initialize index to the last 2 values of the array
mov edi, LENGTHOF sortedArray
mov esi, LENGTHOF sortedArray


;mov al, sortedArray[edi]
mov sortedArray[esi], 0
initialize:
      
      dec esi
      dec edi
loop initialize


;print new array list        
mov edx, OFFSET inputMsg1
call WriteString
call crlf

;moves zero to specific user input location and prevents infinite looping
mov ecx, LENGTHOF sortedArray
mov esi, 0

;loop to shift array
L2:
        mov edx, OFFSET inputMsg2
        call WriteString
        mov eax, esi
        call WriteDec

        mov edx, OFFSET inputMsg3
        call WriteString
        mov al, sortedArray[esi]
		mov sortedArray[edi], al
        call WriteDec

        inc esi
        call crlf

loop L2

call Waitmsg
exit

main ENDP
END main