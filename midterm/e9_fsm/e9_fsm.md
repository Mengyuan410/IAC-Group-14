e9 - FSM
--------

Create a module called `traffic` that implements an FSM for a traffic light controller.
The module has the following ports:

- A clock input called `clk`
- A 1-bit input called `reset` (clock synchronous, active high)
- A 1-bit output called `red`
- A 1-bit output called `orange`
- A 1-bit output called `red`

Each colour output is an active high signal indicated whether the corresponding light is on.

The sequence of traffic lights should be:

1. red : 2 cycles
2. red+orange : 1 cycles
3. green : 2 cycles
4. orange : 1 cycle
5. Go back to step 1

Until `reset` has been driven high and fallen the outputs of the FSM are undefined (i.e. they can take any value).

The traffic light sequence should start in the cycle following reset.

The sequence should be repeated indefinitely.

Possible input sequence and corresponding outputs (at the rising clock edge):

1. reset=?, red=?, orange=?, green=?
2. reset=1, red=?, orange=?, green=?
3. reset=0, red=?, orange=?, green=?
4. reset=0, red=1, orange=0, green=0
5. reset=0, red=1, orange=0, green=0
6. reset=0, red=1, orange=1, green=0
