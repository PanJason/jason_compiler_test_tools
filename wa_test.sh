#!/bin/bash
for i in `ls| grep sy`;
do
    echo $i
    ./main -S -t $i -o test.S -p > /dev/null
    bn=`basename -s .sy $i`
    if [ -f "$bn.in" ];
    then
	   #echo $bn.in
	   ./minivm -t test.S < $bn.in >$bn.tmp.out
    else
	   ./minivm -t test.S >$bn.tmp.out
    fi 
    retval=$?
    newline=`tail -n1  $bn.tmp.out | wc -l`
#    echo $newline
    if [[ -s $bn.tmp.out ]]&&[[ $newline -ne 1 ]];then
	echo  >> $bn.tmp.out
    fi
    echo $retval >> $bn.tmp.out
    newline=`tail -n1  $bn.out | wc -l`
    if [[ $newline -ne 1 ]];then
	    truncate -s -1 $bn.tmp.out
    fi
    diff $bn.tmp.out $bn.out
done
