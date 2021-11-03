#!/bin/bash

set -eou pipefail
mkdir -p bin

TESTCASES="rt1/*.v"

for i in ${TESTCASES} ; do
    TESTNAME=$(basename ${i} .v)
    ./my_e2testone.sh ${TESTNAME}
done
