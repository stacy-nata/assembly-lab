.686 						; create 32 bit code
.model flat, stdcall 			; 32 bit memory model
option casemap :none 			; case sensitive
include \masm32\include\windows.inc ; always first
include \masm32\macros\macros.asm ; MASM support macros
include \masm32\include\masm32.inc
include \masm32\include\gdi32.inc
include \masm32\include\fpu.inc
include \masm32\include\user32.inc
include \masm32\include\kernel32.inc
include c:\masm32\include\msvcrt.inc
includelib c:\masm32\lib\msvcrt.lib
includelib c:\masm32\lib\fpu.lib
includelib \masm32\lib\masm32.lib
includelib \masm32\lib\gdi32.lib
includelib \masm32\lib\user32.lib
includelib \masm32\lib\kernel32.lib
.data 					; ��������� ����������� ������
x DWORD 0.0
xnow DWORD 0.0
factor DWORD 1.0
temp DWORD 0
eps DWORD 0.0001
zero DWORD 0.0
two DWORD 2.0
_title db "����������� ������ �6",0
strbuf dw ?,0
_text db "masm32. ��������� �������� ����, ���. ��� 2022 �. ",10 ,"���� ���������� EXP(2*X):", 10,13
_result dt 0.0
sum DWORD 1.0
n DWORD 1.0
n1 DWORD 0.0
.const 
NULL equ 0 
MB_OK equ 0 
include \masm32\include\masm32rt.inc
include \masm32\include\dialogs.inc

dlgproc PROTO :DWORD,:DWORD,:DWORD,:DWORD
GetTextDialog PROTO :DWORD,:DWORD,:DWORD

.data?
hInstance dd ?

.code

; ����������������������������������������������

start:
mov hInstance, rv(GetModuleHandle,NULL)
call main
invoke ExitProcess,eax

; �����������������������������������������������

main proc

LOCAL hIcon :DWORD

invoke InitCommonControls

mov hIcon, rv(LoadIcon,hInstance,10)

mov x, rv(GetTextDialog," �����������  6 (�����ֲ�)"," �������� x: ",hIcon) ;�������� �


mov eax, sval(x)	;����������� � ������ � �����
mov x, eax
.if x == 0 			
fld sum				
invoke FpuFLtoA, 0, 10, ADDR _result, SRC1_FPU or SRC2_DIMM
invoke MessageBox, 0, offset _text, offset _title, MB_ICONINFORMATION
jmp b
.endif

finit
fild x ; x
fstp x ; x = x

fld x  ; x
fld two ; 2, x
fmul ; 2 * x
fdiv factor ; 2* x / 1 
fstp xnow ; xnow = 2* x / 1

fld xnow ; 2* x / 1
fstp n1 ; n1 = 2* x / 1

fld factor ; t(0) = 1;
fld1 ; 1, 1
fadd ; 1 + 1
fstp factor ; 2

fld sum ; 1
fld xnow ;  2* x / 1
fadd ; 1 + 2* x / 1
fstp sum ; sum= 1 + 2* x / 1

a:
 
fld xnow ; 1 + 2* x / 1
fstp n ; n = 1 + 2* x / 1
 
fld xnow ; 2* x / 1
fld x ; x, 2* x / 1
fld two ; 2, x, 2*x /1 
fmul ; 2*x,  2* x / 1
fmul ; 2*x * 2 *x /1
fdiv factor ; (4*x^2/2!)
fstp xnow ; xnow = 4*x^2/2!

fld xnow ;  4*x^2/2!
fstp n1 ; n1 = 4*x^2/2!

fld sum ; sum(1) = (1 + 2*x/1!)
fld xnow ; 4*x^2/2!, 1 + 2*x/1!
Fadd ; 1 + 2*x/1! + 4*x^2/2!
fstp sum ; sum = 1 + 2*x/1! + 4*x^2/2!

fld factor ; factor= 2
fld1; 1
fadd ; 2 +1
fstp factor ; factor = 3

fld n ; U(n-1)
fsub n1 ;U(n)
fsub eps ;0.0001
fabs
fcomp eps
fstsw ax
sahf
jae a ; 

fld sum					;���� ����������
invoke FpuFLtoA, 0, 10, ADDR _result, SRC1_FPU or SRC2_DIMM
invoke MessageBox, 0, offset _text, offset _title, MB_ICONINFORMATION
b:
ret
ret
ret
main endp
; �������������������������������������������
GetTextDialog proc dgltxt:DWORD,grptxt:DWORD,iconID:DWORD
LOCAL arg1[4]:DWORD
LOCAL parg :DWORD

lea eax, arg1
mov parg, eax
; ---------------------------------------
; load the array with the stack arguments
; ---------------------------------------
mov ecx, dgltxt
mov [eax], ecx
mov ecx, grptxt
mov [eax+4], ecx
mov ecx, iconID
mov [eax+8], ecx

Dialog "Get User Text", \ ; caption
"Arial",8, \ ; font,pointsize
WS_OVERLAPPED or \ ; styles for
WS_SYSMENU or DS_CENTER, \ ; dialog window
5, \ ; number of controls
50,50,292,80, \ ; x y co-ordinates
4096 ; memory buffer size

DlgIcon 0,250,12,299
DlgGroup 0,8,4,231,31,300
DlgEdit ES_LEFT or WS_BORDER or WS_TABSTOP,17,16,212,11,301
DlgButton "OK",WS_TABSTOP,172,42,50,13,IDOK
DlgButton "Cancel",WS_TABSTOP,225,42,50,13,IDCANCEL

CallModalDialog hInstance,0,dlgproc,parg

ret

GetTextDialog endp

; ��������������������������������������������������������

dlgproc proc hWin:DWORD,uMsg:DWORD,wParam:DWORD,lParam:DWORD

LOCAL tlen :DWORD
LOCAL hMem :DWORD
LOCAL hIcon :DWORD

switch uMsg
case WM_INITDIALOG
; -------------------------------------------------
; get the arguments from the array passed in lParam
; -------------------------------------------------
push esi
mov esi, lParam
fn SetWindowText,hWin,[esi] ; title text address
fn SetWindowText,rv(GetDlgItem,hWin,300),[esi+4] ; groupbox text address
mov eax, [esi+8] ; icon handle
.if eax == 0
mov hIcon, rv(LoadIcon,NULL,IDI_ASTERISK) ; use default system icon
.else
mov hIcon, eax ; load user icon
.endif
pop esi

fn SendMessage,hWin,WM_SETICON,1,hIcon
invoke SendMessage,rv(GetDlgItem,hWin,299),STM_SETIMAGE,IMAGE_ICON,hIcon
xor eax, eax
ret

case WM_COMMAND
switch wParam
case IDOK
mov tlen, rv(GetWindowTextLength,rv(GetDlgItem,hWin,301))
.if tlen == 0
invoke SetFocus,rv(GetDlgItem,hWin,301)
ret
.endif
add tlen, 1
mov hMem, alloc(tlen)
fn GetWindowText,rv(GetDlgItem,hWin,301),hMem,tlen
invoke EndDialog,hWin,hMem
case IDCANCEL
invoke EndDialog,hWin,0
invoke ExitProcess, 0
endsw
case WM_CLOSE
invoke EndDialog,hWin,0
endsw

xor eax, eax
ret
dlgproc endp
end start
