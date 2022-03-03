INCLUDE Irvine32.inc

.data
List DWORD 0,1,3,6 dup (?)
Message BYTE "Fibonnaci Number",0
equals BYTE " = ", 0

.code

main PROC 

mov ECX, 40
sub ECX, 2

mov EDX, 1
mov EBX, 1
