#!/bin/bash

set -eou pipefail


TESTCASE="$1"
set +e
#bin/assembler <test/0-assembly/${TESTCASE}.asm.txt >test/1-binary/${TESTCASE}.hex.txt

#this is where variant number goes e.g testcase1. 
g++ src/${TESTCASE}.cpp -o ${TESTCASE}.txt

if [[  $? == 0 ]] ; then
   echo " src/${TESTCASE}.cpp Pass" #we want to check for a 0 exit code. If we get 0 as exit code it is fine. 
elif [[ $? < 256 ]] ; then
   echo "src/${TESTCASE}.cpp,Fail,Execution"
else 
    echo "src/${TESTCASE}.cpp,Fail,Compilation"
fi
set -e
