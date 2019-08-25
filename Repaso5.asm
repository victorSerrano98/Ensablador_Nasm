;Contar el numero de caracteres de una cadena
%macro escribir 2
	mov eax,4
	mov ebx,1
	mov ecx,%1
	mov edx,%2
	int 80h
%endmacro
SECTION .data
	msj     db   "   ", 10
	


section .bss
	texto resb 4
	
SECTION .text
global  _start
 
_start:


	mov eax,3
	mov ebx,2
	mov ecx,msj
	mov edx,30
	int 80h
	
    mov     ebx, msj
    mov     eax, ebx
 
bucle:
    cmp     byte [eax], 0
    jz      fin
    inc     eax
    jmp     bucle
 
fin:
    sub     eax, ebx 
    sub eax, 1
    
    mov cl, 10
	div cl
          
    add ax, '00'
    mov [texto], ax
    escribir texto, 2
 
    mov     ebx, 0
    mov     eax, 1
    int     80h
    
