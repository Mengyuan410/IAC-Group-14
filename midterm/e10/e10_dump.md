e10 - Dump
----------

Assume a module called `rom` which implements a combinatorial ROM
containing 256 32-bit words. The module has the following ports:

- `word_address` : 8-bit word address input.
- `data` : 32-bit output giving the 32-bit word at `word_address`.

Write a module called `e10_dump` which instantiates the ROM and
prints the entire contents of the ROM to stdout. The module should
treat the words in ROM as little-endian, and print them out as
one byte per line with the form:
```
rom[byte_address]=value;
```
where:
- `byte_address` is a decimal integer byte-address
- `value` is the decimal value of the 8-bit unsigned value at `byte_address`

For example, if the rom contained 0 everywhere except for word address 2 which is `0xE3FF00CC`,
the output could be:

```
$ ./e10_dump
rom[0]=0;
rom[1]=0;
rom[2]=0;
rom[3]=0;
rom[4]=0;
rom[5]=0;
rom[6]=0;
rom[7]=0;
rom[8]=204;
rom[9]=0;
rom[10]=255;
rom[11]=227;
rom[12]=0;
rom[13]=0;
...
```

Notes:

- Whitespace may be inserted anywhere in the output line, as long
  as it wouldn't change the meaning when interpreted as a verilog statement.
  
  - `rom[  0]=   0;` : Fine
  - ` rom [4]=10 ; ` : Fine
  - `r om[12]=17;` : Not ok.

- Leading zeros should not be inserted for addresses or values:

  - `rom[0]=0;` : Fine
  - `rom[3]=3;` : Fine
  - `rom[03]=3;` : Not ok
  - `rom[3]=03;` : Not ok

- If you use `$print` with `%d` it should print numbers the way you want.
