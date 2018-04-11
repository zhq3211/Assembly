;计算 FFFF:0~FFFF:B 单元中的数据的和，并存放到 dx 中.

assume cs:code

code segment
	
	;Your program
	mov ax, 0FFFFH
	mov ds, ax
	mov bx, 0	; ds:bx 指向 FFFF:[0]
	
	mov dx, 0 	;初始化累加寄存器
	
	mov cx, 12 ;loop 循环12次
	
S:	MOV al, ds:[bx]
	mov ah, 0
	add dx, ax
	inc bx
	loop S
	
	mov ax,4c00H
	INT 21H
code ends

end
