;Examen 1 con archivos
; CASO 1: numero 1 + numero 2  = numero 3
; CASO 2: numero 2 + numero 3  = numero 1
; CASO 3: numero 1 + numero 3  = numero 2
%macro escribir 2
	mov eax,4
	mov ebx,1
	mov ecx,%1
	mov edx,%2
	int 80h
%endmacro

%macro abrirArchivo 1
	mov eax, 5 
	mov ebx, %1 
	mov ecx, 0 
	mov edx, 0 
	int 80h
%endmacro

%macro leerArchivo 2
	mov eax, 3  ; servicio 3 lectura
	mov ebx, %1
	mov ecx, %2
	mov edx, 3
	int 80h
%endmacro

%macro cerrarArchivo	1
	mov eax, 6
	mov ebx, %1
	mov ecx, 0
	mov edx, 0 
	int 80h
%endmacro

section .data

	
	resultado1 db "Pertenece al Caso 1 "
	len_r1 equ $-resultado1
	
	resultado2 db  "Pertenece al Caso 2 "
	len_r2 equ $-resultado2
	
	resultado3 db  "Pertenece al Caso 3 "
	len_r3 equ $-resultado3
	
	resultado4 db  "No Pertenece a Ninguno de los casos"
	len_r4 equ $-resultado4
	
	espacio db 10
	len_espacio equ $-espacio
	
	archivo1 db "/home/victor/Documentos/ensamblador/numero1.txt", 0
	archivo2 db "/home/victor/Documentos/ensamblador/numero2.txt", 0
	archivo3 db "/home/victor/Documentos/ensamblador/numero3.txt", 0
	suma db "   "
section .bss
	texto1 resb 1 ;Almacenara el contenido del archivo
	texto2 resb 1
	texto3 resb 1
	idarchivo resb 1 ;El identificador que se obtiene del archivo, es el archivo fisico


section .text
	global _start
	
_start:

	; Numero 1
	abrirArchivo archivo1
	
	test eax,eax
	jz salir	
	mov dword[idarchivo], eax
	
	leerArchivo [idarchivo], texto1
	cerrarArchivo [idarchivo]

	
	; Numero 2
	abrirArchivo archivo2
	
	test eax,eax
	jz salir	
	mov dword[idarchivo], eax
	
	leerArchivo [idarchivo], texto2
	cerrarArchivo [idarchivo]
	
	; Numero 3
	abrirArchivo archivo3
	
	test eax,eax
	jz salir	
	mov dword[idarchivo], eax
	
	leerArchivo [idarchivo], texto3
	cerrarArchivo [idarchivo]
	
	Caso1:
		mov al, [texto1]
		sub al, '0'
		mov bl, [texto2]
		sub bl, '0'
		add al, bl
		mov bl, [texto3]
		sub bl, '0'
		cmp al, bl
		jz ImprimirCaso1
		jmp Caso2
	
	ImprimirCaso1:
		escribir resultado1, len_r1
		jmp salir
	
	Caso2:
		mov al, [texto2]
		sub al, '0'
		mov bl, [texto3]
		sub bl, '0'
		add al, bl
		mov bl, [texto1]
		sub bl, '0'
		cmp al, bl
		jz ImprimirCaso2
		jmp Caso3
	
	ImprimirCaso2:
		escribir resultado2, len_r2
		jmp salir
	
	Caso3:
		mov al, [texto1]
		sub al, '0'
		mov bl, [texto3]
		sub bl, '0'
		add al, bl
		mov bl, [texto2]
		sub bl, '0'
		cmp al, bl
		jz ImprimirCaso3
		jmp Ninguno
	
	ImprimirCaso3:
		escribir resultado3, len_r3
		jmp salir
	
	Ninguno:
		jz escribir resultado4, len_r4
		jmp salir
	
	salir: 
		escribir espacio, len_espacio
		mov eax,1
		mov ebx,0
		int 80h
