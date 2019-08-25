;Suma de 3 digitos
%macro imprimir 2
	mov eax, 4
	mov ebx, 1
	mov ecx, %1
	mov edx, %2
	int 80h
%endmacro
section .data	
	numero1 db "Escriba el primer numero: "
	len_numero1 equ $-numero1
	
	numero2 db "Escriba el segundo numero: "
	len_numero2 equ $-numero2
	
	resultado db "Suma: "
	len_r equ $-resultado
	
	espacio db 10
	len_espacio equ $-espacio
	
	n1 db "   "
	n2 db "   "
	suma db "   "
	archivo db "/home/victor/Documentos/archivo.txt", 0

section .bss
	texto resb 25
	idarchivo resb 1

section .text
	global _start

_start:
	
	imprimir numero1, len_numero1
	mov eax,3
	mov ebx,2
	mov ecx,n1
	mov edx,4
	int 80h
	imprimir espacio, len_espacio
	imprimir numero2, len_numero2
	mov eax,3
	mov ebx,2
	mov ecx,n2
	mov edx,4
	int 80h
	imprimir espacio, len_espacio
	mov ecx, 3 
	mov esi, 2
	clc 
	
	ciclo_suma:
		mov al, [n1 + esi]
		adc al, [n2 + esi]
		aaa  
		pushf 
		or al, 30h 		
		popf
		
		mov [suma + esi], al
		dec esi
		loop ciclo_suma
	
	
	imprimir resultado, len_r
	imprimir suma, 3
	imprimir espacio, len_espacio
	
	
	mov eax, 8
	mov ebx, archivo
	mov ecx, 1
	mov edx, 200h
	int 80h		
	
	test eax, eax
	jz salir
	
	mov dword[idarchivo], eax
	
	mov eax, 4
	mov ebx, [idarchivo]
	mov ecx, suma
	mov edx, 3
	int 80h
	
	mov eax, 6
	mov ebx, [idarchivo]
	mov ecx, 0
	mov edx, 0 
	int 80h
	
	salir: 	
		mov eax,1
		mov ebx,0
		int 80h
