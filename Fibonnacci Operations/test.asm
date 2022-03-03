INCLUDE Irvine32.inc

.data
myBytes BYTE 80h, 66h, 0A5h, 0

.code
main PROC

mov al, myBytes
add al, [myBytes + 1]
add al, [myBytes + 2]

call WriteHex
call crlf


main ENDP
END main