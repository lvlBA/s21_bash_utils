#ifndef SRC_CAT_S21_CAT_H_
#define SRC_CAT_S21_CAT_H_

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct options {
  int b, e, n, s, t, v;
} opt;

void parser(int argc, char *argv[], struct options *opt);
void reader(char *argv[], struct options *opt, int count);
void print_number(int number);
void print_char(char fut_char);
void check_gnu(int count, char **argv, struct options *opt);
#endif  // SRC_CAT_S21_CAT_H_