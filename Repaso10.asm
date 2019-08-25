;Buscar en una cadena de numeros leidas desde un archivo
%macro imprimir 2
	mov eax,4
	mov ebx,1
	mov ecx,%1
	mov edx,%2
	int 80h
%endmacro

section .data
	
	mensaje db "Ingrese el numero a buscar:  "
	len_mensaje equ $-mensaje
	
	resultado db "El numero se repite n veces "
	len_r equ $-resultado
	
	espacio db 10
	len_espacio equ $-espacio

	contador db '0'
	
	archivo db "/home/victor/Documentos/numeros.txt", 0

section .bss
	texto resb 10
	numero resb 1
	idarchivo resb 1 
	

section .text
	global _start
	
	
_start:

	mov al, '0'
	mov [contador], al
	
	mov eax, 5
	mov ebx, archivo
	mov ecx, 0
	mov edx, 0
	int 80h
		
	test eax,eax
	jz salir	
	
	mov dword[idarchivo], eax
	
	mov eax, 3
	mov ebx, [idarchivo]
	mov ecx, texto
	mov edx, 10
	int 80h
	
	mov eax, 6
	mov ebx, [idarchivo]
	mov ecx, 0
	mov edx, 0 
	int 80h
	
	imprimir mensaje, len_mensaje

	mov eax,3
	mov ebx,2
	mov ecx,numero
	mov edx,1
	int 80h
	
	imprimir espacio, len_espacio
	
	mov esi, 0
	
	ciclo_comparar:
		cmp esi, 9
		jz imprimirR
		
		mov al, [texto + esi]
		mov bl, [numero]
		cmp al, bl
		jz igual
		
		inc esi
		jmp ciclo_comparar
	
	igual: 
		mov al, [contador]
		inc al
		mov [contador], al
		inc esi
		jmp ciclo_comparar
	
	imprimirR: 
		mov al, [contador]
		mov [resultado + 20], al
		imprimir resultado, len_r
		
	
	salir: 	
		imprimir espacio, len_espacio
		mov eax,1
		mov ebx,0
		int 80h
