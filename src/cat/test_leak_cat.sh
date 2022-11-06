#!/bin/bash

TEMPLATE_FILE0="./TEST_FILES/b_test/test_1_cat.txt"
TEMPLATE_FILE1="./TEST_FILES/b_test/test_2_cat.txt"
TEMPLATE_FILE2="./TEST_FILES/b_test/test_3_cat.txt"
TEMPLATE_FILE3="./TEST_FILES/b_test/test_4_cat.txt"
TEMPLATE_FILE4="./TEST_FILES/b_test/test_5_cat.txt"

SUCCESS=0
FAIL=0
COUNTER=0
RESULT=0
DIFF_RES=""

declare -a tests=(
"VAR ./TEST_FILES/b_test/test_case_cat.txt"
"VAR no_file.txt"
)

declare -a extra=(
"-s ${TEMPLATE_FILE0}"
"-b -e -n -s -t -v ${TEMPLATE_FILE0}"
"-t ${TEMPLATE_FILE2}"
"-n ${TEMPLATE_FILE2}"
"no_file.txt"
"-n -b ${TEMPLATE_FILE0}"
"-s -n -e ${TEMPLATE_FILE3}"
"${TEMPLATE_FILE0} -n"
"-n ${TEMPLATE_FILE0}"
"-n ${TEMPLATE_FILE0} ${TEMPLATE_FILE2}"
"-v ${TEMPLATE_FILE4}"
)

testing()
{
    t=$(echo $@ | sed "s/VAR/$var/")
    leaks -quiet -atExit -- ./s21_cat $t > test_s21_cat.log
    leak=$(grep -A100000 leaks test_s21_cat.log)
    (( COUNTER++ ))
    if [[ $leak == *"0 leaks for 0 total leaked bytes"* ]]
    then
      (( SUCCESS++ ))
        echo "\033[31m$FAIL\033[0m/\033[32m$SUCCESS\033[0m/$COUNTER \033[32msuccess\033[0m cat $t"
    else
      (( FAIL++ ))
        echo "\033[31m$FAIL\033[0m/\033[32m$SUCCESS\033[0m/$COUNTER \033[31mfail\033[0m cat $t"
#        echo "$leak"
    fi
    rm test_s21_cat.log
}

# специфические тесты
for i in "${extra[@]}"
do
    var="-"
    testing $i
done

# 1 параметр
for var1 in b e n s t v
do
    for i in "${tests[@]}"
    do
        var="-$var1"
        testing $i
    done
done

# 2 параметра
for var1 in b e n s t v
do
    for var2 in b e n s t v
    do
        if [ $var1 != $var2 ]
        then
            for i in "${tests[@]}"
            do
                var="-$var1 -$var2"
                testing $i
            done
        fi
    done
done

# 3 параметра
for var1 in b e n s t v
do
    for var2 in b e n s t v
    do
        for var3 in b e n s t v
        do
            if [ $var1 != $var2 ] && [ $var2 != $var3 ] && [ $var1 != $var3 ]
            then
                for i in "${tests[@]}"
                do
                    var="-$var1 -$var2 -$var3"
                    testing $i
                done
            fi
        done
    done
done


echo "\033[31mFAIL: $FAIL\033[0m"
echo "\033[32mSUCCESS: $SUCCESS\033[0m"
echo "ALL: $COUNTER"
