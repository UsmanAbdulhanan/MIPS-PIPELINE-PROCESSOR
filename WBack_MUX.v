module WBack_MUX( in1,in2 , memtoReg,out
    );
input[31:0] in1,in2;
input memtoReg;
output [31:0] out;

assign out = 	(memtoReg == 1'b0) ? in1 : in2;
endmodule