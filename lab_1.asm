.686	; директива визначення типа мікропроцесора
.model flat, stdcall	; задання лінійної моделі пам’яті та угоди ОС Windows
option casemap:none	;вказує, що повинен розглядати всі ідентифікатори 
include \masm32\include\windows.inc 	; директива використовується для включення файлу windows.inc з каталогу \masm32\include
include \masm32\include\kernel32.inc 	; директива використовується для включення файлу kernel32.inc з каталогу \masm32\include
include \masm32\include\user32.inc; директива використовується для включення файлу user32.inc з каталогу \masm32\include
includelib \masm32\lib\user32.lib; директива використовується для зв’язування файлу бібліотеки user32.lib з каталогу \masm32\lib
includelib \masm32\lib\kernel32.lib; директива використовується для зв’язування файлу бібліотеки kernel32.lib з каталогу \masm32\lib
firstfunc PROTO _d:DWORD,_const1:DWORD,_c1:DWORD,_const2:DWORD,_a:DWORD,_c2:DWORD
.data   ; d/3c-15ac директива визначення ініциалізірованих даних 300/3*1-15*2*1=70
d dd 300	; визначення  d як змінної подвійного слова зі значенням 300
const1 dd 3;	 визначення  const1 як змінної подвійного слова зі значенням 3
c1 dd 1		; визначення  c1 як змінної подвійного слова зі значенням 1
const2 dd 15	; визначення  const2 як змінної подвійного слова зі значенням 15
a dd 2	; визначення a як змінної подвійного слова зі значенням 2
c2 dd 1; визначення  c2 як змінної подвійного слова зі значенням 1
_temp1 dd ?,0; визначення  _temp1 змінної як змінної подвійного слова з початковим значенням 0
_title db "Лабораторна робота №1. Арифм. операції",0	; визначення _title змінної рядкових даних 
strbuf dw ?,0	; визначення strbuf змінної даних подвійного слова з початковим значенням 0
_text db "masm32. Вивід результата d/3c-15ac через MessageBox:",0ah,"Результат: %d — ціла частина",0ah, 0ah,
"Krykunova Anastasiia",0	;визначення _text змінної рядкових даних із закінченням нулем 
.code; директива початку коду програми
firstfunc proc _d:DWORD,_const1:DWORD,_c1:DWORD,_const2:DWORD,_a:DWORD,_c2:DWORD ;оголошення початку для  функції з 6 аргументами d, const1, c1, const2, a, c2
mov eax,_d	; перемістити значення "_d" в регістр eax
mul _c1		; помножимо значення в eax на "_c1" і збережемо результат в EAX
div _const1	; розділити значення в EDX:EAX на "_const1" і зберегти частку в EAX
mov _temp1, eax	; перемістіть значення в EAX до змінної "_temp1".
mov eax, _const2	; перемістити значення "_const2" до реєстру EAX
mul _a	; помножте значення в EAX на "_a" і збережіть результат у EAX
mul _c2		; помножте значення в EAX на "_c2" і збережіть результат у EAX
sub _temp1,eax		; віднімання, результат множення _a і _c2 від значення, що зберігається в _temp1
ret 	; повернення управління ОС
firstfunc endp		; кінець функції firstfunc
start:		;  запуск основної функції програми
invoke firstfunc,d,const1,c1,const2,a,c2		; викличте процедуру firstfunc із зазначеними параметрами
invoke wsprintf, ADDR strbuf, ADDR _text,_temp1	; відформатуйте рядок за допомогою функції wsprintf, зберігаючи результат у strbuf
invoke MessageBox, NULL, addr strbuf, addr _title, MB_ICONINFORMATION	; відобразити вікно повідомлення, що містить відформатований рядок
invoke ExitProcess, 0	; вийти з програми
END start	; закінчення програми з ім’ям start

