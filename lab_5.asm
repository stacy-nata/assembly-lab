.486 ; ��������� ���������� ���� �������������
.model flat, stdcall ;���������� ����� ����� �����
option casemap: none ;��������� ��������� �� �������� �������
include C:\masm32\include\windows.inc     
include C:\masm32\macros\macros.asm       
include C:\masm32\include\masm32.inc
include C:\masm32\include\gdi32.inc
include C:\masm32\include\fpu.inc
include C:\masm32\include\user32.inc
include C:\masm32\include\kernel32.inc              ;���������� ������� ��
include C:\masm32\include\msvcrt.inc                  ;��������� �����
includelib C:\masm32\lib\msvcrt.lib
includelib C:\masm32\lib\fpu.lib
includelib C:\masm32\lib\masm32.lib
includelib C:\masm32\lib\gdi32.lib
includelib C:\masm32\lib\user32.lib
includelib C:\masm32\lib\kernel32.lib
uselib masm32, comctl32, ws2_32 
 .data ; ��������� ���������� ������
 msg_title db "Title", 0 ; ������������ ��������� �����������
_const1 DWORD 4.0 ;���������� ��������� 1
_const2 DWORD 8.0 ;���������� ��������� 2
_const3 DWORD �.0 ;���������� ��������� 3

_count dd 1 ; ���������� ����� � ������ ������
_right dd 4 ; ���������� ����� � ������ ������
_count1 DWORD 1.0 ;���������� ����� � ������ ������ ��� ������ � �������
_one DWORD 1.0; ���������� ����� � ��������� 1
_result DWORD 1.0 ; ���������� ����� ��� ����������
_title db "����������� ������ �5",0 ; ������������ ���������
strbuf dw ?,0
_text db "masm32.  ������� ������ ��-101 ���� ����, ���. ���  2021 �. ",10 ,"���� ���������� ����� MessageBox:", 10, 
"���������: " 
_res1 db 14 DUP(0),10,13; ���������� ����������� � ���

.code ; ��������� ������� �������� ������
start: ; ���� ������� ��������
mov edx, 1 ;��������� 1 � ������ edx
mov ebx, _right; ��������� �������� ������� ����� � ������ ebx
mov ecx, _count; ��������� �������� ������� ����� � ����� ecx
finit ;����������� �����������

.WHILE edx == 1 ; ������� ����� ��� ������� �����

.IF ecx == 5 	 	; ����� ��� ��� ������ ���������� �����, ��� ���� ������� ������ �� ����
loop m1  		;���� m1
.ENDIF 		; ����� ����� IF
fld _count1 		;������������ �����  count1 � �������� �����
fmul _count1 	;�������� �� �����
fld _count1 		;������������ �����  count1 � �������� �����
fmul _const1 	;�������� �� ���������
fadd st(0), st(1) 	;��������� ����� �������
fadd _const2 	;��������� ���������
fld _count1 		; ������������ ����� count1 � �������� �����
fsub _const3 	;�������� ���������
fdiv st(1), st(0) 	;������ ����� �������
fstp st(0) 	 	;���������� ���������� � �������� �����
fld _result 		 ;������������ _ result � �������� �����
fmul st(0),st(1)  	; �������� �������� � �������� ����� �� �������� � �������
fstp _result 		; ���������� �������� � ����� _result

m1: ; ���� m1

add ecx,1
fld _one
fld _count1                          ;��������� � ���������� ��� ���������
fadd st(0), st(1)                   ;�������� ��������
fstp _count1
add _count ,1


.IF ecx > ebx 
fld _result                       ;����� ��� ������ � �����
.BREAK
.ENDIF
.ENDW

invoke FpuFLtoA, 0, 10, ADDR _res1, SRC1_FPU or SRC2_DIMM
invoke MessageBox, 0, offset _text, offset _title, MB_ICONINFORMATION
invoke ExitProcess, 0
 
end start ; ���������� ��������
