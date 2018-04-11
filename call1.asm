
assume cs:code

code segment
	;Your program
;======================================
;call word ptr 内存单元地址
;	相当于： push IP (入栈)
;			 jmp word ptr 内存单元地址
;=====================================		
	mov sp, 10h
	mov ax, 0123h
	mov ds:[0], ax
	call word ptr ds:[0]
	
	
;==========================
;call 16位段寄存器
;	相当于： push IP (入栈)
;			 jmp  16位段寄存器
;=========================	
;	mov ax, 6
;	call ax
;	inc ax
;	mov bp, sp
;	add ax, [bp]	;ax=Bh
	
	
;==========================
;call far ptr S
;	相当于： push CS (入栈)
;			 push IP
;			 jmp far ptr S
;=========================
;	mov ax,0
;	call far ptr S
;	inc ax
;	
;S:	pop ax		
;	add ax,ax	;ax=10h
;	pop bx		;bx=CS
;	add ax,bx	;ax = CS+10h
	
	
;===================
;call S
;	相当于：push IP (入栈)
;			jmp  S
;===================
;	mov ax, 1
;	call S
;	inc ax
;S:	pop ax	;ax=6

	mov ax,4c00H
	INT 21H
code ends

end

