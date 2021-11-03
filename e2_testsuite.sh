#!/usr/bin/bash

set +e    # Disable "exit script on any failure"

# Use a wild-card to specifiy that every file with this pattern represents a testcase file
TESTCASES="multiplier_iterative_v*.v"

# Loop over every file matching the TESTCASES pattern
for i in ${TESTCASES} ; do
   
   TESTNAME=$(basename ${i})
   iverilog -g 2012 -s multiplier_iterative_tb -o multiplier_iterative_tb \
   multiplier_iterative_tb.v ${TESTNAME}  2> /dev/null 
   # '2> /dev/null' filter out the errors so that they won't be outputed

   RESULT=$?  # Capture exit code
   # set -e    # Enable exit script on any error
   if [[ "${RESULT}" -ne 0 ]] ; then
      echo ${TESTNAME} "FAIL"  # Failed to compile
   else
      echo ${TESTNAME} "PASS"  #  compilation succeed
   fi
done