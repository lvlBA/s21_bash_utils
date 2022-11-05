#include "s21_grep.h"

#include <pcre.h>

int main(int argc, char *argv[]) {
  opt options = {0};
  if (argc > 1) {
    parser(argc, argv, &options);
  }
  return 0;
}

void parser(int argc, char *argv[], struct options *opt) {
  int count = 1, flag = 0;
  size_t for_flag = 1;
  while (count != argc) {
    if (argv[count][0] == '-') {
      flag += 1;
      while (for_flag != strlen(argv[count])) {
        switch (argv[count][for_flag]) {
          case 'e':
            opt->e = 1;
            break;
          case 'i':
            opt->i = 1;
            break;
          case 'v':
            opt->v = 1;
            break;
          case 'c':  // kosyak posmotret
            opt->c = 1;
            break;
          case 'l':
            opt->l = 1;
            break;
          case 'n':  // kosyak posmotret
            opt->n = 1;
            break;
          case 'h':
            opt->h = 1;
            break;
          case 's':
            opt->s = 1;
            break;
          case 'f':
            opt->f = 1;
            break;
          case 'o':
            opt->o = 1;
            break;
          default:
            fprintf(stderr, "usage: [-eivclnhsf_file] [file ...]");
        }
        for_flag++;
      }
    }
    count++;
  }
  feel_buffer(argv, opt, argc, flag);
}

void feel_buffer(char **argv, struct options *opt, int argc, int flag) {
  char *bufer = NULL;
  int tmp = 1;
  size_t counter = 0;
  while (tmp != argc) {
    if (counter && argv[tmp][0] != '-') {
      check_the_flag(opt);
      reader(argv, opt, tmp, bufer, argc, flag);
    } else if (counter == 0 && argv[tmp][0] != '-') {
      while (counter != strlen(argv[tmp])) {
        bufer = realloc(bufer, ++counter * sizeof(bufer));
        bufer[counter - 1] = argv[tmp][counter - 1];
      }
      bufer[counter] = '\0';
    }
    tmp++;
  }
  free(bufer);
}

void reader(char **argv, struct options *opt, int count, char *bufer, int argc,
            int flag) {
  FILE *file = fopen(argv[count], "r");
  char line[8000] = {0};
  char *read;
  int previous_is_enter = 999;
  int quantity = 0, number = 1;
  if (opt->f) {
    option_f(argv, opt, count, bufer, argc, flag);
  } else if (file != NULL) {
    while ((read = fgets(line, 7998, file))) {
      transformation(line, bufer, &quantity, opt, &number, argc, argv, count,
                     flag, &previous_is_enter);
      number++;
    }

    if ((read == NULL && previous_is_enter == 0) &&
        (opt->i || opt->h || opt->n || opt->e)) {
      printf("\n");
      previous_is_enter = 999;
    }

    if (opt->c) {
      option_c(quantity, argv, count, argc);
    }
    if (opt->l && quantity >= 1) {
      printf("%s\n", argv[count]);
    }
  } else {
    if (opt->s) {
      return;
    }
    fprintf(stderr, "%s: No such file or directory\n", argv[count]);
  }
  fclose(file);
}

void transformation(char *line, char *bufer, int *quantity, struct options *opt,
                    int *number, int argc, char **argv, int count, int flag,
                    int *previous_is_enter) {
  pcre *f;                  /* variable to store transformated sample */
  pcre_extra *f_ext = NULL; /* variable to store additional data */
  const char *errstr;       /* error message buffer */
  int errchar;              /* number of sym */
  int vector[8000];         /* array for result */
  int vecsize = 8000;       /* size of array */
  int pairs;                /* q-ty pairs */
  if (opt->i) {
    f = pcre_compile(bufer, PCRE_CASELESS | PCRE_MULTILINE, &errstr, &errchar,
                     NULL);
  } else {
    f = pcre_compile(bufer, 0 | PCRE_MULTILINE, &errstr, &errchar, NULL);
  }
  if ((pairs = pcre_exec(f, f_ext, line, strlen(line), 0, PCRE_NOTEMPTY, vector,
                         vecsize)) > 0) {
    *quantity += 1;
    if (((opt->e || opt->i) && argc == 3 && flag == 0) ||
        ((opt->e || opt->i) && argc == 4 && flag == 1)) {
      printf("%s", line);
      *previous_is_enter = line[strlen(line) - 1] == 10 ? 1 : 0;
    } else if (((opt->e || opt->i) && argc >= 4 && flag == 0) ||
               ((opt->e || opt->i) && argc > 4 && flag == 1)) {
      printf("%s:", argv[count]);
      printf("%s", line);
      *previous_is_enter = line[strlen(line) - 1] == 10 ? 1 : 0;
    } else if (((!opt->e || opt->i) && argc >= 4 && flag == 1) && (opt->h)) {
      printf("%s", line);
      *previous_is_enter = line[strlen(line) - 1] == 10 ? 1 : 0;
    }
    if (opt->n) {
      if (argc == 4) {
        printf("%d:%s", *number, line);
      } else if (argc > 4) {
        printf("%s:", argv[count]);
        printf("%d:%s", *number, line);
      }
      *previous_is_enter = line[strlen(line) - 1] == 10 ? 1 : 0;
    }
    if (opt->o && argc >= 4) {
      option_o(argc, argv, line, count, bufer);
    }
  } else {
    if (opt->v) {
      option_v(line, argv, count, argc);
    }
  }
  free(f);
}

void check_the_flag(struct options *opt) {
  if (!opt->e && !opt->i && !opt->v && !opt->c && !opt->l && !opt->n &&
      !opt->h && !opt->s && !opt->f && !opt->o) {
    opt->e = 1;
  } else if (!opt->e && !opt->i && !opt->v && !opt->c && !opt->l && !opt->n &&
             !opt->h && !opt->s && opt->f && !opt->o) {
    opt->e = 1;
  } else if (!opt->e && !opt->i && !opt->v && !opt->c && !opt->l && !opt->n &&
             !opt->h && opt->s && !opt->f && !opt->o) {
    opt->e = 1;
  }
}

void option_c(int quantity, char **argv, int count, int argc) {
  if (argc == 4) {
    printf("%d\n", quantity);
  } else if (argc > 4) {
    printf("%s:", argv[count]);
    printf("%d\n", quantity);
  }
}

void option_v(char *line, char **argv, int count, int argc) {
  int x = strlen(line);
  if (argc == 4) {
    printf("%s", line);
    if (line[x - 1] != 10) {
      printf("\n");
    }
  } else if (argc > 4) {
    printf("%s:", argv[count]);
    printf("%s", line);
    if (line[x - 1] != 10) {
      printf("\n");
    }
  }
}

void option_o(int argc, char **argv, char *line, int count, char *bufer) {
  int flag_print_fail = 0, schet = 0;
  int qntity = strlen(bufer);
  for (long unsigned int i = 0; i < strlen(line); i++) {
    if (line[i] == bufer[schet]) {
      schet += 1;
    } else if (schet > 0 && line[i] != bufer[schet]) {
      schet = 0;
    }
    if (schet == qntity) {
      if (flag_print_fail == 0 && argc > 4) {
        printf("%s:", argv[count]);
        printf("%s\n", bufer);
        flag_print_fail = 1;
        schet = 0;
      } else {
        printf("%s\n", bufer);
        schet = 0;
      }
    }
  }
}

void option_f(char **argv, struct options *opt, int count, char *bufer,
              int argc, int flag) {
  int quantity = 0, number = 1;
  int previous_is_empty;
  char *read, *read2;
  char line[8000] = {0};
  char line2[8000] = {0};
  FILE *file2 = fopen(bufer, "r");
  int empty_line = 0;
  if (file2 != NULL) {
    while ((read2 = fgets(line2, 7998, file2))) {
      FILE *file = fopen(argv[count], "r");

      if (empty_line == 1) {
        continue;
      }
      if (file != NULL) {
        while ((read = fgets(line, 7998, file))) {
          if (line2[0] == 10 && line[0] == 10) {
            printf("%s", line2);
            empty_line = 1;
            continue;
          } else if (line2[0] == 10 && line[0] == 10) {
            continue;
          } else {
            transformation(line, line2, &quantity, opt, &number, argc, argv,
                           count, flag, &previous_is_empty);
          }
        }
      } else {
        fprintf(stderr, "No such file or directory\n");
        return;
      }
      fclose(file);
    }
  }
  fclose(file2);
}
