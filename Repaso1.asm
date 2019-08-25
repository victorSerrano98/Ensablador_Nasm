; Multiplicacion con sumas sucesivas
section .data	
	msj1 db "Ingrese el numero 1: "
	len_1 equ $-msj1
	
	msj2 db "Ingrese el numero 2: "
	len_2 equ $-msj2
	
	resultado db "EL resultado es: "
	len_r equ $-resultado
	
	espacio db 10
	len_espacio equ $-espacio
	
section .bss
	numero1 resb 1
	numero2 resb 1
	aux resb 2
	contador resb 1
	
section .text
		global _start
_start:
	mov al, '0'
	mov [contador], al
	
	mov eax,4
	mov ebx,1
	mov ecx,msj1
	mov edx,len_1
	int 80h
	
	mov eax,3
	mov ebx,2
	mov ecx,numero1
	mov edx,2
	int 80h

	
	mov eax,4
	mov ebx,1
	mov ecx,msj2
	mov edx,len_2
	int 80h
	
	mov eax,3
	mov ebx,2
	mov ecx,numero2
	mov edx,1
	int 80h
	
	mov al, '0'
	mov [aux], al
	
	suma: 
		mov al, [numero1]
		sub al, '0'
		mov bl, [aux]
		sub bl, '0'
		add al, bl
		add al, '0'
		mov [aux], al
		
		mov bl, [numero2]
		mov cl, [contador]
		inc cl
		mov [contador], cl
		cmp cl, bl
		jc suma
		jmp Presentar
		
		
	Presentar: 
		mov ax, 00
		mov al, [aux]
		sub al, '0'
		mov cl, 10
		div cl
		add ax, '00'
		mov [aux], ax
		
		mov eax,4
		mov ebx,1
		mov ecx,resultado
		mov edx,len_r
		int 80h
		
		mov eax,4
		mov ebx,1
		mov ecx,aux
		mov edx,2
		int 80h
		
		mov eax,4
		mov ebx,1
		mov ecx,espacio
		mov edx,len_espacio
		int 80h
		

		
	mov eax, 1
	mov ebx, 0
	int 80h
