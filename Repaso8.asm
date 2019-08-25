; Eliminar un archivo del disco
%macro escribir 2
	mov eax,4
	mov ebx,1
	mov ecx,%1
	mov edx,%2
	int 80h
%endmacro
SECTION .data
	filename db "/home/victor/Documentos/archivo.txt", 0
	mensaje db "Se ha eliminado el documento",10
	len_mensaje equ $-mensaje
SECTION .text
global  _start
 
_start:

	escribir mensaje, len_mensaje
    mov     ebx, filename
    mov     eax, 10    
    int     80h         
 
    mov eax,1
	mov ebx,0
	int 80h
