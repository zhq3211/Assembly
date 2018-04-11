; 利用 Loop 循环， 计算 2^12

assume cs:codesg 

codesg segment
	;Your program
	mov ax,2

	mov cx,11
C:	add ax,ax
	loop C

	mov ax,4c00H
	INT 21H
codesg ends

end


