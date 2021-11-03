#!/bin/bash

set -eou pipefail
set +e 
TESTCASE="$1"

#bin/assembler <test/0-assembly/${TESTCASE}.asm.txt >test/1-binary/${TESTCASE}.hex.txt

#this is where variant number goes e.g testcase1. 


iverilog -Wall -g2012 -o my_test/${TESTCASE} \ rt1/${TESTCASE}.v  #this is the fie to compile

my_test/${TESTCASE} bin/${TESTCASE}.stdout

#test/2-simulator/CPU_MU0_${VARIANT}_tb_${TESTCASE} > test/3-output/CPU_MU0_${VARIANT}_tb_${TESTCASE}.stdout

RESULT=$?
set -e

if [[ "${RESULT}" == 0 ]] ; then
   echo " rt1/${TESTCASE}.v PASS" #we want to check for a 0 exit code. If we get 0 as exit code it is fine. 
else
   #Added an extra line to say that if no failure code is on the testbench 
   #We are essentially Good to GO. 
   echo "rt1/${TESTCASE}.v FAIL"
fi




# VARIANT="$1"
# TESTCASE="$2"
#This is just a compilation
# iverilog -g 2012 \
#    -s CPU_MU0_${VARIANT}_tb \
#    -PCPU_MU0_${VARIANT}_tb.RAM_INIT_FILE=\"test/1-binary/${TESTCASE}.hex.txt\" \
#    -o test/2-simulator/CPU_MU0_${VARIANT}_tb_${TESTCASE} \S
#    src/CPU_MU0_${VARIANT}.v src/CPU_MU0_${VARIANT}_tb.v src/RAM_*.v
#>&2 echo "  3 - Running test-bench"
#test/2-simulator/CPU_MU0_${VARIANT}_tb_${TESTCASE} >test/3-output/CPU_MU0_${VARIANT}_tb_${TESTCASE}.stdout
#my guess is we print to a new file in test/3-output
#We create this new file. 