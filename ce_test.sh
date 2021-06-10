#!/bin/bash
for i in `ls| grep sy`;
do
    echo $i
    ./main -S -t $i -o test.S -p > /dev/null
done
