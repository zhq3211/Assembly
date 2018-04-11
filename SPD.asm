
hst_sts   equ 0F040h 
hst_cnt   equ 0F042h 
hst_cmd   equ 0F043h 
xmit_slva  equ 0F044h 
hst_d0    equ 0F045h 
hst_d1    equ 0F046h 
Slave_Addr  equ 0A1h 
 
  org 100h 
section .text 
start: 
  mov   cx, 00h 
Loop1: 
  mov   al, Slave_Addr 
  call  word_write 
  add   cx, 01h 
  cmp   cx, 12h 
  jnz   Loop1 
  mov   ah, 4ch 
  int   21h 
 
word_write: 
  push  ax 
  push  dx 
  push  cx 
  mov   dx, xmit_slva 
  out   dx, al ;F044=A1 
 
  mov    dx, hst_cmd 
  mov    al, 80h 
  add    al, cl 
  out    dx, al ;F043=80 
   
  mov   dx, hst_cnt 
  
  mov   al, 48h 
  out   dx, al ;F042=48 
 
  call  reset_smbus 
  mov    dx, hst_d0 
  in     al, dx 
  mov    dl, al 
  mov    ah, 2 
  int    21h 
   
  pop   cx 
  pop   dx 
  pop   ax 
  ret 
 
reset_smbus: 
  push  ax 
  push  dx 
  mov   dx, hst_sts 
.wait:    ;wait F040=42 then set it to FFh 
  in    al, dx   
  cmp    al, 42h 
  jnz   .wait 
  mov   al, 0FFh 
  out   dx, al   
.wait2:    ;wait F040=40 for ready 
  in    al, dx   
  cmp    al, 40h 
  jnz   .wait2 
  pop   dx 
  pop   ax 
  ret 
 
section   .data 
