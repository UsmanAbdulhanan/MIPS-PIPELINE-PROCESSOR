module PC_ad(
    input [31:0] pc,
	 input rst,
    output reg [31:0]  out
);
	always @(*) begin	
		if (rst)
			out <= 0;
		else 		
		out <= pc + 1;
    end

     

endmodule
