;assume (伪指令)的功能：
;	假设 segment...ends 定义的程序与 CS段寄存器相关联.
assume cs:code 

;segment...ends (一对伪指令)的功能：
;	定义一个段，这个段必须有一个名称来标识（如：codesg, 自定义）.
;	这对伪指令，是在写可被编译器编译的汇编指令程序时，必须要用到的一对伪指令.
;code (标号)
;	一个标号指代了一个地址.
code segment
;下面5条指令，为源程序中的“程序”
	mov ax, 0123H
	mov bx, 4567H
	add ax,bx

;下面2条指令，程序返回，CPU 的控制权交给 DOS下的command.
	mov ax,4c00H
	INT 21H
code ends

;end (伪指令)
;	程序结束的标志.
end
