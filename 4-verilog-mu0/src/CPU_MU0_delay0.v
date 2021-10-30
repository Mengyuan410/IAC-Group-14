

/*
STP 0111 stop
JNE S 0110 if ACC ≠ 0, PC := S
JGE S 0101 if ACC > 0, PC := S
JMP S 0100 PC := S
SUB S 0011 ACC := ACC – mem[S]
ADD S 0010 ACC := ACC + mem[S]
STO S 0001 mem[S] := ACC
LDA S 0000 ACC := mem[S]
OUT S 1000 print(Acc)
*/

module CPU_MU0_delay0(
    input logic clk,
    input logic rst, //reset
    output logic running,
    output logic[11:0] address,
    output logic write,
    output logic read,
    output logic[15:0] writedata,
    input logic[15:0] readdata      
    );

    /* Using an enum to define constants */
    //typedef: used to create an additional name (alias) for another data type, but does not create a new type
    //enum: enumeration datatype, can only take value specified -> avoid magical number
    typedef enum logic[3:0] {
        OPCODE_LDA = 4'd0, //4bits decimal 0-15
        OPCODE_STO = 4'd1,
        OPCODE_ADD = 4'd2,
        OPCODE_SUB = 4'd3,
        OPCODE_JMP = 4'd4,
        OPCODE_JGE = 4'd5,
        OPCODE_JNE = 4'd6,
        OPCODE_STP = 4'd7,
        OPCODE_OUT = 4'd8
    } opcode_t;

    /* Another enum to define CPU states. */
    typedef enum logic[1:0] { //2-cycle program
        FETCH_INSTR = 2'b00,
        EXEC_INSTR = 2'b01,
        HALTED = 2'b10   //for start and end
    } state_t;

    logic[11:0] pc, pc_next;
    logic[15:0] acc;

    logic[16:0] instr;
    logic[3:0] instr_opcode; //instr_opcode is a opcode_t datatype as defined by typedef enum
    logic[11:0] instr_constant;    

    logic[1:0] state;

    // Decide what address to put out on the bus, and whether to write 
    // continuous assignment, happens immediately as long as the value changes
    assign address = (state==FETCH_INSTR) ? pc : instr_constant; //address = pc at fetch cycle, address = load/store address at the rest cases
    assign write = (state==EXEC_INSTR) ? instr_opcode==OPCODE_STO : 0; //write=1 if: 1)it is at fetch cycle; 2)instruction opcode = the opcode for store
    assign read = (state==FETCH_INSTR) ? 1 : (instr_opcode==OPCODE_LDA || instr_opcode==OPCODE_ADD  || instr_opcode==OPCODE_SUB );
    //read=1 if: 1)it is at fetch state; 2)it is at exec/halt cycle, instruction opcode = the opcode for load/add/sub
    assign writedata = acc;

    // Break-down the instruction into fields
    // these are just wires for our convenience
    assign instr_opcode = instr[15:12];
    assign instr_constant = instr[11:0];

    // This is used in many places, as most instructions go forwards by one step.
    // Defining it once makes it more likely the synthesis tool will only create
    // one concrete instance.
    wire[11:0] pc_increment;
    assign pc_increment = pc + 1;

    /* We are targetting an FPGA, which means we can specify the power-on value of the
        circuit. So here we set the initial state to 0, and set the output value to
        indicate the CPU is not running.
    */
    initial begin
        state = HALTED;
        running = 0;
    end
    
    /* Main CPU sequential update logic. Where combinational logic is simple, it
        has been incorporated directly here, rather than splitting it into another
        block.

        Note: this is always rather than always_ff due to limitations in the verilog
        simulator, which can't deal with $display in always_ff blocks.
    */
    always @(posedge clk) begin
        if (rst) begin
            $display("CPU : INFO  : Resetting.");
            state <= FETCH_INSTR; //at next cycle, the state will become fetch
            pc <= 0; //initialize
            acc <= 0;
            running <= 1;
        end
        else if (state==FETCH_INSTR) begin
            $display("CPU : INFO  : Fetching, address=%h.", pc);
            instr <= readdata; //at next cycle, which is exec, the instruction will be the the data read from RAM
            state <= EXEC_INSTR; //at next cycle, the state will become exec
        end
        else if (state==EXEC_INSTR) begin
            $display("CPU : INFO  : Executing, opcode=%h, acc=%h, imm=%h, readdata=%x", instr_opcode, acc, instr_constant, readdata);
            case(instr_opcode)
                OPCODE_LDA: begin
                    acc <= readdata; //at next cycle, which is fetch, accumulator = readdata (updated) (readdata only comes out at exec cycle)
                    pc <= pc_increment; //at next fetch, pc=pc+1 updated
                    state <= FETCH_INSTR; 
                end
                OPCODE_STO: begin
                    pc <= pc_increment;
                    state <= FETCH_INSTR;
                end
                OPCODE_ADD: begin
                    acc <= acc + readdata;
                    pc <= pc_increment;
                    state <= FETCH_INSTR;
                end
                OPCODE_SUB: begin
                    acc <= acc - readdata;
                    pc <= pc_increment;
                    state <= FETCH_INSTR;
                end
                OPCODE_JMP: begin
                    pc <= instr_constant; //instr_constant only comes out at exec cyle, therefore, we update pc at this stage
                    state <= FETCH_INSTR;
                end
                OPCODE_JGE: begin
                    if (acc > 0) begin
                        pc <= acc;
                    end
                    else begin
                        pc <= pc_increment;
                    end
                    state <= FETCH_INSTR;
                end
                OPCODE_JNE: begin
                    if (acc != 0) begin
                        pc <= instr_constant;
                    end
                    else begin
                        pc <= pc_increment;
                    end
                    state <= FETCH_INSTR;
                end
                OPCODE_OUT: begin
                    $display("CPU : OUT   : %d", $signed(acc));
                    pc <= pc_increment;
                    state <= FETCH_INSTR;
                end
                OPCODE_STP: begin
                    // Stop the simulation
                    state <= HALTED;
                    running <= 0;
                end
            endcase
        end
        else if (state==HALTED) begin
            // do nothing
        end
        else begin
            $display("CPU : ERROR : Processor in unexpected state %b", state);
            $finish;
        end
    end
endmodule

