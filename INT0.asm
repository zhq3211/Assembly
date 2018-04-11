;=============================================================
;	《汇编语言》 P241 
;
;功能： 当发生除法溢出(0号中断)时，在屏幕中间显示特定字符串(如: "overflow!").
;
;程序逻辑：
;	1. 编写中断处理程序. (如，IntHandler: 显示溢出提示的字符串)
;	2. 确定/定义"中断处理程序"的入口地址 CS:IP. (如，将其放在 CS:IP=0000:0200 处)
;	3. 将"中断处理程序"的入口地址存在中断向量表0号表项中.
;
;中断向量表：
;	1. 8086CPU，Map 在内存的 0000:0000 - 0000:03FFh (1KB) 空间.
;	2. 一般 0200-02FF 空间没有使用.
;
;=============================================================

assume cs:code

code segment
start:
	
	;1. 安装程序(中断处理程序) - IntHandler
	
	;设置 ds:si 指向源地址 (cs:ip)
	mov ax, cs	;mov ax, code？
	mov ds, ax
	mov si, offset IntHandler
	
	;设置 es:di 指向目标地址(确定系统非使用内存空间(如:200h-2FFh)，来存放源字符串)
	mov ax, 0
	mov es, ax
	mov di, 200h
	
	;循环，将 ds:[si](即 cs:[ip]) 的数据依次存放在 es:[di]
	mov cx, offset IntHandlerEnd - offset IntHandler 	;中断处理程序长度. (不是字符串长度！)
	cld			;设置 DF=0, si++,di++
	rep movsb	;相当于 S: movsb; loop
	
	;设置中断向量表
	;mov ax,1000h
    ;mov bh,1
    ;div bh
	
	mov ax, 4C00h
	int 21h
	


;===========================
;子程序： 中断处理程序
;	显示除法溢出时提示字符串
;===========================
IntHandler: 	
	jmp short IntHandlerStart
	db 'zhq3211 warning...Overflow error!'

IntHandlerStart:
	;字符串-首地址
	mov ax, cs	;mov ax, code
	mov ds, ax
	mov si, 200h+2h	;设置 ds:si 指向字符串. "jmp short"占2byte, 所以字符串偏移地址为 (200+2)h
	
	;显存缓冲区-首地址设置
	mov ax, 0B800h
	mov es, ax
	mov di, 10*160+20*2	;设置 es:di 指向显存空间的第10行第20列
	
	;将字符串放入显存缓冲区
	mov cx, 33	;字符串长度
S:	mov al, ds:[si]
	mov es:[di], al
	add di, 2
	inc si
	Loop S
	
	mov ax, 4C00h
	int 21h
	
IntHandlerEnd: nop
	
code ends
end start 
