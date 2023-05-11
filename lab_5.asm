.486 ; директива визначення типу мікропроцесора
.model flat, stdcall ;визначення лінійної моделі пам’яті
option casemap: none ;розділення верхнього та нижнього регістрів
include C:\masm32\include\windows.inc     
include C:\masm32\macros\macros.asm       
include C:\masm32\include\masm32.inc
include C:\masm32\include\gdi32.inc
include C:\masm32\include\fpu.inc
include C:\masm32\include\user32.inc
include C:\masm32\include\kernel32.inc              ;підключення бібліотек та
include C:\masm32\include\msvcrt.inc                  ;системних файлів
includelib C:\masm32\lib\msvcrt.lib
includelib C:\masm32\lib\fpu.lib
includelib C:\masm32\lib\masm32.lib
includelib C:\masm32\lib\gdi32.lib
includelib C:\masm32\lib\user32.lib
includelib C:\masm32\lib\kernel32.lib
uselib masm32, comctl32, ws2_32 
 .data ; директива визначення данних
 msg_title db "Title", 0 ; встановлення заголовку повідомлення
_const1 DWORD 4.0 ;оголошення константи 1
_const2 DWORD 8.0 ;оголошення константи 2
_const3 DWORD к.0 ;оголошення константи 3

_count dd 1 ; оголошення змінної з першим числом
_right dd 4 ; оголошення змінної з другим числом
_count1 DWORD 1.0 ;оголошення змінної з першим числом для роботи зі стеками
_one DWORD 1.0; оголошення змінної зі значенням 1
_result DWORD 1.0 ; оголошення змінної для результату
_title db "Лабораторна робота №5",0 ; встановлення заголовку
strbuf dw ?,0
_text db "masm32.  Пушкарь Руслан ІН-101 ІІТЕ КНЕУ, каф. ІСЕ  2021 р. ",10 ,"Вивід результата через MessageBox:", 10, 
"Результат: " 
_res1 db 14 DUP(0),10,13; формування повідомлення у вікні

.code ; директива початку сегменту команд
start: ; мітка початку програми
mov edx, 1 ;занесення 1 у регістр edx
mov ebx, _right; занесення значення другого числа у регістр ebx
mov ecx, _count; занесення значення першого числа у регіср ecx
finit ;ініціалізація спіпроцесора

.WHILE edx == 1 ; задання умови для запуску циклу

.IF ecx == 5 	 	; умова при якій будуть обходитись числа, при яких виникне ділення на ноль
loop m1  		;мітка m1
.ENDIF 		; кінець умови IF
fld _count1 		;завантаження змінної  count1 у верхівку стеку
fmul _count1 	;множення на змінну
fld _count1 		;завантаження змінної  count1 у верхівку стеку
fmul _const1 	;множення на константу
fadd st(0), st(1) 	;додавання вмісту регістрів
fadd _const2 	;додавання константи
fld _count1 		; завантаження змінної count1 у верхівку стеку
fsub _const3 	;віднімання константи
fdiv st(1), st(0) 	;ділення вмісту регістрів
fstp st(0) 	 	;збереження результату у верхівці стеку
fld _result 		 ;завантаження _ result у верхівку стеку
fmul st(0),st(1)  	; множення значення з верхівки стеку на значення з першого
fstp _result 		; збереження значення у змінну _result

m1: ; мітка m1

add ecx,1
fld _one
fld _count1                          ;операціії зі значеннями для виконання
fadd st(0), st(1)                   ;наступної ітерації
fstp _count1
add _count ,1


.IF ecx > ebx 
fld _result                       ;умова для виходу з циклу
.BREAK
.ENDIF
.ENDW

invoke FpuFLtoA, 0, 10, ADDR _res1, SRC1_FPU or SRC2_DIMM
invoke MessageBox, 0, offset _text, offset _title, MB_ICONINFORMATION
invoke ExitProcess, 0
 
end start ; завершення програми
