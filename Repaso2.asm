; Divicion con restas sucesivas 
section .data	
	msj1 db "Ingrese el dividendo: "
	len_1 equ $-msj1
	
	msj2 db "Ingrese el divisor: "
	len_2 equ $-msj2
	
	resultado db "EL resultado es: "
	len_r equ $-resultado
	
	residuo db "EL residuo es: "
	len_residuo equ $-residuo
	
	espacio db 10
	len_espacio equ $-espacio
	
section .bss
	numero1 resb 1
	numero2 resb 1
	contador resb 1
	
section .text
		global _start
_start:
	mov al, 0
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
	
	
	resta: 
		mov cl, [contador]
		inc cl
		mov [contador], cl
		mov al, [numero1]
		sub al, '0'
		mov bl, [numero2]
		sub bl, '0'
		sub al, bl
		add al, '0'
		mov [numero1], al
		sub al, '0'
		cmp al, bl
		jc Presentar
		jmp resta
		
		
	Presentar: 
		mov cl, [contador]
		add cl, '0'
		mov [contador], cl
		
		mov eax,4
		mov ebx,1
		mov ecx,resultado
		mov edx,len_r
		int 80h
		
		mov eax,4
		mov ebx,1
		mov ecx,contador
		mov edx,1
		int 80h
		
		mov eax,4
		mov ebx,1
		mov ecx,espacio
		mov edx,len_espacio
		int 80h
		
		mov eax,4
		mov ebx,1
		mov ecx,residuo
		mov edx,len_residuo
		int 80h
		
		mov eax,4
		mov ebx,1
		mov ecx,numero1
		mov edx,1
		int 80h
		
		mov eax,4
		mov ebx,1
		mov ecx,espacio
		mov edx,len_espacio
		int 80h
		
	mov eax, 1
	mov ebx, 0
	int 80h
