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

install_brew:
	cd ~
	curl -fsSL https://rawgit.com/kube/42homebrew/master/install.sh | zsh
	brew install lcov

install_valgrind:
	brew install --HEAD LouisBrunner/valgrind/valgrind

valgrind:
	CK_FORK=no valgrind --undef-value-errors=yes --leak-check=full --show-leak-kinds=all --track-origins=yes --verbose --log-file=RESULT_VALGRIND.txt ./s21_grep -n while s21_grep.c s21_grep.h


rebuild:
	make clean
	make all

clean:
	rm -f s21_grep *.o
