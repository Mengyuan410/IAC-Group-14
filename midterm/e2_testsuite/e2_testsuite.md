e2 - Create a testbench script
------------------------------

Write a bash script called `e2_testsuite.sh` which will compile and
execute any c++ source files in the `src` directory. For each source
file found the script should print one line:

- `$filename,Pass` to stdout if the file compiled and executed successfully;
- `$filename,Fail,Execution` to stdout if the file compiled but returned a non-zero exit code;
- `$filename,Fail,Compilation` if the file did not compile.

For example, if there were three c++ files `src/m1.cpp`, `src/m2.cpp`
and `src/X.cpp`, a possible execution would be:

```
$ ./e2_testsuite.sh
src/m1.cpp,Pass
src/m2.cpp,Fail,Execution
src/X.cpp,Fail,Compilation
```

You may make the following assumptions:

- The test results can be printed in any order
- None of the compiled programs will timeout
- Messages printed to stderr will be ignored; only stdout matters
- The script will always be executed as `./e2_testsuite.sh`, i.e. the working directory contains the script
- There will be no spaces in the containing directory or any of the filenames
- All c++ source files have the extension `.cpp`
- The c++ files don't require any extra compiler flags in order to successfully compile

You should remember that:

- C++ programs may write to stdout when they execute. Such messages should not get mixed into the stdout of the testsuite.
