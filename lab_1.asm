.686	; ��������� ���������� ���� �������������
.model flat, stdcall	; ������� ����� ����� ����� �� ����� �� Windows
option casemap:none	;�����, �� ������� ���������� �� �������������� 
include \masm32\include\windows.inc 	; ��������� ��������������� ��� ��������� ����� windows.inc � �������� \masm32\include
include \masm32\include\kernel32.inc 	; ��������� ��������������� ��� ��������� ����� kernel32.inc � �������� \masm32\include
include \masm32\include\user32.inc; ��������� ��������������� ��� ��������� ����� user32.inc � �������� \masm32\include
includelib \masm32\lib\user32.lib; ��������� ��������������� ��� ���������� ����� �������� user32.lib � �������� \masm32\lib
includelib \masm32\lib\kernel32.lib; ��������� ��������������� ��� ���������� ����� �������� kernel32.lib � �������� \masm32\lib
firstfunc PROTO _d:DWORD,_const1:DWORD,_c1:DWORD,_const2:DWORD,_a:DWORD,_c2:DWORD
.data   ; d/3c-15ac ��������� ���������� �������������� ����� 300/3*1-15*2*1=70
d dd 300	; ����������  d �� ����� ��������� ����� � ��������� 300
const1 dd 3;	 ����������  const1 �� ����� ��������� ����� � ��������� 3
c1 dd 1		; ����������  c1 �� ����� ��������� ����� � ��������� 1
const2 dd 15	; ����������  const2 �� ����� ��������� ����� � ��������� 15
a dd 2	; ���������� a �� ����� ��������� ����� � ��������� 2
c2 dd 1; ����������  c2 �� ����� ��������� ����� � ��������� 1
_temp1 dd ?,0; ����������  _temp1 ����� �� ����� ��������� ����� � ���������� ��������� 0
_title db "����������� ������ �1. �����. ��������",0	; ���������� _title ����� �������� ����� 
strbuf dw ?,0	; ���������� strbuf ����� ����� ��������� ����� � ���������� ��������� 0
_text db "masm32. ���� ���������� d/3c-15ac ����� MessageBox:",0ah,"���������: %d � ���� �������",0ah, 0ah,
"Krykunova Anastasiia",0	;���������� _text ����� �������� ����� �� ���������� ����� 
.code; ��������� ������� ���� ��������
firstfunc proc _d:DWORD,_const1:DWORD,_c1:DWORD,_const2:DWORD,_a:DWORD,_c2:DWORD ;���������� ������� ���  ������� � 6 ����������� d, const1, c1, const2, a, c2
mov eax,_d	; ���������� �������� "_d" � ������ eax
mul _c1		; ��������� �������� � eax �� "_c1" � ��������� ��������� � EAX
div _const1	; �������� �������� � EDX:EAX �� "_const1" � �������� ������ � EAX
mov _temp1, eax	; ��������� �������� � EAX �� ����� "_temp1".
mov eax, _const2	; ���������� �������� "_const2" �� ������ EAX
mul _a	; �������� �������� � EAX �� "_a" � �������� ��������� � EAX
mul _c2		; �������� �������� � EAX �� "_c2" � �������� ��������� � EAX
sub _temp1,eax		; ��������, ��������� �������� _a � _c2 �� ��������, �� ���������� � _temp1
ret 	; ���������� ��������� ��
firstfunc endp		; ����� ������� firstfunc
start:		;  ������ ������� ������� ��������
invoke firstfunc,d,const1,c1,const2,a,c2		; �������� ��������� firstfunc �� ����������� �����������
invoke wsprintf, ADDR strbuf, ADDR _text,_temp1	; ������������ ����� �� ��������� ������� wsprintf, ��������� ��������� � strbuf
invoke MessageBox, NULL, addr strbuf, addr _title, MB_ICONINFORMATION	; ���������� ���� �����������, �� ������ �������������� �����
invoke ExitProcess, 0	; ����� � ��������
END start	; ��������� �������� � ���� start

