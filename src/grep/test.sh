TEMPLATE_FILE="./TEST_FILES/bufer.txt"
TEST_FILE="./TEST_FILES/example.txt"
TEST_FILE_SECOND="./TEST_FILES/example2.txt"
TEST_FILE_THIRD="e3.txt"
TEMPLATE="[0-9]"
THE_SECOND_TEMPLATE="hello"
THE_THIRD_TEMPLATE="11"


grep -e ${TEMPLATE} ${TEST_FILE} > ORIG.txt && ./s21_grep -e ${TEMPLATE} ${TEST_FILE} > MINE.txt && diff -s ORIG.txt MINE.txt
grep -e ${THE_THIRD_TEMPLATE} ${TEST_FILE} > ORIG.txt && ./s21_grep -e ${THE_THIRD_TEMPLATE} ${TEST_FILE} > MINE.txt && diff -s ORIG.txt MINE.txt
grep -e ${THE_THIRD_TEMPLATE} ${TEST_FILE} ${TEST_FILE_SECOND}> ORIG.txt && ./s21_grep -e ${THE_THIRD_TEMPLATE} ${TEST_FILE} ${TEST_FILE_SECOND} > MINE.txt && diff -s ORIG.txt MINE.txt
grep -i ${THE_SECOND_TEMPLATE} ${TEST_FILE} ${TEST_FILE_SECOND}> ORIG.txt && ./s21_grep -i ${THE_SECOND_TEMPLATE} ${TEST_FILE} ${TEST_FILE_SECOND} > MINE.txt && diff -s ORIG.txt MINE.txt
grep -i ${THE_SECOND_TEMPLATE} ${TEST_FILE} > ORIG.txt && ./s21_grep -i ${THE_SECOND_TEMPLATE} ${TEST_FILE} > MINE.txt && diff -s ORIG.txt MINE.txt
grep -v ${TEMPLATE} ${TEST_FILE} > ORIG.txt && ./s21_grep -v ${TEMPLATE} ${TEST_FILE} > MINE.txt && diff -s ORIG.txt MINE.txt
grep -v ${TEMPLATE} ${TEST_FILE} ${TEST_FILE_SECOND}> ORIG.txt && ./s21_grep -v ${TEMPLATE} ${TEST_FILE} ${TEST_FILE_SECOND}> MINE.txt && diff -s ORIG.txt MINE.txt
grep -c ${TEMPLATE} ${TEST_FILE} > ORIG.txt && ./s21_grep -c ${TEMPLATE} ${TEST_FILE} > MINE.txt && diff -s ORIG.txt MINE.txt
grep -c ${TEMPLATE} ${TEST_FILE} ${TEST_FILE_SECOND}> ORIG.txt && ./s21_grep -c ${TEMPLATE} ${TEST_FILE} ${TEST_FILE_SECOND}> MINE.txt && diff -s ORIG.txt MINE.txt
grep -l ${TEMPLATE} ${TEST_FILE} > ORIG.txt && ./s21_grep -l ${TEMPLATE} ${TEST_FILE} > MINE.txt && diff -s ORIG.txt MINE.txt
grep -l ${TEMPLATE} ${TEST_FILE} ${TEST_FILE_SECOND}> ORIG.txt && ./s21_grep -l ${TEMPLATE} ${TEST_FILE} ${TEST_FILE_SECOND}> MINE.txt && diff -s ORIG.txt MINE.txt
grep -n ${TEMPLATE} ${TEST_FILE} > ORIG.txt && ./s21_grep -n ${TEMPLATE} ${TEST_FILE} > MINE.txt && diff -s ORIG.txt MINE.txt
grep -n ${TEMPLATE} ${TEST_FILE} ${TEST_FILE_SECOND}> ORIG.txt && ./s21_grep -n ${TEMPLATE} ${TEST_FILE} ${TEST_FILE_SECOND}> MINE.txt && diff -s ORIG.txt MINE.txt
grep -h ${TEMPLATE} ${TEST_FILE} ${TEST_FILE_SECOND} > ORIG.txt && ./s21_grep -h ${TEMPLATE} ${TEST_FILE} ${TEST_FILE_SECOND} > MINE.txt && diff -s ORIG.txt MINE.txt
grep -s ${TEMPLATE} ${TEST_FILE} ${TEST_FILE_THIRD} > ORIG.txt
./s21_grep -s ${TEMPLATE} ${TEST_FILE} ${TEST_FILE_THIRD} > MINE.txt && diff -s ORIG.txt MINE.txt
grep -f ${TEMPLATE_FILE} ${TEST_FILE} > ORIG.txt && ./s21_grep -f ${TEMPLATE_FILE} ${TEST_FILE} > MINE.txt && diff -s ORIG.txt MINE.txt
grep -o ${THE_THIRD_TEMPLATE} ${TEST_FILE} > ORIG.txt && ./s21_grep -o ${THE_THIRD_TEMPLATE} ${TEST_FILE} > MINE.txt && diff -s ORIG.txt MINE.txt
rm -f ORIG.txt MINE.txt
