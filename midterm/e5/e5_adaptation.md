e5 - Adaptation
---------------

Assume you have a *single-cycle* unsigned multiplier called `mul8`
in file `mul8.v`. The module has the following ports:

- `clk` : 1-bit clock input
- `a` : 8-bit input
- `b` : 8-bit input
- `r` : 16-bit output. Contains the full width product of a and b with a 1-cycle delay.

Create a new module called `mul16` in file `mul16.v` which uses the `mul8`
module to implement a *two-cycle* pipelined 16-bit multiplier. The `mul16` module
should take two 16-bit inputs `a` and `b`, and produce a 32-bit full
width product `r=a*b` with a delay of two clock-cycles.

-  The output of the `mul16` in the first two cycles can be anything.

-  You must use the multiplier `mul8` to implement the multiplier, and
   cannot use built-in multiplication.

-  You can use other operations such as addition and shifters, but the
   multiplication must be primarily constructed from `mul8` instances.

-  It does not matter how many instances of `mul8` you instantiate.

-  You are free to create additional modules, but
   they must be contained within the `mul16.v` file.