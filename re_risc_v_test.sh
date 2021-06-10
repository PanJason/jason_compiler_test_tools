#!/bin/bash
for i in `ls| grep sy`;
do
    echo $i
    ./main -S $i -o test.S > /dev/null
    riscv32-unknown-linux-gnu-gcc test.S -o output -L/root -lsysy -static
done
