 INCLUDE Irvine32.inc
 
 .data
inputOne BYTE "Enter the value for x : " , 0
inputTwo BYTE "Enter the value for y : " , 0
intNum DWORD ?
intNum DWORD ?

.code
main PROC

call clrscr                 ;clears screen

read: call ReadInt    ;reads inpuyt integer from keyboard
goodInput:
mov intNum,eax ; store good value

read: call ReadInt
goodInput:
mov intNum,eax ; store good value