;��̣�����Ļ��5��12����ʾ3����׸�����˸��ɫ�ġ�a����

assume cs:code
code segment
	mov ah,2 	;�ù��
	mov bh,0	;��0ҳ
	mov dh,5	;dh�з��к�
	mov dl,12	;dl�з��к�
	int 10h	
	
	mov ah,9	;�ù��
	mov al,'a'	;�ַ�
	mov bl,11001010b;��ɫ����
	mov bh,0	;��0ҳ
	mov cx,3	;�ַ��ظ�����
	int 10h

	mov ax,4c00h
	int 21h 

code ends
end
