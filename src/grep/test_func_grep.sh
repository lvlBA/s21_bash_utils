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
DIFF_RES=""

declare -a tests=(
"s ${TEMPLATE_FILE1} VAR"
"for s21_grep.c s21_grep.h Makefile VAR"
"for s21_grep.c VAR"
"VAR for ^int s21_grep.c s21_grep.h Makefile"
"VAR for ^int s21_grep.c"
"VAR ^print s21_grep.c ${TEMPLATE_FILE8}"
"-e while void s21_grep.c Makefile ${TEMPLATE_FILE8}"
)

declare -a extra=(
"-e '[0-9]' ${TEMPLATE_FILE}"
"-n for ${TEMPLATE_FILE2} ${TEMPLATE_FILE4}"
"-n for ${TEMPLATE_FILE1}"
"-e ^int ${TEMPLATE_FILE2}"
"-l for ${TEMPLATE_FILE2} ${TEMPLATE_FILE4}"
"-o int ${TEMPLATE_FILE4}"
"-e out ${TEMPLATE_FILE6}"
"-e ing ${TEMPLATE_FILE7}"
"-c . ${TEMPLATE_FILE2}"
"-l for no_file.txt ${TEMPLATE_FILE4}"
"-f ${TEMPLATE_FILE9} ${TEMPLATE_FILE6}"
)


testing()
{
    t=$(echo $@ | sed "s/VAR/$var/")
    ./s21_grep $t > test_s21_grep.log
    grep $t > test_sys_grep.log
    DIFF_RES="$(diff -s test_s21_grep.log test_sys_grep.log)"
    (( COUNTER++ ))
    if [ "$DIFF_RES" == "Files test_s21_grep.log and test_sys_grep.log are identical" ]
    then
      (( SUCCESS++ ))
      echo "\033[31m$FAIL\033[0m/\033[32m$SUCCESS\033[0m/$COUNTER \033[32msuccess\033[0m grep $t"
    else
      (( FAIL++ ))
      echo "\033[31m$FAIL\033[0m/\033[32m$SUCCESS\033[0m/$COUNTER \033[31mfail\033[0m grep $t"
    fi
    rm test_s21_grep.log test_sys_grep.log
}

## специфические тесты
for i in "${extra[@]}"
do
    var="-"
    testing $i
done

# 1 параметр
for var1 in v c l n h o i s
do
    for i in "${tests[@]}"
    do
        var="-$var1"
        testing $i
    done
done


echo "\033[31mFAIL: $FAIL\033[0m"
echo "\033[32mSUCCESS: $SUCCESS\033[0m"
echo "ALL: $COUNTER"
