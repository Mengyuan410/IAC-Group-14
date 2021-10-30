#!/bin/bash
set -eou pipefail

# Can be used to echo commands
# set -o xtrace

# Capture the first two command line parameters to specify
# the CPU variant and the specific test-base.
# $1, $2, $2, ... represent the arguments passed to the script
VARIANT="$1"
TESTCASE="$2"

# Redirect output to stder (&2) so that it seperate from genuine outputs
# Using ${VARIANT} substitures in the value of the variable VARIA T
>&2 echo "Test CPU variant ${VARIANT} using test-case ${TESTCASE}"
# > : output redirection
# 2: stderr (in shell, 0 means stdin, 1 means stdout, 2 means stderr) 
# & : follow by a file descriptor (1,2,3 as mentioned above) not a file
# basically >2& means redirect the echo "..." to standard-error output.

>&2 echo "  1 - Assembling input file"
#asm files are assembler source code files. It can be converted to machine language. 
#asm files are combined script files which are in C/C++.  
bin/assembler <test/0-assembly/${TESTCASE}.asm.txt >test/1-binary/${TESTCASE}.hex.txt
# <: input redirection
# >: output redirection
# Input "0-assembly/${TESTCASE}.asm.txt" into assembler.cpp, translate the assmebly language in it into hexadecimal instruction. Then output and store it in "test/1-binary/${TESTCASE}.hex.txt"

>&2 echo " 2 - Compiling test-bench"
# Compile a specific simulator for this variant and testbench.
# -s specifies exactly which testbench should be top-level
# The -P command is used to modify the RAM_INIT_FILE parameter on the test-bench at compile-time
iverilog -g 2012 \
   src/CPU_MU0_${VARIANT}.v src/CPU_MU0_${VARIANT}_tb.v src/RAM_*.v \
   -s CPU_MU0_${VARIANT}_tb \
   -PCPU_MU0_${VARIANT}_tb.RAM_INIT_FILE=\"test/1-binary/${TESTCASE}.hex.txt\" \
   -o test/2-simulator/CPU_MU0_${VARIANT}_tb_${TESTCASE}

>&2 echo "  3 - Running test-bench"
# Run the simulator, and capture all output to a file
# Use +e to disable automatic script failure if the command fails, as it is possible the simulation might go wrong.
set +e
test/2-simulator/CPU_MU0_${VARIANT}_tb_${TESTCASE} > test/3-output/CPU_MU0_${VARIANT}_tb_${TESTCASE}.stdout
# > means redirection

# Capture the exit code of the simulator in a variable
# $? means the exit status (1 or 0) 
RESULT=$?
# if exit status is 1 means fail; if the exit status is 0 means suceed
set -e

# Check whether the simulator returned a failure code, and immediately quit
if [[ "${RESULT}" -ne 0 ]] ; then
# -ne means not equal to
   echo "  ${VARIANT}, ${TESTCASE}, FAIL"
   exit
fi

>&2 echo "    Extracting result of OUT instructions"
# This is the prefix for simulation output lines containing result of OUT instruction
PATTERN="CPU : OUT   :"
NOTHING=""
# Use "grep" to look only for lines containing PATTERN
set +e
grep "${PATTERN}" test/3-output/CPU_MU0_${VARIANT}_tb_${TESTCASE}.stdout > test/3-output/CPU_MU0_${VARIANT}_tb_${TESTCASE}.out-lines
# extract lines in "test/3-output/CPU_MU0_${VARIANT}_tb_${TESTCASE}.stdout" file that fulfill the PATTERN to "test/3-output/CPU_MU0_${VARIANT}_tb_${TESTCASE}.out-lines"
set -e
sed -e "s/${PATTERN}/${NOTHING}/g" test/3-output/CPU_MU0_${VARIANT}_tb_${TESTCASE}.out-lines > test/3-output/CPU_MU0_${VARIANT}_tb_${TESTCASE}.out
# s/: substitution operator
# /g (global replacement) specifies the sed command to replace all the occurrences of the string in the line.
# Use "sed" to replace "CPU : OUT   :" in every line of file "test/3-output/CPU_MU0_${VARIANT}_tb_${TESTCASE}.out-lines"  with nothing and store it in " test/3-output/CPU_MU0_${VARIANT}_tb_${TESTCASE}.out"

>&2 echo "  4 - Running reference simulator"
# This is the 
set +e
bin/simulator < test/1-binary/${TESTCASE}.hex.txt > test/4-reference/${TESTCASE}.out
# Input "test/1-binary/${TESTCASE}.hex.txt" into simulator.cpp. The output of the simulation is stored in " test/4-reference/${TESTCASE}.out"

set -e

>&2 echo "  b - Comparing output"
# Note the -w to ignore whitespace
set +e
diff -w test/4-reference/${TESTCASE}.out test/3-output/CPU_MU0_${VARIANT}_tb_${TESTCASE}.out
# diff is used to compare the result of 2 files (in this case compare the output of our built mu0 and the simulator)
# -w means writable
RESULT=$?
set -e

# Based on whether differences were found, either pass or fail
if [[ "${RESULT}" -ne 0 ]] ; then
   echo "  ${VARIANT}, ${TESTCASE}, FAIL"
else
   echo "  ${VARIANT}, ${TESTCASE}, pass"
fi