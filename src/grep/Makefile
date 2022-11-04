GCC = gcc  -Wall -Werror -Wextra -std=c11 -D_GNU_SOURCE -lm


all: s21_grep

s21_grep: Makefile s21_grep.h s21_grep.c
	 $(GCC) s21_grep.c -lpcre -c -o s21_grep.o
	$(GCC) s21_grep.o -lpcre -o s21_grep

check:
	clang-format -style=Google -n *.c
	
test:
	bash test.sh

rebuild:
	make clean
	make all

clean:
	rm -f s21_grep *.o
