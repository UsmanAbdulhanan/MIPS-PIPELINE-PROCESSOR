module MA_WB_stateReg(
    input regwrite_in,
    input memtoreg_in,
    output reg regwrite_out,
    output reg memtoreg_out,
    input [31:0] read_data_in,
    output reg [31:0] read_data_out,
    input [31:0] alu_result_in,
    output reg [31:0] alu_result_out,
    input [4:0] write_reg_in,
    output reg [4:0] write_reg_out,
	 input mem_readin,
	 output reg mem_readout,
    input clk,
    input reset
);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            regwrite_out <= 0;
            memtoreg_out <= 0;
            read_data_out <= 0;
            alu_result_out <= 0;
            write_reg_out <= 0;
				mem_readout <= 0;
        end else begin
            regwrite_out <= regwrite_in;
            memtoreg_out <= memtoreg_in;
            read_data_out <= read_data_in;
            alu_result_out <= alu_result_in;
            write_reg_out <= write_reg_in;
				mem_readout <= mem_readin;
        end
    end

endmodule
