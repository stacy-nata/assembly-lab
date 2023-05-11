<<<<<<< HEAD
.486; директива визначення типу мікропроцесора
.model flat, stdcall  ;визначення лінійної моделі пам’яті
option casemap :none;розділення верхнього та нижнього регістрів
include \masm32\include\windows.inc ; підключення програмного файлу windows.inc
include \masm32\macros\macros.asm ; MASM support macros
include \masm32\include\masm32.inc; підключення програмного файлу masm.inc
include \masm32\include\gdi32.inc; підключення програмного файлу gdi32.inc
include \masm32\include\fpu.inc; підключення програмного файлу  fpu.inc
include \masm32\include\user32.inc; підключення програмного файлу user32.inc
include \masm32\include\kernel32.inc; підключення програмного файлу kernel32.inc
include c:\masm32\include\msvcrt.inc; підключення програмного файлу msvcrt.inc
includelib c:\masm32\lib\msvcrt.lib; підключення бібліотеки  msvcrt.lib
includelib c:\masm32\lib\fpu.lib; підключення бібліотеки  fpu.lib
includelib \masm32\lib\masm32.lib; підключення бібліотеки  masm32.lib
includelib \masm32\lib\gdi32.lib; підключення бібліотеки  gdi32.lib
includelib \masm32\lib\user32.lib; підключення бібліотеки  user32.lib
includelib \masm32\lib\kernel32.lib; підключення бібліотеки  kernel32.lib

.data	; директива визначення данних
_r DWORD 0.0;оголошення змінної r
_const_exp DWORD 2.7182
_const_2 DWORD 2.0

borderLeft DWORD -1.0 ;оголошення змінної borderLeft
borderRight DWORD 1.0 ;оголошення змінної borderRight
_title db "Лабораторна робота №4",0;назва вікна повідомлення
strbuf dw ?,0
_text db "masm32. Крикунова Анастасія ІН-101 ", 10,
"Вивід результата через MessageBox:", 10,
"v=y+arctg(y)       y<-1", 10,
"v=arccos(y)     -1<=y<=1", 10,
"v=y^2+e*y          1<=y", 10,
"Результат: " 
_res db 10 DUP(0),10,13
MsgBoxCaption db "Результат порівняння",0 

MsgBoxText_1     db "y<-1",0 
MsgBoxText_2     db "-1<=y<=1", 0
MsgBoxText_3     db "1<y", 0; виведення на екран користувачу повідомлення про результат

.const 
NULL equ 0 
MB_OK equ 0 

.code ; директива початку сегменту команд
_start:	; мітка початку програми з іменем _start
	
main proc ;директива proc
LOCAL _y: DWORD ;оголошення змінної х
mov _y, sval(input("Enter y: ")) ;виведення х для вибору користувача

finit ;ініціалізація співпроцесора
fild _y ;завантаження х у верхівку стеку
fstp _y ;збереження х з виштовхуванням з стеку
fld borderLeft ;завантаження змінної у верхівку стеку
fld _y ;завантаження х у верхівку стеку, зміщення змінної у st(1)
fcompp ;порівняння вершини стека з операндом
fstsw ax;записує значення слова стану fpu в регістр
sahf ;запис вмісту регістра в регістр прапорів процесора 
jb first ;джамп 
fld borderRight ;записуємо змінну у верхівку стеку
fld _y ;записуємо змінну х у верхівку стеку, попередня змінна в st(1)
fcompp ;порівняння вершини стека з операндом
fstsw ax;записує значення слова стану fpu в регістр
sahf ;запис вмісту регістра в регістр прапорів процесора
jbe second ;джамп
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

jmp lexit ;переходимо на мітку exit (GOTO exit)
	
first:
	;v=y+arctg(y) (1)
	fld _y;занесення у у верхівку стеку
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
ret ; повернення управління ОС
	
end _start ; завершення програми з ім’ям  _start


=======
.486; директива визначення типу мікропроцесора
.model flat, stdcall  ;визначення лінійної моделі пам’яті
option casemap :none;розділення верхнього та нижнього регістрів
include \masm32\include\windows.inc ; підключення програмного файлу windows.inc
include \masm32\macros\macros.asm ; MASM support macros
include \masm32\include\masm32.inc; підключення програмного файлу masm.inc
include \masm32\include\gdi32.inc; підключення програмного файлу gdi32.inc
include \masm32\include\fpu.inc; підключення програмного файлу  fpu.inc
include \masm32\include\user32.inc; підключення програмного файлу user32.inc
include \masm32\include\kernel32.inc; підключення програмного файлу kernel32.inc
include c:\masm32\include\msvcrt.inc; підключення програмного файлу msvcrt.inc
includelib c:\masm32\lib\msvcrt.lib; підключення бібліотеки  msvcrt.lib
includelib c:\masm32\lib\fpu.lib; підключення бібліотеки  fpu.lib
includelib \masm32\lib\masm32.lib; підключення бібліотеки  masm32.lib
includelib \masm32\lib\gdi32.lib; підключення бібліотеки  gdi32.lib
includelib \masm32\lib\user32.lib; підключення бібліотеки  user32.lib
includelib \masm32\lib\kernel32.lib; підключення бібліотеки  kernel32.lib

.data	; директива визначення данних
_r DWORD 0.0;оголошення змінної r
_const_exp DWORD 2.7182
_const_2 DWORD 2.0

borderLeft DWORD -1.0 ;оголошення змінної borderLeft
borderRight DWORD 1.0 ;оголошення змінної borderRight
_title db "Лабораторна робота №4",0;назва вікна повідомлення
strbuf dw ?,0
_text db "masm32. Крикунова Анастасія ІН-101 ", 10,
"Вивід результата через MessageBox:", 10,
"v=y+arctg(y)       y<-1", 10,
"v=arccos(y)     -1<=y<=1", 10,
"v=y^2+e*y          1<=y", 10,
"Результат: " 
_res db 10 DUP(0),10,13
MsgBoxCaption db "Результат порівняння",0 

MsgBoxText_1     db "y<-1",0 
MsgBoxText_2     db "-1<=y<=1", 0
MsgBoxText_3     db "1<y", 0; виведення на екран користувачу повідомлення про результат

.const 
NULL equ 0 
MB_OK equ 0 

.code ; директива початку сегменту команд
_start:	; мітка початку програми з іменем _start
	
main proc ;директива proc
LOCAL _y: DWORD ;оголошення змінної х
mov _y, sval(input("Enter y: ")) ;виведення х для вибору користувача

finit ;ініціалізація співпроцесора
fild _y ;завантаження х у верхівку стеку
fstp _y ;збереження х з виштовхуванням з стеку
fld borderLeft ;завантаження змінної у верхівку стеку
fld _y ;завантаження х у верхівку стеку, зміщення змінної у st(1)
fcompp ;порівняння вершини стека з операндом
fstsw ax;записує значення слова стану fpu в регістр
sahf ;запис вмісту регістра в регістр прапорів процесора 
jb first ;джамп 
fld borderRight ;записуємо змінну у верхівку стеку
fld _y ;записуємо змінну х у верхівку стеку, попередня змінна в st(1)
fcompp ;порівняння вершини стека з операндом
fstsw ax;записує значення слова стану fpu в регістр
sahf ;запис вмісту регістра в регістр прапорів процесора
jbe second ;джамп
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

jmp lexit ;переходимо на мітку exit (GOTO exit)
	
first:
	;v=y+arctg(y) (1)
	fld _y;занесення у у верхівку стеку
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
ret ; повернення управління ОС
	
end _start ; завершення програми з ім’ям  _start


>>>>>>> 456af6c64d46e9332ceeb946ba04fd20678b11bb
