INCLUDE Irvine32.inc

.data
inputX BYTE "Enter the value of x from (0 - 76) : ", 0
inputY BYTE "Enter the value of y from (0 - 25) : ", 0
xvalue BYTE ?
yvalue BYTE ?

.code
main PROC 

call clrscr

mov edx, OFFSET inputX
call WriteString
call ReadDec
mov xvalue, al
call crlf

mov edx, OFFSET inputY 
call WriteString
call ReadDec
mov yvalue, al
call crlf

call clrscr

;top row
mov dl, xvalue     ;column     37
mov dh, yvalue     ;row        11
call Gotoxy
mov al, 201
call WriteChar
mov al, 205
call WriteChar
mov al, 187
call WriteChar


;horizontal and vertical 
add yvalue,1
mov dl, xvalue     ;column    37
mov dh, yvalue     ;row       12 
call Gotoxy
mov al,186
call WriteChar

add xvalue, 2
mov dl, xvalue       ;column    39
mov dh, yvalue       ;row       12 
call Gotoxy
mov al, 186
call WriteChar


;bottom row
add yvalue,1
sub xvalue,2
mov dl, xvalue   ;column   37
mov dh, yvalue   ;row      13
call Gotoxy
mov al, 200
call WriteChar
mov al, 205
call WriteChar
mov al, 188
call WriteChar

main ENDP
end main