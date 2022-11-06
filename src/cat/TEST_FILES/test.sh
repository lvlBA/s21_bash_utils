TEST_FILE_SECOND="./TEST_FILES/example.txt"


cat -b ${TEST_FILE_SECOND} > ORIG.txt && ./s21_cat -b ${TEST_FILE_SECOND} > MINE.txt && diff -s ORIG.txt MINE.txt
cat -n ${TEST_FILE_SECOND} > ORIG.txt && ./s21_cat -n ${TEST_FILE_SECOND} > MINE.txt && diff -s ORIG.txt MINE.txt
cat -s ${TEST_FILE_SECOND} > ORIG.txt && ./s21_cat -s ${TEST_FILE_SECOND} > MINE.txt && diff -s ORIG.txt MINE.txt
cat -e ${TEST_FILE_SECOND} > ORIG.txt && ./s21_cat -e ${TEST_FILE_SECOND} > MINE.txt && diff -s ORIG.txt MINE.txt
cat -t ${TEST_FILE_SECOND} > ORIG.txt && ./s21_cat -t ${TEST_FILE_SECOND} > MINE.txt && diff -s ORIG.txt MINE.txt
cat -bn ${TEST_FILE_SECOND} > ORIG.txt && ./s21_cat -bn ${TEST_FILE_SECOND} > MINE.txt && diff -s ORIG.txt MINE.txt
cat -bns ${TEST_FILE_SECOND} > ORIG.txt && ./s21_cat -bns ${TEST_FILE_SECOND} > MINE.txt && diff -s ORIG.txt MINE.txt
cat -ebns ${TEST_FILE_SECOND} > ORIG.txt && ./s21_cat -bnse ${TEST_FILE_SECOND} > MINE.txt && diff -s ORIG.txt MINE.txt
cat -bnset ${TEST_FILE_SECOND} > ORIG.txt && ./s21_cat -bnset ${TEST_FILE_SECOND} > MINE.txt && diff -s ORIG.txt MINE.txt
cat -b -t ${TEST_FILE_SECOND} > ORIG.txt && ./s21_cat -b -t ${TEST_FILE_SECOND} > MINE.txt && diff -s ORIG.txt MINE.txt
cat -b -t -e ${TEST_FILE_SECOND} > ORIG.txt && ./s21_cat -b -t -e ${TEST_FILE_SECOND} > MINE.txt && diff -s ORIG.txt MINE.txt
cat -b -t -e -s ${TEST_FILE_SECOND} > ORIG.txt && ./s21_cat -b -t -e -s ${TEST_FILE_SECOND} > MINE.txt && diff -s ORIG.txt MINE.txt
cat -b -t -e -s ${TEST_FILE_SECOND} ${TEST_FILE_SECOND} > ORIG.txt && ./s21_cat -b -t -e -s ${TEST_FILE_SECOND} ${TEST_FILE_SECOND} > MINE.txt && diff -s ORIG.txt MINE.txt
cat -s -t -e -b ${TEST_FILE_SECOND} ${TEST_FILE_SECOND} > ORIG.txt && ./s21_cat -s -t -e -b ${TEST_FILE_SECOND} ${TEST_FILE_SECOND} > MINE.txt && diff -s ORIG.txt MINE.txt
cat -s -e -t -b ${TEST_FILE_SECOND} ${TEST_FILE_SECOND} > ORIG.txt && ./s21_cat -s -e -t -b ${TEST_FILE_SECOND} ${TEST_FILE_SECOND} > MINE.txt && diff -s ORIG.txt MINE.txt
cat -s -b -t -e ${TEST_FILE_SECOND} ${TEST_FILE_SECOND} > ORIG.txt && ./s21_cat -s -b -t -e ${TEST_FILE_SECOND} ${TEST_FILE_SECOND} > MINE.txt && diff -s ORIG.txt MINE.txt
cat -n -b -t -e -s ${TEST_FILE_SECOND} ${TEST_FILE_SECOND} > ORIG.txt && ./s21_cat -n -b -t -e -s ${TEST_FILE_SECOND} ${TEST_FILE_SECOND} > MINE.txt && diff -s ORIG.txt MINE.txt
cat -b -s -t -e -n ${TEST_FILE_SECOND} ${TEST_FILE_SECOND} > ORIG.txt && ./s21_cat -b -s -t -e -n ${TEST_FILE_SECOND} ${TEST_FILE_SECOND} > MINE.txt && diff -s ORIG.txt MINE.txt
cat -b -t -e -s -n ${TEST_FILE_SECOND} > ORIG.txt && ./s21_cat -b -t -e -s -n ${TEST_FILE_SECOND} > MINE.txt && diff -s ORIG.txt MINE.txt
cat -ebnst ${TEST_FILE_SECOND} > ORIG.txt && ./s21_cat -ebnst ${TEST_FILE_SECOND} > MINE.txt && diff -s ORIG.txt MINE.txt
cat -nsteb ${TEST_FILE_SECOND} > ORIG.txt && ./s21_cat -nsteb ${TEST_FILE_SECOND} > MINE.txt && diff -s ORIG.txt MINE.txt

rm -f ORIG.txt MINE.txt
