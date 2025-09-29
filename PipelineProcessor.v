module PipelineProcessor(
    input clk,
    input reset,
	 output [31:0] outputxilix       
	    
);
    // Wires for interconnections
	 
	 
    wire [31:0] pc_in, pc_out, pc_plus4_out, instruction_out, pc_plus4_if_id_out, instruction_if_id;
    wire [31:0] reg_data1, reg_data2, sign_ext_out, alu_out, mem_data_out;
    wire [31:0] reg_data1_id_ex, reg_data2_id_ex_out, sign_ext_id_ex, alu_out_ex_mem,reg_data2_ex_mem_out;
    wire [31:0] mem_data_mem_wb_out, alu_out_mem_wb;
    wire [31:0] addr_or_value;
    wire [31:0] ALU_A, ALU_B;
    wire [4:0] write_reg, mux_dest_out, write_reg_ex_mem, write_reg_mem_wb;
    wire [3:0] alu_control_out;
    wire zero, zero_mem;
    wire [5:0] funct_out_id_ex;
    wire [31:0]  write_back_data;
	  wire [31:0]branch_pc, branch_mem;
	  wire [31:0]pc_plus4_id_ex_out;
	  
	  
	  
    // Control signals
    wire RegDst, branch, MemRead, MemtoReg, MemWrite, AluSrc, RegWrite;
    wire [1:0] ALUOp;
    wire RegDst_id_ex, branch_id_ex, MemRead_id_ex, MemtoReg_id_ex, MemWrite_id_ex, AluSrc_id_ex, RegWrite_id_ex;
    wire [1:0] ALUOp_id_ex;
    wire branch_ex_mem, MemRead_ex_mem, MemtoReg_ex_mem, MemWrite_ex_mem, RegWrite_ex_mem;
    wire MemtoReg_mem_wb, RegWrite_mem_wb, Memreadoutwb;
    wire [1:0] sel1, sel2;
	 wire hazard;
	
	 wire pcsrc;
		
		
		
		
	 //pcsrc mux
	 
	  WBack_MUX pcsrc_mux(
        .memtoReg(pcsrc),
        .in1(pc_plus4_out),
        .in2(branch_mem),
        .out(pc_in)
    );
	 
    // PC Module
    PC pc (
        .clock(clk),
        .rst(reset),
		  .hazard(hazard),
        .in(pc_in),
		  .pc_if_hazard(pc_plus4_if_id_out),
        .out(pc_out)
    );

    // PC Adder
    PC_ad pc_adder (
        .rst(reset),
        .pc(pc_out),
        .out(pc_plus4_out)
    );

    // Instruction Memory
    Instruction_memory instruction_memory (
        .read_addr(pc_out),
        .instruction(instruction_out),
        .reset(reset)
    );

    // IF/ID Pipeline Register
    IF_ID_state_reg if_id_reg (
        .pc_plus4_in(pc_plus4_out),
        .instruction_in(instruction_out),
        .clk(clk),
        .reset(reset),
        .pc_plus4_out(pc_plus4_if_id_out),
        .instruction_out(instruction_if_id),
		  .br_taken(pcsrc)
    );

    // Register File
    RegFile reg_file (
        .clock(clk),
        .RegWrite(RegWrite_mem_wb),
        .ReadReg1(instruction_if_id[25:21]),
        .ReadReg2(instruction_if_id[20:16]),
        .WriteReg(write_reg_mem_wb),
        .WriteData(write_back_data),
        .ReadData1(reg_data1),
        .ReadData2(reg_data2)
    );

    // Sign Extend
    SignExtend sign_extend (
        .inst15_0(instruction_if_id[15:0]),
        .Extend32(sign_ext_out)
    );

    // Control Unit
    ControlUnit control_unit (
        .clk(clk),
        .opcode(instruction_if_id[31:26]),
        .RegDst(RegDst),
        .branch(branch),
        .MemRead(MemRead),
        .MemtoReg(MemtoReg),
        .ALUop(ALUOp),
        .MemWrite(MemWrite),
        .AluSrc(AluSrc),
        .RegWrite(RegWrite),
        .reset(reset),
		  .hazard(hazard)
    );

    wire [4:0] instruction_id_ex_rt, instruction_id_ex_rd, instruction_id_ex_rs;
    // ID/EX Pipeline Register
    ID_IE_stateReg id_ie_reg (
        .regwrite_in(RegWrite),
        .memtoreg_in(MemtoReg),
        .regwrite_out(RegWrite_id_ex),
        .memtoreg_out(MemtoReg_id_ex),
        .branch_in(branch),
        .memread_in(MemRead),
        .memwrite_in(MemWrite),
        .branch_out(branch_id_ex),
        .memread_out(MemRead_id_ex),
        .memwrite_out(MemWrite_id_ex),
        .reg_dest_in(RegDst),
        .alusrc_in(AluSrc),
        .reg_dest_out(RegDst_id_ex),
        .alusrc_out(AluSrc_id_ex),
        .aluop_in(ALUOp),
        .aluop_out(ALUOp_id_ex),
        .pc_plus4_in(pc_plus4_if_id_out),
        .pc_plus4_out(pc_plus4_id_ex_out),
        .reg_read_data_1_in(reg_data1),
        .reg_read_data_2_in(reg_data2),
        .immi_sign_extended_in(sign_ext_out),
		  .immi_sign_extended_out(sign_ext_id_ex),
        .reg_read_data_1_out(reg_data1_id_ex),
        .reg_read_data_2_out(reg_data2_id_ex_out),      
        .if_id_registerrt_in(instruction_if_id[20:16]),
        .if_id_registerrd_in(instruction_if_id[15:11]),
        .if_id_registerrS_in(instruction_if_id[25:21]),
        .if_id_register_rt_out(instruction_id_ex_rt),
        .if_id_register_rd_out(instruction_id_ex_rd),
        .if_id_register_rs_out(instruction_id_ex_rs),
        .if_id_funct_in(instruction_if_id[5:0]),
        .if_id_funct_out(funct_out_id_ex),
        .clk(clk),
        .reset(reset),
		  .br_taken(pcsrc)
    );
    
    forwarding forwrding_EXE (
        .src1_EXE(instruction_id_ex_rt),
        .src2_EXE(instruction_id_ex_rs),
        .dest_MEM(write_reg_ex_mem),
        .dest_WB(write_reg_mem_wb),
        .WB_EN_MEM(MemWrite_ex_mem),
        .WB_EN_WB(Memreadoutwb),
        .val1_sel(sel1),
        .val2_sel(sel2)
    );

    mux_3input mexe1(
        .in1(addr_or_value),
        .in2(alu_out_ex_mem),
        .in3(alu_out_mem_wb),
        .sel(sel1),
        .out(ALU_A)
    );

    mux_3input mexe2(
        .in1(reg_data1_id_ex),
        .in2(alu_out_ex_mem),
        .in3(alu_out_mem_wb),
        .sel(sel2),
        .out(ALU_B)
    );

    WBack_MUX muxaluA(
        .memtoReg(AluSrc_id_ex),
        .in1(reg_data2_id_ex_out),
        .in2(sign_ext_id_ex),
        .out(addr_or_value)
    );

    // ALU Control
    ALUControl alu_control (
        .ALUOp(ALUOp_id_ex),
        .FuncCode(funct_out_id_ex),
        .ALUCtl(alu_control_out)
    );

    // Destination Mux
    Dest_mux_EX_state dest_mux (
        .in1(instruction_id_ex_rt),
        .in2(instruction_id_ex_rd),
        .out(mux_dest_out),
        .regDst(RegDst_id_ex)
    );

    // ALU
    ALU alu (
        .A(ALU_A),
        .B(ALU_B),
        .ALUCtl(alu_control_out),
        .ALUOut(alu_out),
        .Zero(zero)
    );

    // IE/MA Pipeline Register
    IE_MA_stateReg ie_ma_reg (
        .regwrite_in(RegWrite_id_ex),
        .memtoreg_in(MemtoReg_id_ex),
        .regwrite_out(RegWrite_ex_mem),
        .memtoreg_out(MemtoReg_ex_mem),
        .branch_in(branch_id_ex),
        .memread_in(MemRead_id_ex),
        .memwrite_in(MemWrite_id_ex),
        .branch_out(branch_ex_mem),
        .memread_out(MemRead_ex_mem),
        .memwrite_out(MemWrite_ex_mem),
        .alu_result_in(alu_out),
        .alu_result_out(alu_out_ex_mem),
        .write_data_in(reg_data2_id_ex_out),
        .write_data_out(reg_data2_ex_mem_out),
        .write_reg_in(mux_dest_out),
        .write_reg_out(write_reg_ex_mem),
        .clk(clk),
        .reset(reset),
		  .zero_in(zero),
		  .zero_out(zero_mem),
		  .branchaddrin(branch_pc),
		  .branchaddrout(branch_mem)
    );

    // Data Memory
    DataMemory data_memory (
        .address(alu_out_ex_mem),
        .write_data(reg_data2_ex_mem_out),
        .read_data(mem_data_out),
        .MemWrite(MemWrite_ex_mem),
        .MemRead(MemRead_ex_mem),
        .clk(clk)
    );

    // MA/WB Pipeline Register
    MA_WB_stateReg ma_wb_reg (
        .regwrite_in(RegWrite_ex_mem),
        .memtoreg_in(MemtoReg_ex_mem),
        .regwrite_out(RegWrite_mem_wb),
        .memtoreg_out(MemtoReg_mem_wb),
        .read_data_in(mem_data_out),
        .read_data_out(mem_data_mem_wb_out),
        .alu_result_in(alu_out_ex_mem),
        .alu_result_out(alu_out_mem_wb),
        .write_reg_in(write_reg_ex_mem),
        .write_reg_out(write_reg_mem_wb),
        .clk(clk),
        .reset(reset),
        .mem_readin(MemRead_ex_mem),
        .mem_readout(Memreadoutwb)
    );

    // Write Back MUX
    WBack_MUX wback_mux (
        .in1(alu_out_mem_wb),
        .in2(mem_data_mem_wb_out),
        .memtoReg(MemtoReg_mem_wb),
        .out(write_back_data)
    );
	 //HAZARD
	 hazard_detection hazard_detect(
	 MemRead_id_ex,
	 instruction_id_ex_rt,
	 instruction_if_id[20:16],
	 instruction_if_id[25:21],
	 hazard
	 );
	 
	 //branchcalc
	 
	 branch_calc Branchcalc(
	 pc_plus4_id_ex_out,
	 sign_ext_id_ex,
	 branch_pc	 
	 );
	
	
	// pcsrc calculator
	assign pcsrc = branch_ex_mem && zero_mem;
	
	
	xilinxoutput XI_output(
	
	RegWrite_mem_wb,
	write_back_data,
	outputxilix
	
	);
	
	
	
	
	
	
	 
	 

endmodule
