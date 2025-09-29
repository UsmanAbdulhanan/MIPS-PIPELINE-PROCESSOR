module Dest_mux_EX_state( in1, in2, out ,regDst
    );

input[4:0] in1,in2;
input regDst;
output [4:0] out;

assign out = 	(regDst == 1'b0) ? in1 : in2;
endmodule
