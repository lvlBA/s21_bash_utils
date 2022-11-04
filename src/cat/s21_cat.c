#include "s21_cat.h"

int main(int argc, char *argv[]) {
  opt options = {0};
  if (argc > 1) {
    parser(argc, argv, &options);
  }
  return 0;
}

void parser(int argc, char **argv, struct options *opt) {
  int count = 1;
  int x = argc;
  while (count != argc) {
    if (argv[count][0] == '-' && x != count - 1) {
      if (argv[count][1] == '-') {
        check_gnu(count, argv, opt);
      } else if (argv[count][1] != '-') {
        size_t count2 = 1;
        while (count2 != strlen(argv[count])) {
          switch (argv[count][count2]) {
            case 'b':
              opt->b = 1;
              break;
            case 'e':
              opt->e = 1;
              opt->v = 1;
              break;
            case 'E':
              opt->e = 1;
              break;
            case 'n':
              opt->n = 1;
              break;
            case 's':
              opt->s = 1;
              break;
            case 't':
              opt->t = 1;
              opt->v = 1;
              break;
            case 'T':
              opt->t = 1;
              break;
            case 'v':
              opt->v = 1;
              break;
            default:
              fprintf(stderr, "usage: [-benstv] [file ...]");
              exit(1);
          }
          count2++;
        }
      }

    } else if ((argv[count][0] != '-') ||
               (argv[count][0] == '-' && x == count - 1)) {
      reader(argv, opt, count);
    }
    count++;
  }
}

void check_gnu(int count, char **argv, struct options *opt) {
  if (!strcmp(argv[count], "--number-nonblank")) {
    opt->b = 1;
  }
  if (!strcmp(argv[count], "--squeeze-blank")) {
    opt->s = 1;
  }
  if (!strcmp(argv[count], "--number")) {
    opt->n = 1;
  }
}

void print_number(int number) { printf("%6d\t", number); }

void print_char(char fut_char) { fprintf(stdout, "%c", fut_char); }

void reader(char **argv, struct options *opt, int count) {
  if (opt->n == 1 && opt->b == 1) {
    opt->n = 0;
  }
  int previous_is_empty = 0, first_sym_string = 1, counter = 0,
      counter_empty = 0;
  FILE *file = fopen(argv[count], "r");
  char fut_char = '\0';
  if (file != NULL) {
    while (!feof(file)) {
      fut_char = fgetc(file);
      if (feof(file)) {
        break;
      }

      if (opt->s && previous_is_empty && fut_char == '\n' && first_sym_string) {
        continue;
      }

      if (opt->n && first_sym_string) {
        print_number(++counter);
      }

      if (opt->e && fut_char == '\n') {
        printf("$");
      }

      if (opt->b && first_sym_string && fut_char != '\n') {
        print_number(++counter_empty);
      }

      if (opt->v) {
        if (fut_char == 127) {
          fut_char = '?';
          printf("^");
        }
        if (fut_char < 32 && fut_char != 9 && fut_char != 10) {
          fut_char += 64;
          printf("^");
        }
      }

      if (opt->t && fut_char == '\t') {
        printf("^I");
      } else {
        print_char(fut_char);
      }

      if (first_sym_string && fut_char == '\n') {
        previous_is_empty = 1;
      } else {
        previous_is_empty = 0;
      }
      if (fut_char == '\n') {
        first_sym_string = 1;
      } else {
        first_sym_string = 0;
      }
    }
  } else {
    fprintf(stderr, "No such file or directory");
    return;
  }
  fclose(file);
}
