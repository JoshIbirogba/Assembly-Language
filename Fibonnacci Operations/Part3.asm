INCLUDE Irvine32.inc

.data

.code
main PROC


mov dl, 0
mov dh, 10

L1:
call drawRight
call drawLeft
jmp L1

exit
main ENDP 

drawRight PROC
mov ecx, 79
loopChar:
	call Gotoxy 
	mov al, 2                 ;draw the black smiley face
	call WriteChar
	call Gotoxy
	mov eax, 50                ;delay time
	call delay 
	mov al, 32
	call WriteChar
	call delay 
	inc dl
	loop loopChar
ret
drawRight ENDP
	

drawLeft PROC
mov ecx, 79
loopCharA:
	call Gotoxy 
	mov al, 2                 ;draw the black smiley face
	call WriteChar
	call Gotoxy
	mov eax, 50             ;delay
	call delay 
	mov al, 32
	call WriteChar
	call delay 
	dec dl
	loop loopCharA
ret
drawLeft ENDP

END main