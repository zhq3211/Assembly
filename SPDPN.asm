
assume cs:code

code segment
  ;Your program
  SMB_BASE	  equ 0F040h  ;根据Project自己设置，如 F040H, 0500h
  SPD_Address equ 0A1h    ;根据从设备具体地址设置

  HST_STS    equ SMB_BASE+00h  ;0F040h 
  HST_CNT    equ SMB_BASE+02h  ;0F042h 
  HST_CMD    equ SMB_BASE+03h  ;0F043h 
  XMIT_SLVA  equ SMB_BASE+04h  ;0F044h 
  HST_D0     equ SMB_BASE+05   ;0F045h 
  HST_D1     equ SMB_BASE+06h  ;0F046h 
	
Start: 
  mov   cx, 00h 
Loop1: 
  mov   al, SPD_Address 
  call  Word_Write 
  add   cx, 01h 
  cmp   cx, 12h   ;(减指令) PN长度为 12h (80h-91h)
  jnz   Loop1 
  mov   ah, 4ch   ;word read 指令
  int   21h 
 
Word_Write: 
  push  ax 
  push  dx 
  push  cx 
  mov   dx, XMIT_SLVA 
  out   dx, al        ;F044h 处写入 SPD地址 A1h 
 
  mov   dx, HST_CMD 
  mov   al, 80h       ;SPD PN 位于 80h-91h (18bytes=12h)
  add   al, cl 
  out   dx, al        ;F043h 处写入 SPD PN 寄存器偏移
   
  mov   dx, HST_CNT 
  mov   al, 48h 
  out   dx, al        ;F042h 写入 byte Read 指令: 48h 
 
  call  Reset_SMBus 
  mov   dx, HST_D0 
  in    al, dx 
  mov   dl, al 
  mov   ah, 2 
  int   21h 
   
  pop   cx 
  pop   dx 
  pop   ax 
  ret 
 
Reset_SMBus: 
  push  ax 
  push  dx 
  mov   dx, HST_STS 
.Wait:           ;Wait F040h=42h then set it to FFh 
  in    al, dx   
  cmp   al, 42h 
  jnz   .Wait    ;al-42h，结果不为零则转跳到 .Wait
  mov   al, 0FFh 
  out   dx, al   
.Wait2:          ;Wait F040=40 for ready 
  in    al, dx   
  cmp   al, 40h 
  jnz   .Wait2 
  pop   dx 
  pop   ax 
  ret 
	
  mov ax,4c00H
  int 21H
code ends

end