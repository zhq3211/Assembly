
;向 200H~23FH 分别写入数据 0~3Fh
;一般，200H~2FFh 这256bytes 是没有程式在使用的,数据都是0.

assume cs:code

code segment

	;Your program
	mov ax, 20h
	mov ds, ax   ;ds:[.] = 20:bx
	mov bx, 0    ;ds:[bx] = 20:bx = 200+bx

	mov cx, 40h  ;loop 循环 3Fh+1 次
S:	mov ds:[bx], bx
	inc bx       ; 每次 bx+1
	loop S

	mov ax,4c00H
	INT 21H
code ends

end


