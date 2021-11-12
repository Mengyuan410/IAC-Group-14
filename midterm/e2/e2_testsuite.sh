#!/bin/bash

set -eou pipefail
mkdir -p bin

TESTCASES="src/*.cpp"

for i in ${TESTCASES} ; do
    TESTNAME=$(basename ${i} .cpp)
    ./my_e2_test.sh ${TESTNAME} 
done
