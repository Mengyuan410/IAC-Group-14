#!/bin/bash

set -eou pipefail


TESTCASE="$1"
set +e
#bin/assembler <test/0-assembly/${TESTCASE}.asm.txt >test/1-binary/${TESTCASE}.hex.txt

#this is where variant number goes e.g testcase1. 
g++ src/${TESTCASE}.cpp -o ${TESTCASE}

if [[  $? == 0 ]] ; then
   echo " src/${TESTCASE}.cpp PASS" #we want to check for a 0 exit code. If we get 0 as exit code it is fine. 
else

   echo "src/${TESTCASE}.cpp FAIL"
fi
set -e