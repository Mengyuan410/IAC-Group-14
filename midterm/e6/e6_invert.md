e6 - invert
----------

Assume a combinational module called `f` which implements a function
`y=f(x)`, where `y` is an 8-bit output and `x` is an 8-bit input.
The function `f` is invertible (or one-to-one), so for every possible
8-bit output value `y` there is exactly one corresponding input `x`
that generates it.

Write a sequential module called `invert` which takes a given `y` as an input and
finds the value `x` such that `y=f(x)`. The module should have the
following ports:

- `clk` : 1-bit clock input
- `start` : 1-bit active high input indicating that a new `y` value has been provided
- `y` : 8-bit input specifying the output value of interest
- `x` : 8-bit output returning the input `x` such that `y=f(x)`.

The input `start` will be driven high for exactly one clock cycle to start the
solving process.
When `start` is driven high a new value `y` will be presented,
and `y` will then remain constant until `start` is driven high again.
Within 258 clock cycles of `start` falling from high to low, the output `x` should
be held at the value such that `y=f(x)`.

Two possible examples of an invertible `f` are `f(x)=x+1` and `f(x)=(x<<1)|(x>>7)`.

A C implementation of the invert logic could be:
```
uint8_t invert(uint8_t y)
{
  uint8_t x=0;
  while( f(x) != y ){
    x=x+1;
  }
  return x;
}
```