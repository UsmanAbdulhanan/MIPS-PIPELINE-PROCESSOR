module ID_IE_stateReg(
    input regwrite_in,
    input memtoreg_in,
    output reg regwrite_out,
    output reg memtoreg_out,
    input branch_in,
    input memread_in,
    input memwrite_in,
    output reg branch_out,
    output reg memread_out,
    output reg memwrite_out,
    input reg_dest_in,
    input alusrc_in,
    output reg reg_dest_out,
    output reg alusrc_out,
    input [1:0] aluop_in,
    output reg [1:0] aluop_out,
    input [31:0] pc_plus4_in,
    output reg [31:0] pc_plus4_out,
    input [31:0] reg_read_data_1_in,
    input [31:0] reg_read_data_2_in,
    input [31:0] immi_sign_extended_in,
    output reg [31:0] reg_read_data_1_out,
    output reg [31:0] reg_read_data_2_out,
    output reg [31:0] immi_sign_extended_out,
    input [4:0] if_id_registerrt_in,
    input [4:0] if_id_registerrd_in,
    input [4:0] if_id_registerrS_in,
    output reg [4:0] if_id_register_rt_out,
    output reg [4:0] if_id_register_rd_out,
    output reg [4:0] if_id_register_rs_out,
    input [5:0] if_id_funct_in,
    output reg [5:0] if_id_funct_out,
    input clk,
    input reset,
	 input br_taken
);

    always @(posedge clk or posedge reset or posedge br_taken ) begin
        if (reset) begin
            regwrite_out <= 0;
            memtoreg_out <= 0;
            branch_out <= 0;
            memread_out <= 0;
            memwrite_out <= 0;
            reg_dest_out <= 0;
            alusrc_out <= 0;
            aluop_out <= 2'b00;
            pc_plus4_out <= 32'b0;
            reg_read_data_1_out <= 32'b0;
            reg_read_data_2_out <= 32'b0;
            immi_sign_extended_out <= 32'b0;
            if_id_register_rt_out <= 5'b0;
            if_id_register_rd_out <= 5'b0;
            if_id_funct_out <= 6'b0;
				if_id_register_rs_out <= 0;
				end
			 else if (br_taken) begin
            regwrite_out <= 0;
            memtoreg_out <= 0;
            branch_out <= 0;
            memread_out <= 0;
            memwrite_out <= 0;
            reg_dest_out <= 0;
            alusrc_out <= 0;
            aluop_out <= 2'b00;
            pc_plus4_out <= 32'b0;
            reg_read_data_1_out <= 32'b0;
            reg_read_data_2_out <= 32'b0;
            immi_sign_extended_out <= 32'b0;
            if_id_register_rt_out <= 5'b0;
            if_id_register_rd_out <= 5'b0;
            if_id_funct_out <= 6'b0;
				if_id_register_rs_out <= 0;
        end else begin
            regwrite_out <= regwrite_in;
            memtoreg_out <= memtoreg_in;
            branch_out <= branch_in;
            memread_out <= memread_in;
            memwrite_out <= memwrite_in;
            reg_dest_out <= reg_dest_in;
            alusrc_out <= alusrc_in;
            aluop_out <= aluop_in;
            pc_plus4_out <= pc_plus4_in;
            reg_read_data_1_out <= reg_read_data_1_in;
            reg_read_data_2_out <= reg_read_data_2_in;
            immi_sign_extended_out <= immi_sign_extended_in;
            if_id_register_rt_out <= if_id_registerrt_in;
            if_id_register_rd_out <= if_id_registerrd_in;
            if_id_funct_out <= if_id_funct_in;
				if_id_register_rs_out <= if_id_registerrS_in;
        end
    end
endmodule
