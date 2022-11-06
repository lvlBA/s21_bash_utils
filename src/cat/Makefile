FLAGS = -Wall -Wextra -Werror -std=c11

all: s21_cat 

s21_cat: Makefile s21_cat.h s21_cat.c
	gcc $(FLAGS) s21_cat.c -o s21_cat

check: clean all
	cp ../../materials/linters/.clang-format ../../src/.clang-format
	clang-format -style=Google -n s21_cat.c s21_cat.h
	rm ../.clang-format

test: clean all
	bash test_func_cat.sh

leaks: clean all
	bash test_leak_cat.sh

rebuild: clean all

clean:
	rm -rf s21_cat
