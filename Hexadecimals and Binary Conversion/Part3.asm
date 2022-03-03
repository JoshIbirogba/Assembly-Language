INCLUDE Irvine32.inc

.data

.code
main PROC 
mov eax, yellow + (blue * 16)
call setTextColor
call clrscr

mov dl, 37   ;column                                         upper row characters
mov dh, 11   ;row
call Gotoxy
mov al,201
call WriteChar
mov al,205
call WriteChar
mov al, 187
call WriteChar



mov dl, 37 ;column
mov dh, 12 ;row
call Gotoxy
mov al, 186
call WriteChar
;
mov dl, 39 ;column
mov dh, 12
call Gotoxy
mov al,186
call WriteChar


;lower row characters
mov dl, 37   ;column
mov dh, 13   ;row
call Gotoxy
mov al,200
call WriteChar
mov al,205 
call WriteChar
mov al,188
call WriteChar



main ENDP
END main
