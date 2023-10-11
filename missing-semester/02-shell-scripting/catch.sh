#!/bin/sh

foo=0
out=""
count=1

while [ $foo -eq 0 ]
do
    ./fail-sometimes.sh > out.txt 2> err.txt
    foo=$?
    if [ $foo -ne 0 ]
    then
        echo $foo
    fi
    count=$((count+1))
done

echo $out
echo "crashed after $count tries"