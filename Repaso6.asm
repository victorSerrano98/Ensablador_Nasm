;minusculas a Mayusculay viceversa
%macro imprimir 2
	mov eax,4
	mov ebx,1
	mov ecx,%1
	mov edx,%2
	int 80h
%endmacro

section .data
	
	mensaje db "Texto original:  "
	len_mensaje equ $-mensaje
	
	resultado db "Resultado: "
	len_r equ $-resultado
	
	espacio db 10
	len_espacio equ $-espacio

	contador db '0'
	
	archivo db "/home/victor/Documentos/texto.txt", 0

section .bss
	texto resb 25
	textoR resb 25
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
	mov edx, 25
	int 80h
	
	mov eax, 6
	mov ebx, [idarchivo]
	mov ecx, 0
	mov edx, 0 
	int 80h
	
	mov esi, 0
	
	comparar:
		cmp esi, 25
		jz imprimirR
		
		mov al, [texto + esi]
		cmp al, 96
		jc Mayuscula
		sub al, 32
		mov [textoR + esi], al
		inc esi
		jmp comparar
		
	Mayuscula:
		cmp al, 64
		jc espacioT
		add al, 32
		mov [textoR + esi], al
		inc esi
		jmp comparar
	
	espacioT:
		inc esi
		jmp comparar
	
	imprimirR:
		imprimir mensaje, len_mensaje
		imprimir texto, 25
		imprimir resultado, len_r
		imprimir textoR, 25
		imprimir espacio, len_espacio
	
salir:
	mov eax, 1
	mov ebx, 0
	int 80h
