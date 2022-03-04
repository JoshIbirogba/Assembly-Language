INCLUDE Irvine32.inc


.data 
EnterMsg BYTE 'Enter n: ',0 ;11
ArrayMsg BYTE ,'Enter the array: ',0  ;12
SortedMsg BYTE ,'The sorted array in descending orde using Bubble sort is: ',0 ;13
n DWORD ?
temp DWORD ?
i DWORD ?
value DWORD 40 dup (?)
array DWORD 40 dup (?)


.code 


BUBBLE PROC 
    mov ax,1
    mov i,ax
        outer_for:
        mov EAX, offset array
        mov dx,n
        for1: mov ax,[si]
        add si,2
        mov bx,[si]
        cmp ax,bx
        jg for3

        for2: mov temp,ax
        mov ax,bx
        mov bx,temp
        mov [si],bx
        sub si,2
        mov [si],ax
        add si,2

        for3: dec dx
        cmp dx,i
        jne for1
        inc i
        mov cx,i
        cmp cx,n
        jne outer_for
        RET
        BUBBLE ENDP


start: mov ax,data
       mov ds,ax

       mov ecx, offset EnterMsg
	   call WriteString
       mov n,ax

       mov esi,array
       mov edx,n
       mov ecx, offset l2
       input_the_array: 
        mov [esi],eax
        add esi,2
        dec edx
        jnz input_the_array
       call BUBBLE

       mov ECX, offset SortedMsg
	   call WriteString
       mov esi,array
       mov edx,n
       output_the_array: 
        add si,2
        dec dx
        jnz output_the_array


   code ends
end start