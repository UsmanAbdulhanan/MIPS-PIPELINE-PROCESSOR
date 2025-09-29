module Top_module(
    input clock,
    input reset
);

    // Program Counter signals
    wire [31:0] PCin;
    wire [31:0] PCout;
    wire [31:0] pc_plus;
    wire [31:0] pc_plus1_out;
    
    // Instruction Memory signals
    wire [31:0] instruction;
    wire [31:0] instruction_out;
    
    // Control Unit signals
    wire RegWrite, RegDst, branch, MemRead, MemtoReg, MemWrite, AluSrc;
    wire [1:0] ALUop;
    
    // Register File signals
    wire [31:0] WriteData, ReadData1, ReadData2;
    wire [4:0] WriteReg;
    
    // Sign Extend signals
    wire [31:0] Extend32out;
    
    // Pipeline Registers signals
    wire regwrite_out, memtoreg_out;
    wire branch_out, memread_out, memwrite_out;
    wire reg_dst_out, alu_src_out;
    wire [1:0] aluop_out;
    wire [31:0] plus1_out;
    wire [31:0] reg_read_data_1_out, reg_read_data_2_out, extended_out;
    wire [4:0] if_id_rt_out, if_id_rd_out;
    wire [5:0] funct_out;
    
    // ALU Control signals
    wire [3:0] ALUCtl;
    
    // ALU signals
    wire [31:0] ALUOut;
    wire Zero;
    
    // MEM/WB signals
    wire RegWrite_out, MemtoReg_out, Branch_out, MemRead_out, MemWrite_out, Zero_out;
    wire [31:0] ALU_result_out, reg_read_data_2_out, d_mem_read_data_out, d_mem_read_addr_out;
    wire [4:0] dest2;
    
    // Write Back MUX signals
    wire [31:0] WBMux_out;

    // Instantiate Modules
    PC pc_inst (
        .clock(clock),
        .in(PCin),
        .out(PCout)
    );
    
    PC_ad pc_ad_inst (
        .pc(PCout),
        .out(pc_plus)
    );
    
    Instruction_memory Im_inst (
        .read_addr(PCout),
        .instruction(instruction),
        .reset(reset)
    );
    
    IF_ID_state_reg IF_id_inst (
        .pc_plus4_in(pc_plus),
        .pc_plus4_out(pc_plus1_out),
        .instruction_in(instruction),
        .instruction_out(instruction_out),
        .clk(clock),
        .reset(reset)
    );
    
    control_unit control_inst (
        .clk(clock),
        .opcode(instruction_out[31:26]),
        .RegDst(RegDst),
        .branch(branch),
        .MemRead(MemRead),
        .MemtoReg(MemtoReg),
        .ALUop(ALUop),
        .MemWrite(MemWrite),
        .AluSrc(AluSrc),
        .RegWrite(RegWrite),
        .reset(reset)
    );
    
    RegFile regfile_inst (
        .clock(clock),
        .RegWrite(RegWrite),
        .ReadReg1(instruction_out[25:21]),
        .ReadReg2(instruction_out[20:16]),
        .WriteReg(WriteReg),
        .WriteData(WriteData),
        .ReadData1(ReadData1),
        .ReadData2(ReadData2)
    );
    
    SignExtend sign_ex_inst (
        .inst15_0(instruction_out[15:0]),
        .Extend32(Extend32out)
    );
    
    ID_IE_stateReg ID_IE_stateReg_inst (
        .regwrite_in(RegWrite),
        .memtoreg_in(MemtoReg),
        .regwrite_out(regwrite_out),
        .memtoreg_out(memtoreg_out),
        .branch_in(branch),
        .memread_in(MemRead),
        .memwrite_in(MemWrite),
        .branch_out(branch_out),
        .memread_out(memread_out),
        .memwrite_out(memwrite_out),
        .reg_dest_in(RegDst),
        .alusrc_in(AluSrc),
        .reg_dest_out(reg_dst_out),
        .alusrc_out(alu_src_out),
        .aluop_in(ALUop),
        .aluop_out(aluop_out),
        .pc_plus4_in(pc_plus1_out),
        .pc_plus4_out(plus1_out),
        .reg_read_data_1_in(ReadData1),
        .reg_read_data_2_in(ReadData2),
        .immi_sign_extended_in(Extend32out),
        .reg_read_data_1_out(reg_read_data_1_out),
        .reg_read_data_2_out(reg_read_data_2_out),
        .immi_sign_extended_out(extended_out),
        .if_id_registerrt_in(instruction_out[20:16]),
        .if_id_registerrd_in(instruction_out[15:11]),
        .if_id_register_rt_out(if_id_rt_out),
        .if_id_register_rd_out(if_id_rd_out),
        .if_id_funct_in(instruction_out[5:0]),
        .if_id_funct_out(funct_out),
        .clk(clock),
        .reset(reset)
    );
    
    ALUControl alu_cont_inst (
        .ALUOp(aluop_out),
        .FuncCode(funct_out),
        .ALUCtl(ALUCtl)
    );
    
    ALU alu_inst (
        .aluSrc(alu_src_out),
        .A(reg_read_data_1_out),
        .Rt(reg_read_data_2_out),
        .sign(extended_out),
        .ALUCtl(ALUCtl),
        .ALUOut(ALUOut),
        .Zero(Zero)
    );
    
    Dest_mux_EX_state mux1_inst (
        .in1(if_id_rt_out),
        .in2(if_id_rd_out),
        .out(dest),
        .regDst(reg_dst_out)
    );
    
    Ex_MEm ex_mem_inst (
        .regwrite_in(regwrite_out),
        .memtoreg_in(memtoreg_out),
        .regwrite_out(RegWrite_out),
        .memtoreg_out(MemtoReg_out),
        .branch_in(branch_out),
        .memread_in(memread_out),
        .memwrite_in(memwrite_out),
        .branch_out(Branch_out),
        .memread_out(MemRead_out),
        .memwrite_out(MemWrite_out),
        .branch_addr_in(plus1_out),
        .branch_addr_out(plus1_out),
        .alu_zero_in(Zero),
        .alu_zero_out(Zero_out),
        .alu_result_in(ALUOut),
        .reg_read_data_2_in(reg_read_data_2_out),
        .alu_result_out(ALU_result_out),
        .reg_read_data_2_out(reg_read_data_2_out),
        .id_ex_registerrd_in(dest),
        .ex_mem_register_r_d_out(dest2),
        .clk(clock),
        .reset(reset)
    );
    
    mem_wb mem_wb_inst (
        .regwrite_in(RegWrite_out),
        .memtoreg_in(MemtoReg_out),
        .regwrite_out(RegWrite_out),
        .memtoreg_out(MemtoReg_out),
        .d_mem_read_data_in(d_mem_read_data_out),
        .d_mem_read_addr_in(d_mem_read_addr_out),
        .d_mem_read_dat_a_out(d_mem_read_data_out),
        .d_mem_read_addr_out(d_mem_read_addr_out),
        .ex_mem_register_rd_in(dest2),
        .mem_wb_register_r_d_out(WriteReg),
        .clk(clock),
        .reset(reset)
    );

    WBack_MUX wback_mux_inst (
        .in1(ALU_result_out),
        .in2(d_mem_read_data_out),
        .memtoReg(MemtoReg_out),
        .out(WriteData)
    );

    adder32bit pc_adder (
        .in1(PCout),
        .in2(32'd4),
        .out(PCin)
    );