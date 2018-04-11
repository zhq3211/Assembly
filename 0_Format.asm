
assume cs:code

code segment
	;Your program
	mov ax, 0123H
	mov bx, 4567H
	add ax,bx

	mov ax,4c00H
	INT 21H
code ends

end


