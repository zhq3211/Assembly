
assume cs:code

;data segment
;db 'zhq3211 warning...Overflow error!'
;data ends

code segment
	;Your program

	;test- int0
	
	
	
 
;	;Test-显示
;	;IntHandler: 	
;	;jmp short IntHandlerStart
;	;db 'zhq3211 warning...Overflow error!'
;	
;;IntHandlerStart:
;	;字符串-首地址
;	;mov ax, cs	;mov ax, code
;	mov ax, data
;	mov ds, ax
;	mov si, 0;200h+2h	;设置 ds:si 指向字符串. "jmp short"占2byte, 所以字符串偏移地址为 (200+2)h
;	
;	;显存缓冲区-首地址设置
;	mov ax, 0B800h
;	mov es, ax
;	mov di, 10*160+20*2	;设置 es:di 指向显存空间的第10行第20列
;	
;	;将字符串放入显存缓冲区
;	mov cx, 33	;字符串长度
;S:	mov al, ds:[si]
;	mov es:[di], al
;	mov ah, 17h
;	mov es:[di+1], ah 	;颜色属性-蓝底白字
;	add di, 2
;	inc si
;	Loop S

	
;	;Test
;	;- 除法溢出
;	;mov ax, 100
;	;mov bh, 10
;	;div bh		;OK
;		
;	mov ax, 1000
;	mov bh, 1
;	div bh		;al=1000/1>256, 溢出. hang机(Debug 时，溢出中断向量表放置的 CS:IP=F000:1060, 执行后面的指令(中断处理程序)，发现一直在跑循环，因此hang)
	
	
	
;	;Test
;	;- 显存缓冲区测试>>> 
;	;  修改第1行第0、1个字符 (N*80*2+M*2)
;	;   >>> 但是，不cls,会显示在第0行？ cls后执行，才显示在第1行！
;	mov ax, 0B800h
;	mov ds, ax
;	
;	mov si, 0A0h	;第1行0列
;	mov ax, 30h
;	mov ds:[si], ax	;ASCII=0 //debug -a 中报错！需 mov [si], ax
;	
;	inc si
;	mov ax, 17h
;	mov ds:[si], ax ;属性 
;	
;	;
;	mov si, 0A2h	;第1行1列
;	mov ax, 31h
;	mov [si], ax	;ASCII=1 
;	
;	inc si
;	mov ax, 17h
;	mov ds:[si], ax ;属性 
;	;<<<
	
	
	
;	;Test
;	;- 赋值必须以数字开头;
;	;- 溢出(ah值不受影响，仅影响标志位)
;	MOV ax, 0
;	mov al, 0F0H
;	mov bl, 28H
;	add al, bl	;ah 是否进位
	
	
	
;	;Test - 汇编程序与Debug.exe 编程区别
;	;- 汇编程序中偏移地址，不能单独写常量
;	mov ax, 0FFFFH
;	mov bx, 0FFFFH
;	mov ds, ax
;	mov al, [0]		;相当于 debug- mov al, 0
;	mov bl, ds:[0]	;相当于 Debug- mov bl, [0]
;	mov bx, ds:[0]
;	
;	mov bx, 0
;	mov al, [bx]	;相当于 debug- mov al, [0]

	
	
	mov ax,4c00H
	INT 21H
code ends

end


