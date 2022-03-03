INCLUDE Irvine32.inc

.data

.code
main PROC
mov al, 127
add al,1

call WriteHexB

main ENDP
END main