`timescale 1ns / 1ps

module PC(
    input clock,
	 input rst,
	 input hazard,
    input [31:0] in,
	 input [31:0] pc_if_hazard,
    output reg [31:0] out
);

    always @(posedge clock or posedge rst) begin
		if (rst)
			out<= 0;
		else if (hazard)
		out <= pc_if_hazard-1;
		else
		out<=in;
end
endmodule
