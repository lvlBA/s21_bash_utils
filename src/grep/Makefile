GCC = gcc  -Wall -Werror -Wextra -std=c11 -lm


all: s21_grep

s21_grep: Makefile s21_grep.h s21_grep.c
	$(GCC) s21_grep.c -lpcre -c -o s21_grep.o
	$(GCC) s21_grep.o -lpcre -o s21_grep

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
	CK_FORK=no valgrind  --vgdb=no --leak-check=full --show-leak-kinds=all --track-origins=yes --verbose --log-file=RESULT_VALGRIND.txt ./s21_grep -n while s21_grep.c 


rebuild:
	make clean
	make all

clean:
	rm -f s21_grep *.o
