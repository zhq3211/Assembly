;============================
;[功能] RGB test
;	第一页，显示蓝底白字的 'A'
;============================

assume cs: code
code segment
	mov ax, 0B800H
	mov ds, ax

	mov cx, 2000	;80x25, 第一页全屏属性字节为2000bytes，循环
	;mov cx, 1000	;蓝色清半屏
	;mov cx, 8000h	;蓝色清屏
	;mov cx, 2000
	
	mov bx, 0
	mov ax, 00010111b  ;0001_0111b=17h, 蓝底白字
	mov dx, 'A'	;'A'=41h
S:	mov ds:[bx], dx
	mov ds:[bx+1], ax	; 将显存缓冲区的字属性设置为“蓝底白字(17h)”
	add bx, 2
	loop S
		
	mov ax,4c00h
	int 21h
code ends
end 