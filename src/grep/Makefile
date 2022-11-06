GCC = gcc  -Wall -Werror -Wextra -std=c11 -lm -lpcre


all: s21_grep

s21_grep: Makefile s21_grep.h s21_grep.c
	$(GCC) s21_grep.c -c -o s21_grep.o -lpcre
	$(GCC) s21_grep.o -o s21_grep -lpcre 

check:
	clang-format -style=Google -n *.c
	
test:
	bash test.sh
	sh test_func_grep.sh

leaks:
	sh test_leak_grep.sh

valgrind:
	bash test_ERROR_VALGRIND.sh

rebuild:
	make clean
	make all

clean:
	rm -f s21_grep *.o
