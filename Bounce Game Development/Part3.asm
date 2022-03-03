INCLUDE Irvine32.inc
INCLUDE Macros.inc

.data
col   BYTE 50
row   BYTE 0
Smile BYTE 2 ,0
blank BYTE 255 ,0
count BYTE 0
block BYTE 219 ,0
locL  BYTE 0
locR  BYTE 0
numBounce BYTE 0
score_msg BYTE " Number of Bounces : ",0

winsize = 80
delaytime = 50
A_ASCII = 65
L_ASCII = 76
Sp_ASCII = 32

.code

main proc
mov locR, winSize
call clrscr
mov dh,row
mov edx, offset score_msg
call writeString
mov ecx, winsize
add row, 1

	
loop1:	
	mov ecx, winsize ;make it infinite
	call smileL2R
	call readkey
	cmp dx, A_ASCII
	je blkR
	cmp dx, L_ASCII
	je blkL
	;cmp dx, Sp_ASCII
	
	Cont: 					;left to right
		mov eax, delaytime
		call delay
		mov dl, col
		mov dh, row
		add col, 1
		mov bl, locR
		sub bl, 1
		cmp col, bl
		je EXT
		cmp col, winsize
		je EXT
loop loop1
call clrscr

mov ecx, winsize

loop2:
	mov ecx, winsize
	call SmileR2L	
	call readkey
	cmp dx, A_ASCII
	je blkR
	cmp dx, L_ASCII
	je blkL
	cmp dx, Sp_ASCII
	je EXT
	
	
	Cont2:					;right to left
		mov eax, delaytime
		call delay
		
		mov dl, col
		mov dh, row
		
		sub col, 1
		mov bl, locL
		cmp col, bl
		je EXT
		cmp col, 0
		je EXT
		
Loop loop2

blkL:
	cmp numBounce,0
	jne EraseL
	
	ContL:
		inc numBounce
		
		mov dl, col
		mov dh, row
		mov locL, dl
		call gotoXY
		mov edx, offset block
		call writeString
		
		mov dh, 0
		mov dl, 21
		call bouncePrint
		
		jmp Cont
	
blkR:
	cmp numBounce, 0
	jne EraseR
	
	ContR:
		inc numBounce
		mov dl, col
		add dl, 2
		mov dh, 1
		mov locR, dl
		call gotoXY
		mov edx, offset block
		call writeString	
		
		mov dh, 0
		mov dl, 21
		call bouncePrint
		jmp Cont2
	
EraseL:
	mov al, col
	mov dl, locL
	add dh, 1
	call gotoXY
	mov edx, offset blank
	call writeString
	mov col, al
	jmp ContL
	
EraseR:
	mov al, col
	mov dl, locR
	add dh, 1
	call gotoXY
	mov edx, offset blank
	call writeString
	mov col, al
	jmp ContR
	
call ClrScr
EXT:
exit

main ENDP

;bounce print
bouncePrint PROC
	call gotoXY
	movzx eax, numBounce
	call writeDec
RET
bouncePrint ENDP

;SmileL2R
SmileL2R PROC
	mov dl, col
	mov dh, row
	call gotoXY	
	mov edx, offset blank
	call WriteString
	mov edx, offset Smile
	call WriteString	
RET	
SmileL2R ENDP

;SmileR2L
SmileR2L PROC
	mov dl, col
	mov dh, row
	call gotoXY
	mov edx, offset blank
	call WriteString
	mov edx, offset Smile
	call WriteString
RET
SmileR2L ENDP

END main