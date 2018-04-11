;=====================================
;	call 检测点10.5 《汇编语言》 P195
;=====================================

assume cs:code

stack segment
	dw 8 dup (0)
stack ends

code segment
Start: mov ax, stack
	mov ss, ax
	mov sp, 16
	
	mov ds, ax
	mov ax, 0
	
	call word ptr ds:[0EH]
	
	inc ax
	inc ax
	inc ax

	mov ax,4c00H
	INT 21H
code ends

end start

