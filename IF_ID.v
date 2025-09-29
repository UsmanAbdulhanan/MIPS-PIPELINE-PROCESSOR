module IF_ID_state_reg(
    input [31:0] pc_plus4_in,
    input [31:0] instruction_in,
    output reg [31:0] pc_plus4_out,
    output reg [31:0] instruction_out,
    input clk,
    input reset,
    input br_taken
);

    always @(posedge clk or posedge reset or posedge br_taken) begin
        if (reset ) begin
            // If reset or branch is taken, flush the pipeline register
            pc_plus4_out <= 32'b0;
            instruction_out <= 32'b0;
				end
				else if (br_taken ) begin
            // If reset or branch is taken, flush the pipeline register
            pc_plus4_out <= 32'b0;
            instruction_out <= 32'b0;
        end else begin
            // Otherwise, pass the inputs to the outputs
            pc_plus4_out <= pc_plus4_in;
            instruction_out <= instruction_in;
        end
    end
endmodule
