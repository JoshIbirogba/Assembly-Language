INCLUDE Irvine32.inc
.data
rNum BYTE ? 
rWidth BYTE ?
rHeight BYTE ? 
hScreenSize = 78 
hWindow = hScreenSize - 3

vScreenSize = 25
vWindow = vScreenSize - 3

;ascii characters
tLeft   = 201
tRight  = 187
bLeft   = 200
bRight  = 188
vertical = 186
horizontal = 205
space = 32

.code
main PROC

call Clrscr           ;clear the screen

mov ecx, 100
L1:
	push ecx
	call drawTop
	call drawMid
	call drawBot 
	pop ecx
	mov eax, 100
	call delay 
	loop  L1
	

call Crlf
call Crlf

call waitmsg
exit

main ENDP
	
drawTop PROC 
;print the first line at the top    
	call RandomRange 

	mov EAX, hWindow	
	mov dl, al
	
;get the width
	mov EBX, hWindow + 1
	sub bl, al
	mov EAX,EBX
	call randomRange
	add EAX, 3
	mov rWidth, al

	mov eax, vWindow
	call RandomRange 
	mov dh, al
	call Gotoxy
	
;get the height
	mov ebx, vWindow + 1
	sub bl, al
	mov eax,ebx
	call randomRange
	add eax,3
	mov rHeight, al
	
	mov al, tLeft
	call writechar
	
	mov cl,rWidth
	sub ecx, 2 

	
; loop counter
L2:
		mov al, horizontal
		call writechar
		loop L2
	    mov al, tRight
	    call writechar
	
	
	ret
	drawTop ENDP
	
drawMid PROC
	; prints the middle of rectangle

    mov cl,rHeight
	sub ECX, 2	
	L3: ; loops the middleloop
		inc dh
		call Gotoxy 
		mov al, vertical
		call Writechar
		push ECX		
		mov cl,rWidth
		sub ecx, 2
		
		L2:
			mov al, space
			call Writechar
			loop L2 ; end of middleloop
	pop ECX 
	
	mov al, vertical
	call writechar	
	loop L3 
	
	ret 
	drawMid ENDP
	
	
;code block printing the last line
drawBot PROC 
	
	inc dh
	call Gotoxy 
	mov al, bLeft
	call writechar
	mov cl,rWidth
	sub ecx, 2
	
	L2:
		mov al, horizontal
		call WriteChar
		loop L2				
		mov al, bRight
		call Writechar		
		
		ret
	drawBot ENDP
	
END main
