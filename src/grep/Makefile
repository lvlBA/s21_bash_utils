GCC = gcc  -Wall -Werror -Wextra -std=c11 -lm -lpcre


all: s21_grep

s21_grep: Makefile s21_grep.h s21_grep.c
	$(GCC) s21_grep.c -c -o s21_grep.o -lpcre
	$(GCC) s21_grep.o -o s21_grep -lpcre 

check: clean all
	cp ../../materials/linters/.clang-format ../../src/.clang-format
	clang-format -style=Google -n s21_grep.c s21_grep.h
	rm ../.clang-format
	
test: clean all
	bash test.sh
	bash test_func_grep.sh
	make clean

leaks: clean all
	sh test_leak_grep.sh

valgrind: clean all
	bash test_ERROR_VALGRIND.sh

rebuild: clean all

clean:
	rm -rf s21_grep s21_grep.dSYM *.o
