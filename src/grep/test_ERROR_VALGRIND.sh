#!/bin/bash

SUCCESS=0
FAIL=0
COUNTER=0
RESULT=0
DIFF_RES=""

declare -a tests=(
"s test_text_grep.txt VAR"
"for s21_grep.c s21_grep.h Makefile VAR"
"for s21_grep.c VAR"
"-e for ^int s21_grep.c s21_grep.h Makefile VAR"
"-e for ^int s21_grep.c VAR"
"-e regex ^print s21_grep.c VAR test_ptrn_grep.txt"
"-e while void s21_grep.c Makefile VAR test_ptrn_grep.txt"
"VAR no_file.txt"
)

declare -a extra=(
"-n for test_1_grep.txt test_2_grep.txt"
"-n for test_1_grep.txt"
"-n ^\} test_1_grep.txt"
"-c /\ test_1_grep.txt"
"-c ^int test_1_grep.txt test_2_grep.txt"
"-e ^int test_1_grep.txt"
"-n = test_1_grep.txt test_2_grep.txt"
"-e"
"-i INT test_5_grep.txt"
"-e test_1_grep.txt test_2_grep.txt"
"-n =  out test_5_grep.txt"
"-i int test_5_grep.txt"
"-i int test_5_grep.txt"
"-c  aboba test_1.txt test_5_grep.txt"
"-v test_1_grep.txt  ank"
"-n ) test_5_grep.txt"
"-l for test_1_grep.txt test_2_grep.txt"
"-o  int test_4_grep.txt"
"-e =  out test_5_grep.txt"
"-n ing  as  the not  is test_6_grep.txt"
"-e ing as  the  not  is test_6_grep.txt"
"-c . test_1_grep.txt "
"-l for no_file.txt test_2_grep.txt"
"-f test_3_grep.txt test_5_grep.txt"
)

testing()
{
    t=$(echo $@ | sed "s/VAR/$var/")
        CK_FORK=no valgrind --vgdb=no --leak-check=full --show-leak-kinds=all --track-origins=yes --verbose --log-file=RESULT_VALGRIND.txt ./s21_grep $t > test_s21_grep.log
        leak=$(grep ERROR RESULT_VALGRIND.txt)
        (( COUNTER++ ))
        if [[ $leak == *"ERROR SUMMARY: 0 errors from 0 contexts (suppressed: 0 from 0)"* ]]
        then
          (( SUCCESS++ ))
        echo "$FAIL/$SUCCESS/$COUNTER success grep $t"
    else
      (( FAIL++ ))
        echo "$FAIL/$SUCCESS/$COUNTER fail grep $t"
#        echo "$leak"
    fi
    rm test_s21_grep.log
    rm RESULT_VALGRIND.txt
}

# специфические тесты
for i in "${extra[@]}"
do
    var="-"
    testing $i
done

# 1 параметр
for var1 in v c l n h o
do
    for i in "${tests[@]}"
    do
        var="-$var1"
        testing $i
    done
done
#
## 2 параметра
#for var1 in v c l n h o
#do
#    for var2 in v c l n h o
#    do
#        if [ $var1 != $var2 ]
#        then
#            for i in "${tests[@]}"
#            do
#                var="-$var1 -$var2"
#                testing $i
#            done
#        fi
#    done
#done
#
## 3 параметра
#for var1 in v c l n h o
#do
#    for var2 in v c l n h o
#    do
#        for var3 in v c l n h o
#        do
#            if [ $var1 != $var2 ] && [ $var2 != $var3 ] && [ $var1 != $var3 ]
#            then
#                for i in "${tests[@]}"
#                do
#                    var="-$var1 -$var2 -$var3"
#                    testing $i
#                done
#            fi
#        done
#    done
#done
#
## 2 сдвоенных параметра
#for var1 in v c l n h o
#do
#    for var2 in v c l n h o
#    do
#        if [ $var1 != $var2 ]
#        then
#            for i in "${tests[@]}"
#            do
#                var="-$var1$var2"
#                testing $i
#            done
#        fi
#    done
#done
#
## 3 строенных параметра
#for var1 in v c l n h o
#do
#    for var2 in v c l n h o
#    do
#        for var3 in v c l n h o
#        do
#            if [ $var1 != $var2 ] && [ $var2 != $var3 ] && [ $var1 != $var3 ]
#            then
#                for i in "${tests[@]}"
#                do
#                    var="-$var1$var2$var3"
#                    testing $i
#                done
#            fi
#        done
#    done
#done

echo "\033[31mFAIL: $FAIL\033[0m"
echo "\033[32mSUCCESS: $SUCCESS\033[0m"
echo "ALL: $COUNTER"
