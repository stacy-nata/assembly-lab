<<<<<<< HEAD
.486; ��������� ���������� ���� �������������
.model flat, stdcall  ;���������� ����� ����� �����
option casemap :none;��������� ��������� �� �������� �������
include \masm32\include\windows.inc ; ���������� ����������� ����� windows.inc
include \masm32\macros\macros.asm ; MASM support macros
include \masm32\include\masm32.inc; ���������� ����������� ����� masm.inc
include \masm32\include\gdi32.inc; ���������� ����������� ����� gdi32.inc
include \masm32\include\fpu.inc; ���������� ����������� �����  fpu.inc
include \masm32\include\user32.inc; ���������� ����������� ����� user32.inc
include \masm32\include\kernel32.inc; ���������� ����������� ����� kernel32.inc
include c:\masm32\include\msvcrt.inc; ���������� ����������� ����� msvcrt.inc
includelib c:\masm32\lib\msvcrt.lib; ���������� ��������  msvcrt.lib
includelib c:\masm32\lib\fpu.lib; ���������� ��������  fpu.lib
includelib \masm32\lib\masm32.lib; ���������� ��������  masm32.lib
includelib \masm32\lib\gdi32.lib; ���������� ��������  gdi32.lib
includelib \masm32\lib\user32.lib; ���������� ��������  user32.lib
includelib \masm32\lib\kernel32.lib; ���������� ��������  kernel32.lib

.data	; ��������� ���������� ������
_r DWORD 0.0;���������� ����� r
_const_exp DWORD 2.7182
_const_2 DWORD 2.0

borderLeft DWORD -1.0 ;���������� ����� borderLeft
borderRight DWORD 1.0 ;���������� ����� borderRight
_title db "����������� ������ �4",0;����� ���� �����������
strbuf dw ?,0
_text db "masm32. ��������� �������� ��-101 ", 10,
"���� ���������� ����� MessageBox:", 10,
"v=y+arctg(y)       y<-1", 10,
"v=arccos(y)     -1<=y<=1", 10,
"v=y^2+e*y          1<=y", 10,
"���������: " 
_res db 10 DUP(0),10,13
MsgBoxCaption db "��������� ���������",0 

MsgBoxText_1     db "y<-1",0 
MsgBoxText_2     db "-1<=y<=1", 0
MsgBoxText_3     db "1<y", 0; ��������� �� ����� ����������� ����������� ��� ���������

.const 
NULL equ 0 
MB_OK equ 0 

.code ; ��������� ������� �������� ������
_start:	; ���� ������� �������� � ������ _start
	
main proc ;��������� proc
LOCAL _y: DWORD ;���������� ����� �
mov _y, sval(input("Enter y: ")) ;��������� � ��� ������ �����������

finit ;����������� ������������
fild _y ;������������ � � �������� �����
fstp _y ;���������� � � �������������� � �����
fld borderLeft ;������������ ����� � �������� �����
fld _y ;������������ � � �������� �����, ������� ����� � st(1)
fcompp ;��������� ������� ����� � ���������
fstsw ax;������ �������� ����� ����� fpu � ������
sahf ;����� ����� ������� � ������ ������� ��������� 
jb first ;����� 
fld borderRight ;�������� ����� � �������� �����
fld _y ;�������� ����� � � �������� �����, ��������� ����� � st(1)
fcompp ;��������� ������� ����� � ���������
fstsw ax;������ �������� ����� ����� fpu � ������
sahf ;����� ����� ������� � ������ ������� ���������
jbe second ;�����
	;y^2+e*y (3)
	fld _y ;load y to the top of the stack
	fmul _y ; y^2
	fld _const_exp ;load exponent to the top of the stack
	fmul _y ;y*e
	fadd ; y^2+e*y
	invoke MessageBoxA, NULL, ADDR MsgBoxText_3, ADDR MsgBoxCaption, MB_OK 
	invoke FpuFLtoA, 0, 10, ADDR _res, SRC1_FPU or SRC2_DIMM
	invoke MessageBox, 0, offset _text, offset _title, MB_ICONINFORMATION
	invoke ExitProcess, 0

jmp lexit ;���������� �� ���� exit (GOTO exit)
	
first:
	;v=y+arctg(y) (1)
	fld _y;��������� � � �������� �����
	fld1 ;to compute full arctangent.
	fpatan ;arctg(y)
	fld _y ; load y to the top of the stack
	fadd ;y+arctg(y)
	invoke MessageBoxA, NULL, ADDR MsgBoxText_1, ADDR MsgBoxCaption, MB_OK 
	invoke FpuFLtoA, 0, 10, ADDR _res, SRC1_FPU or SRC2_DIMM
	invoke MessageBox, 0, offset _text, offset _title, MB_ICONINFORMATION
	invoke ExitProcess, 0
	jmp lexit

second:
	;arccos(y) (2)
      fld _y ;load X on tos.
      fld _y
      fmul ;Compute X**2.
      fld _y
      fld _y
      fmul
      fld1 ;Compute 1-X**2.
      fsubr
      fdiv ;Compute (1-x**2)/X**2.
      fsqrt ;Compute sqrt((1-X**2)/X**2).
      fld1 ;To compute full arctangent.
      fpatan
      fld _const_2
      fmul


	invoke MessageBoxA, NULL, ADDR MsgBoxText_2, ADDR MsgBoxCaption, MB_OK 
	invoke FpuFLtoA, 0, 10, ADDR _res, SRC1_FPU or SRC2_DIMM
	invoke MessageBox, 0, offset _text, offset _title, MB_ICONINFORMATION
	invoke ExitProcess, 0 ; exit the program
	jmp lexit ;go to the exit label (GOTO exit)

lexit:
ret
main endp
ret ; ���������� ��������� ��
	
end _start ; ���������� �������� � ����  _start


=======
.486; ��������� ���������� ���� �������������
.model flat, stdcall  ;���������� ����� ����� �����
option casemap :none;��������� ��������� �� �������� �������
include \masm32\include\windows.inc ; ���������� ����������� ����� windows.inc
include \masm32\macros\macros.asm ; MASM support macros
include \masm32\include\masm32.inc; ���������� ����������� ����� masm.inc
include \masm32\include\gdi32.inc; ���������� ����������� ����� gdi32.inc
include \masm32\include\fpu.inc; ���������� ����������� �����  fpu.inc
include \masm32\include\user32.inc; ���������� ����������� ����� user32.inc
include \masm32\include\kernel32.inc; ���������� ����������� ����� kernel32.inc
include c:\masm32\include\msvcrt.inc; ���������� ����������� ����� msvcrt.inc
includelib c:\masm32\lib\msvcrt.lib; ���������� ��������  msvcrt.lib
includelib c:\masm32\lib\fpu.lib; ���������� ��������  fpu.lib
includelib \masm32\lib\masm32.lib; ���������� ��������  masm32.lib
includelib \masm32\lib\gdi32.lib; ���������� ��������  gdi32.lib
includelib \masm32\lib\user32.lib; ���������� ��������  user32.lib
includelib \masm32\lib\kernel32.lib; ���������� ��������  kernel32.lib

.data	; ��������� ���������� ������
_r DWORD 0.0;���������� ����� r
_const_exp DWORD 2.7182
_const_2 DWORD 2.0

borderLeft DWORD -1.0 ;���������� ����� borderLeft
borderRight DWORD 1.0 ;���������� ����� borderRight
_title db "����������� ������ �4",0;����� ���� �����������
strbuf dw ?,0
_text db "masm32. ��������� �������� ��-101 ", 10,
"���� ���������� ����� MessageBox:", 10,
"v=y+arctg(y)       y<-1", 10,
"v=arccos(y)     -1<=y<=1", 10,
"v=y^2+e*y          1<=y", 10,
"���������: " 
_res db 10 DUP(0),10,13
MsgBoxCaption db "��������� ���������",0 

MsgBoxText_1     db "y<-1",0 
MsgBoxText_2     db "-1<=y<=1", 0
MsgBoxText_3     db "1<y", 0; ��������� �� ����� ����������� ����������� ��� ���������

.const 
NULL equ 0 
MB_OK equ 0 

.code ; ��������� ������� �������� ������
_start:	; ���� ������� �������� � ������ _start
	
main proc ;��������� proc
LOCAL _y: DWORD ;���������� ����� �
mov _y, sval(input("Enter y: ")) ;��������� � ��� ������ �����������

finit ;����������� ������������
fild _y ;������������ � � �������� �����
fstp _y ;���������� � � �������������� � �����
fld borderLeft ;������������ ����� � �������� �����
fld _y ;������������ � � �������� �����, ������� ����� � st(1)
fcompp ;��������� ������� ����� � ���������
fstsw ax;������ �������� ����� ����� fpu � ������
sahf ;����� ����� ������� � ������ ������� ��������� 
jb first ;����� 
fld borderRight ;�������� ����� � �������� �����
fld _y ;�������� ����� � � �������� �����, ��������� ����� � st(1)
fcompp ;��������� ������� ����� � ���������
fstsw ax;������ �������� ����� ����� fpu � ������
sahf ;����� ����� ������� � ������ ������� ���������
jbe second ;�����
	;y^2+e*y (3)
	fld _y ;load y to the top of the stack
	fmul _y ; y^2
	fld _const_exp ;load exponent to the top of the stack
	fmul _y ;y*e
	fadd ; y^2+e*y
	invoke MessageBoxA, NULL, ADDR MsgBoxText_3, ADDR MsgBoxCaption, MB_OK 
	invoke FpuFLtoA, 0, 10, ADDR _res, SRC1_FPU or SRC2_DIMM
	invoke MessageBox, 0, offset _text, offset _title, MB_ICONINFORMATION
	invoke ExitProcess, 0

jmp lexit ;���������� �� ���� exit (GOTO exit)
	
first:
	;v=y+arctg(y) (1)
	fld _y;��������� � � �������� �����
	fld1 ;to compute full arctangent.
	fpatan ;arctg(y)
	fld _y ; load y to the top of the stack
	fadd ;y+arctg(y)
	invoke MessageBoxA, NULL, ADDR MsgBoxText_1, ADDR MsgBoxCaption, MB_OK 
	invoke FpuFLtoA, 0, 10, ADDR _res, SRC1_FPU or SRC2_DIMM
	invoke MessageBox, 0, offset _text, offset _title, MB_ICONINFORMATION
	invoke ExitProcess, 0
	jmp lexit

second:
	;arccos(y) (2)
      fld _y ;load X on tos.
      fld _y
      fmul ;Compute X**2.
      fld _y
      fld _y
      fmul
      fld1 ;Compute 1-X**2.
      fsubr
      fdiv ;Compute (1-x**2)/X**2.
      fsqrt ;Compute sqrt((1-X**2)/X**2).
      fld1 ;To compute full arctangent.
      fpatan
      fld _const_2
      fmul


	invoke MessageBoxA, NULL, ADDR MsgBoxText_2, ADDR MsgBoxCaption, MB_OK 
	invoke FpuFLtoA, 0, 10, ADDR _res, SRC1_FPU or SRC2_DIMM
	invoke MessageBox, 0, offset _text, offset _title, MB_ICONINFORMATION
	invoke ExitProcess, 0 ; exit the program
	jmp lexit ;go to the exit label (GOTO exit)

lexit:
ret
main endp
ret ; ���������� ��������� ��
	
end _start ; ���������� �������� � ����  _start


>>>>>>> 456af6c64d46e9332ceeb946ba04fd20678b11bb
