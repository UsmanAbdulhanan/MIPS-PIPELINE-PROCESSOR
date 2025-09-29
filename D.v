module SignExtend(
    input [15:0] inst15_0,
    output [31:0] Extend32
);

    assign Extend32 = {{16{inst15_0[15]}}, inst15_0};

endmodule
