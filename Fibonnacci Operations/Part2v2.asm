INCLUDE Irvine32.inc

.data
rNum BYTE ? 
rWidth BYTE ?
rHeight BYTE ? 
tmp Dword ?
col byte 0
row byte 0
hScreenSize = 78 
hWindow = hScreenSize - 3

vScreenSize = 25
vWindow = vScreenSize - 4

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
call randomize
call Clrscr           ;clear the screen

mov ecx, 100
L1:
    mov tmp, ecx
	push ecx
    call computesizes
	call drawTop
	call drawMid
	call drawBottom
	

	mov eax, 100
	call delay 
;	call DumpRegs
;	call WaitMsg
	pop ecx
cmp ecx, 0
jg around 
call horrible

around:
cont:
	loop  L1
	
call Crlf
call Crlf

call waitmsg
exit

main ENDP


; compute start location x,y of top left corner of rectangle
; compute rectangle width and height
computeSizes Proc
	
	mov EAX, hWindow
    call RandomRange 	
	mov col, al

	mov EAX, vWindow 
	inc eax
    call RandomRange 	
	mov row, al
	
;get the width
    mov EAX, 0
	mov al, hWindow
	sub al, col
	call RandomRange
	mov rWidth, al
	add rWidth, 3
   ; call WriteDec
	
;get the height
	mov EAX, 0
	mov al, vWindow
	sub al, row
	call RandomRange
	mov rHeight, al
	add rHeight, 3
		
ret
computeSizes endP
	
	
drawTop PROC 
;print the first line at the top    
	
; loop counter
mov dl, col
mov dh, row
call Gotoxy
mov al, tLeft
call WriteChar
movzx ECX, rWidth
sub ECX, 2
mov al, horizontal
L2:
		
		call writechar
		loop L2
		
	    mov al, tRight
	    call writechar
	
	
	ret
drawTop ENDP
	
drawMid PROC
	; prints the middle of rectangle

    movzx ECX, rHeight
	sub ECX, 2
	
    mov dh, row
	inc dh
L3: 
	mov dl, col
	call Gotoxy 
	mov al, vertical
	call Writechar
	
	push ECX		
		movzx ECX, rWidth
		sub ecx, 2
		mov al, space
		L2:
			mov al, space
			call Writechar
			loop L2 ; end of middleloop
	pop ECX 
	
	mov al, vertical
	call writechar
    inc dh	
	
cmp ecx, 0
jg around 
call horrible

around:
loop L3 
	
ret 
drawMid ENDP
	
	
;code block printing the last line

drawBottom PROC
;print the first line at the top    
;call Gotoxy
	
; loop counter
mov dh, row
add dh, rHeight
sub dh, 1
mov dl, col
call Gotoxy
mov al, bLeft
call WriteChar
movzx ECX, rWidth
sub ECX, 2

cmp ecx, 0
jg around 
call horrible

around:
mov al, horizontal
L2:		
		call writechar
loop L2
		
	    mov al, bRight
	    call writechar	
ret
drawBottom ENDP

horrible Proc
call dumpRegs
call waitmsg
ret
horrible endp
	
END main
