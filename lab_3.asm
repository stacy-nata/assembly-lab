.386
.model flat, stdcall 
option casemap:none
include C:\masm32\include\windows.inc 
include C:\masm32\include\kernel32.inc
include C:\masm32\include\user32.inc 
include C:\masm32\include\fpu.inc 
includelib C:\masm32\lib\kernel32.lib 
includelib C:\masm32\lib\user32.lib 
includelib C:\masm32\lib\fpu.lib

.data
CrLf equ 0A0Dh
_X dt 7.0
_x DWORD 1.0
_op30 DWORD 5
_step DWORD 1.0
_zero DWORD 0.0
_limit DWORD 12000.
sum DWORD 12000.0
info db "Студентка Крикунова Анастасія КНЕУ ІІТЕ",10,10,
"Y = 2^х + 5 при якому сума Y>12000 з кроком 1  ",10,10,
"x = "
_res1 db 14 DUP(0),10,13
ttl db "Обробка чисел на сопроцесорі в циклі",0
.code
_start: 
fninit
mov ecx, 12
math:
fld _x
fld1
fscale 
fadd _op30
fcomp _limit
ja qwerty
fninit

fld _x
fadd _step
fstp _x
loop math

qwerty:
fld _x
fstp _X
invoke FpuFLtoA,offset _X,10,offset _res1,SRC1_REAL or SRC2_DIMM 
mov word ptr _res1 + 14, CrLf
invoke MessageBox, 0, offset info, offset ttl, MB_ICONINFORMATION 
invoke ExitProcess, 0
end _start

