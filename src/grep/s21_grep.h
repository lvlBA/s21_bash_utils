#ifndef SRC_GREP_S21_GREP_H_
#define SRC_GREP_S21_GREP_H_

#include <pcre.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
// #define _GNU_SOURCE

typedef struct options {
  int e, c, n, v, l, i, s, o, f, h;
} opt;

void parser(int argc, char *argv[], struct options *opt);
void reader(char **argv, struct options *opt, int tmp, char *bufer, int argc,
            int flag);
void transformation(char *line, char *bufer, int *quantity, struct options *opt,
                    int *number, int argc, char **argv, int tmp, int flag,
                    int *previous_is_enter);
void check_the_flag(struct options *opt);
void feel_buffer(char **argv, struct options *opt, int argc, int flag);
void option_c(int quantity, char **argv, int tmp, int argc);
void option_v(char *line, char **argv, int tmp, int argc);
void option_o(int argc, char **argv, char *line, int tmp, char *bufer);
void option_f(char **argv, struct options *opt, int tmp, char *bufer, int argc,
              int flag);
void option(int quantity);
#endif  // SRC_GREP_S21_GREP_H_