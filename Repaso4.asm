; Verificar si un numero es primo (0-9)
%macro imprimir 2
	mov eax, 4
	mov ebx, 1
	mov ecx, %1
	mov edx, %2
	int 80h
%endmacro
section .data
	num db "Ingrese el numero: "
	leng1 equ $-num
	msj1 db "Es primo"
	leng2 equ $-msj1
	msj2 db "No es primo"
	leng3 equ $-msj2
	
	espacio db 10
	len_espacio equ $-espacio
section .bss
	n resb 1
	d resb 1
	aux resb 1
section .text
	global _start
_start:
	 
	mov al, 2
	mov [d], al
	
	imprimir num, leng1

	mov eax,3
	mov ebx,2			
	mov ecx, n
	mov edx, 1
	int 80h

	mov al,[n]
	sub al, '0'
	cmp al,4
	jc primo
	jmp bucle
	
	bucle:
		mov ah, 0
		mov al,[n]
		sub al, '0'
		
		mov cl, [d]
		
		div cl
		cmp ah, 0
		jz Noprimo
		
		
		mov cl, [d]
		
		mov al,[n]
		sub al, '0'
		dec al
		inc cl
		mov [d], cl
		cmp cl, al
		jz primo
		
		jmp bucle
		
	primo:
		imprimir msj1, leng2
		imprimir espacio, len_espacio
		jmp salir
		
	Noprimo:
		imprimir msj2, leng3
		imprimir espacio, len_espacio
		jmp salir
			
		
	salir:
		mov eax,1
		mov ebx,0
		int 80h
