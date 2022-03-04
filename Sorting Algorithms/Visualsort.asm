INCLUDE Irvine32.inc

.data
array Dword 8,2,7,4,3,5,4,2,9,3,2

.code
    mov ebx, OFFSET array
    mov ecx, 5
    mov edx, ecx
	
    L1:      
       mov esi, 0
       mov eax, esi
       inc eax
       mov edi, eax
       mov edx, ecx
	   Loop L1
	   
    L2:
       mov eax, [ebx][esi]
       cmp eax, [ebx][edi]
       jg L4
	Loop L2
	   
    L3:
       inc esi
       inc edi
       dec edx
       cmp edx, 0
       je L1
       jg L2
	Loop L3
	
    L4:
       mov al, [ebx][esi]
       mov ah, [ebx][edi]
       mov [ebx][esi], ah
       mov [ebx][edi], al
       inc esi
       inc edi       
       dec edx
       cmp edx, 0
       je L1
       jg L2
	Loop L4
	
main ENDP
END main
