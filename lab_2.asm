.486                                    ; create 32 bit code
    .model flat, stdcall                    ; 32 bit memory model
    option casemap :none                    ; case sensitive
     include \masm32\include\windows.inc     ; always first
    include \masm32\macros\macros.asm       ; MASM support macros
  ; -----------------------------------------------------------------
  ; include files that have MASM format prototypes for function calls
  ; -----------------------------------------------------------------
    include \masm32\include\masm32.inc
    include \masm32\include\gdi32.inc
    include \masm32\include\user32.inc
    include \masm32\include\kernel32.inc
include C:\masm32\include\msvcrt.inc
includelib C:\masm32\lib\msvcrt.lib
  ; ------------------------------------------------
  ; Library files that have definitions for function
  ; exports and tested reliable prebuilt code.
  ; ------------------------------------------------
    includelib \masm32\lib\masm32.lib
    includelib \masm32\lib\gdi32.lib
    includelib \masm32\lib\user32.lib
    includelib \masm32\lib\kernel32.lib
.data	; директива определения данных
_const1 dd 8
_const2 dd 19
_const3 dd 3
_const4 dd 20
_temp1 dd ?,0
_temp2 dd ?,0

_title db "Лабораторна робота №2. операції порівнняння",0
strbuf dw ?,0
_text db "masm32.  Вивід результата через MessageBox:",0ah,
"8d/b-19d/c d>e",0ah,
"3d/b+20e d<=e",0ah,
"Результат: %d — ціла частина",0ah, 0ah,
"СТУДЕНТ КНЕУ  Krykunova Anastasiia",0
MsgBoxCaption  db "Пример окна сообщения",0 
MsgBoxText_1     db "порівняння  d>e",0 
MsgBoxText_2     db "порівняння  d<=e",0 

.const 
   NULL        equ  0 
   MB_OK       equ  0 

.code	; директива начала сегмента команд
_start:	; метка начала программы с именем _start
 
main proc
LOCAL _d: DWORD 
LOCAL _b: DWORD 
LOCAL _c: DWORD 
LOCAL _e: DWORD 
mov _d, sval(input("vvedite d = "))
mov _b, sval(input("vvedite b = "))
mov _c, sval(input("vvedite c = "))
mov _e, sval(input("vvedite e = "))

 
mov ebx, _d
mov eax, _e ;здесь мы записали число _e в регистр eax.
sub ebx, eax   ; порівняння  _d<=_e

   
	jle zero

; zero ;осуществляем переход на метку zero,
;если флаг ZF установлен.
;Если  не , то выполнение продолжится дальше
;y=8d/b-19d/c d>e 
mov eax, _d   
mul _const1
div _b         
mov _temp1, eax      ;0  зміст eax в _temp1=5
mov eax, _const2    ;
mul _d
div _c
sub _temp1 , eax         ;

INVOKE    MessageBoxA, NULL, ADDR MsgBoxText_1, ADDR MsgBoxCaption, MB_OK 
invoke wsprintf, ADDR strbuf, ADDR _text, _temp1
invoke MessageBox, NULL, addr strbuf, addr _title, MB_ICONINFORMATION
invoke ExitProcess, 0

jmp lexit ;переходим на метку exit (GOTO exit)
 zero:
;y=3d/b+20e d<=e
mov eax, _d    ; 1
mul _const3 
div _b
mov _temp2, eax      ;0  зміст eax в _temp1=5
mov eax, _const4 ;
mul _e  
add _temp2,eax   ;_temp2=_temp2- eax  =5-9=-4  y=ac-3x x<=c


INVOKE    MessageBoxA, NULL, ADDR MsgBoxText_2, ADDR MsgBoxCaption, MB_OK 
invoke wsprintf, ADDR strbuf, ADDR _text, _temp2
invoke MessageBox, NULL, addr strbuf, addr _title, MB_ICONINFORMATION
invoke ExitProcess, 0

 lexit:
 ret
main endp
 ret                     ; возврат управления ОС
end _start          ; завершение программы с именем _start

