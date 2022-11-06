#!/bin/bash

TEMPLATE_FILE="./TEST_FILES/example.txt"
TEMPLATE_FILE1="./TEST_FILES/big_test/test_0_grep.txt"
TEMPLATE_FILE2="./TEST_FILES/big_test/test_1_grep.txt"
TEMPLATE_FILE4="./TEST_FILES/big_test/test_2_grep.txt"
TEMPLATE_FILE5="./TEST_FILES/big_test/test_4_grep.txt"
TEMPLATE_FILE6="./TEST_FILES/big_test/test_5_grep.txt"
TEMPLATE_FILE7="./TEST_FILES/big_test/test_6_grep.txt"
TEMPLATE_FILE8="./TEST_FILES/big_test/test_ptrn_grep.txt"
TEMPLATE_FILE9="./TEST_FILES/big_test/test_3_grep.txt"

SUCCESS=0
FAIL=0
COUNTER=0
RESULT=0
DIFF_RES=""

declare -a tests=(
"s ${TEMPLATE_FILE1} VAR"
"for s21_grep.c s21_grep.h Makefile VAR"
"for s21_grep.c VAR"
"-e ^int s21_grep.c s21_grep.h Makefile "
"-e for s21_grep.c "
"-e lpcre s21_grep.c ${TEMPLATE_FILE8}"
"-e void s21_grep.c Makefile  ${TEMPLATE_FILE8}"
"VAR no_file.txt"
)

declare -a extra=(
"-n for ${TEMPLATE_FILE2} ${TEMPLATE_FILE4}"
"-n for ${TEMPLATE_FILE2}"
"-n  ^\} ${TEMPLATE_FILE2}"
"-c  /\ ${TEMPLATE_FILE2}"
"-c ^int ${TEMPLATE_FILE2} ${TEMPLATE_FILE4}"
"-e ^int ${TEMPLATE_FILE2}"
"-n = ${TEMPLATE_FILE2} ${TEMPLATE_FILE4}"
"-i INT ${TEMPLATE_FILE6}"
"-e 234 ${TEMPLATE_FILE2} ${TEMPLATE_FILE4}"
"-n out ${TEMPLATE_FILE6}"
"-i int ${TEMPLATE_FILE6}"
"-i int ${TEMPLATE_FILE6}"
"-c aboba test_1.txt ${TEMPLATE_FILE6}"
"-v ${TEMPLATE_FILE2} ank"
"-n ) ${TEMPLATE_FILE6}"
"-l for ${TEMPLATE_FILE2} ${TEMPLATE_FILE4}"
"-o int ${TEMPLATE_FILE5}"
"-e out ${TEMPLATE_FILE6}"
"-e as ${TEMPLATE_FILE7}"
"-e ing  ${TEMPLATE_FILE7}"
"-c where ${TEMPLATE_FILE2}"
"-l for no_file.txt ${TEMPLATE_FILE4}"
"-f ${TEMPLATE_FILE9} ${TEMPLATE_FILE6}"
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
        echo -e "$FAIL/$SUCCESS/$COUNTER success grep $t"
    else
      (( FAIL++ ))
        echo -e "$FAIL/$SUCCESS/$COUNTER fail grep $t"
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


echo -e "\033[31mFAIL: $FAIL\033[0m"
echo -e "\033[32mSUCCESS: $SUCCESS\033[0m"
echo "ALL: $COUNTER"
