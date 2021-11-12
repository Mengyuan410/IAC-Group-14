module mul2x2(
    input logic [1:0] a,
    input logic [1:0] b,
    output logic [3:0] r
);
    logic tmp1;
    logic tmp2;
    logic tmp3;
    logic tmp4;

// r[0] = a[0] & b[0]
// r[1] = (a[1] & b[0]) ^ (a[0] & b[1])
// r[2] = (a[1] & b[1]) ^ ((a[1] & b[0]) & (a[0] & b[1]))
// r[3] = (a[1] & b[1]) & ((a[1] & b[0]) & (a[0] & b[1]))

// r[0] = a[0] & b[0]
    band ba0(
        .a(a[0]), .b(b[0]), .r(r[0])
    );

// r[1] = (a[1] & b[0]) ^ (a[0] & b[1])

    band ba1(
        .a(a[1]), .b(b[0]), .r(tmp1)
    );
    band ba2(
        .a(a[0]), .b(b[1]), .r(tmp2)
    );
    bxor bx0(
        .a(tmp1), .b(tmp2), .r(r[1])
    );

    
// r[2] = (a[1] & b[1]) ^ ((a[1] & b[0]) & (a[0] & b[1]))

    band ba3(
        .a(tmp1), .b(tmp2), .r(tmp3)
    );

    band ba4(
        .a(a[1]), .b(b[1]), .r(tmp4)
    );

    bxor bx1(
        .a(tmp3), .b(tmp4), .r(r[2])
    );

// r[3] = (a[1] & b[1]) & ((a[1] & b[0]) & (a[0] & b[1]))
    band ba5(
        .a(tmp4), .b(tmp3), .r(r[3])
    );

endmodule