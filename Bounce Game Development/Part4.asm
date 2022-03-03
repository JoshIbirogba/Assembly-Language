INCLUDE Irvine32.inc
INCLUDE Macros.inc

.data
col   BYTE 50
row   BYTE 0
Smile BYTE 1,0
blank BYTE 255,0
count BYTE 0
block BYTE 219,0
locL  BYTE 0
locR  BYTE 0
numBounce  BYTE 0
score_msg  BYTE " Number of Bounces : ",0
energy 	   BYTE 50
energy_msg BYTE " Points bank: ",0

r BYTE 21
winsize = 159
delaytime = 50
A_ASCII = 65
L_ASCII = 76
Esc_ASCII = 01Bh


.code

main proc
mov locR, winSize
call clrscr
mov dh, row
mov edx, offset score_msg
call writeString
mov dl, 21
movzx eax, numBounce
call gotoXY
call writeDec


mov dh, 1
mov dl, 0
call gotoXY
mov edx, offset energy_msg
call writeString

add r, 0
mov dl, r
mov dh, 1
call gotoXY
movsx eax, energy
call writeDec

mov ecx, winsize
add row, 2
	
loop1:			     ;loop from left to right
	mov ecx, winsize ;instruction to make it infinite
	call smileL2R
	call readkey
	cmp dx, A_ASCII
	je blkR
	cmp dx, L_ASCII
	je blkL
	cmp dx, Esc_ASCII
	je EXT
	Cont: 					;left to right
		mov eax, delaytime
		call delay
		mov dl, col
		mov dh, row
		add col, 1
		mov bl, locR
		sub bl,1
		cmp col, bl
		je EXT
		cmp col, winsize
		je EXT
		cmp energy, 0
		jle EXT
loop loop1

call clrscr
mov ecx, winsize
loop2:						;right to left
	mov ecx, winsize
	call SmileR2L
	
	call readkey
	cmp dx, A_ASCII
	je blkR
	cmp dx, L_ASCII
	je blkL
	cmp dx, Esc_ASCII
	je EXT
	Cont2:					;right to left
		mov eax, delaytime
		call delay
		
		mov dl, col
		mov dh, row
		
		sub col, 1
		mov bl, locL
		;sub bl, 1
		cmp col, bl
		je EXT
		cmp col, 0
		je EXT
		cmp energy, 0
		jle EXT
Loop loop2

blkL:
	cmp numBounce,1
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
		mov dh, 2
		mov locR, dl
		call gotoXY
		mov edx, offset block
		call writeString	
		
		mov dh, 0
		mov dl, 21
		call bouncePrint
		jmp Cont2
	
EraseL:
	mov dl, locL
	mov dh, 2
	call gotoXY
	mov edx, offset blank
	call writeString
	mov bl, col
	sub bl, locL
	sub energy, bl
	jmp ContL
	
EraseR:
	mov dl, locR
	mov dh, 2
	call gotoXY
	mov edx, offset blank
	call writeString
	mov bl, locR
	sub bl, col
	sub energy, bl
	jmp ContR
	
call ClrScr
EXT:
exit

main ENDP

;//Bounce Print
bouncePrint PROC
	call gotoXY
	movzx eax, numBounce
	call writeDec
	add dh, 1
	call gotoXY
	movzx eax, energy
	call writeDec
RET
bouncePrint ENDP

;//SmileL2R
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

;//SmileR2L		
SmileR2L PROC
	mov dl, col
	mov dh, row
	call gotoXY
	mov edx, offset blank
	call WriteString
	mov edx, offset Smile
	call WriteString
	mov edx, offset blank
	call WriteString
RET
SmileR2L ENDP
END main