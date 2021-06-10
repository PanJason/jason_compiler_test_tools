#!/bin/bash
for i in `ls| grep sy`;
do
    echo $i
    ./main -S $i -o test.S -p > /dev/null
    riscv32-unknown-linux-gnu-gcc test.S -o output -L/root -lsysy -static
    bn=`basename -s .sy $i`
    if [ -f "$bn.in" ];
    then
	   #echo $bn.in
	   qemu-riscv32-static output < $bn.in >$bn.tmp.out
    else
	   qemu-riscv32-static output >$bn.tmp.out
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
