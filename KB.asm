
assume cs:code

code segment
	;Your program
start: mov ax, 0B800h
	mov es, ax
	mov ah, 'a'
	
s:	mov es:[160*12+40*2], ah
	inc ah
	cmp ah, 'z'
	;nop
	jna s

	mov ax,4c00H
	INT 21H
code ends

end
