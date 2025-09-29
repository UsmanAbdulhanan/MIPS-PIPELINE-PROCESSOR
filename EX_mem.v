module IE_MA_stateReg(
    input regwrite_in,
    input memtoreg_in,
    input branch_in,
    input memread_in,
    input memwrite_in,
    input [31:0] alu_result_in,
    input [31:0] write_data_in,
    input [4:0] write_reg_in,
    input clk,
    input reset,
    output reg regwrite_out,
    output reg memtoreg_out,
    output reg branch_out,
    output reg memread_out,
    output reg memwrite_out,
    output reg [31:0] alu_result_out,
    output reg [31:0] write_data_out,
    output reg [4:0] write_reg_out,
	 input zero_in,
	 output reg zero_out,
	 input [31:0] branchaddrin,
	 output reg [31:0]  branchaddrout
	 
);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            regwrite_out <= 0;
            memtoreg_out <= 0;
            branch_out <= 0;
            memread_out <= 0;
            memwrite_out <= 0;
            alu_result_out <= 0;
            write_data_out <= 0;
            write_reg_out <= 0;
            branchaddrout <= 0;
        end else begin
            regwrite_out <= regwrite_in;
            memtoreg_out <= memtoreg_in;
            branch_out <= branch_in;
            memread_out <= memread_in;
            memwrite_out <= memwrite_in;
            alu_result_out <= alu_result_in;
            write_data_out <= write_data_in;
            write_reg_out <= write_reg_in;
				zero_out <= zero_in;
				branchaddrout <= branchaddrin;
        end
    end

endmodule
