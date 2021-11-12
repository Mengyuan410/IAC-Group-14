e11 - Register file
-------------------

Create a module called `regfile` which implements a MIPS-like
register file, but with just four registers. The ports are 

- `clk` : clock input
- `write_enable` : input - If asserted the value in `write_data` is written to `write_index`
- `write_index` : input - 2-bit index to write value at
- `write_data` : input - 32-bit value to write 
- `read_a_index` : input - 2-bit index to read value a from
- `read_a_data` : output - 32-bit value read from `read_a_index`
- `read_b_index` : input - 2-bit index to read value b from
- `read_b_data` : output - 32-bit value read from `read_b_index`

The write-port is sequential, so if `write_enable` is true then the
register at `write_index` is not written till the rising edge of the clock.

The two read-ports are combinatorial, so if `read_a_index` is changed
the value at `read_a_data` will be updated within the clock cycle.

The module's timing and semantics should be equivalent to those used in the
MIPS data-path developed in the first week of lectures, except it has four
registers rather than 32.

Register index 0 is always 0, so even if a non-zero value is written to it
any reads from index 0 should always produce 0.

Registers in the register file have undefined read values until they have
been written at least once.