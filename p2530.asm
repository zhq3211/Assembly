
assume cs:code

code segment

start: 	mov ax,3456
		int 7Ch
		add ax,ax
		adc dx,dx
	



;	;Test - 屏幕中间显示
;    start: mov ax, 0b800h
;           mov es, ax
;	        mov byte ptr es:[12*160+40*2], '!'
;    ;int 0     
	 
	mov ax,4c00H
	INT 21H

code ends
end start


