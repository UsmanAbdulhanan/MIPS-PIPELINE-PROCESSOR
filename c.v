module ControlUnit(
    input clk,
    input [5:0] opcode,
    output reg RegDst,
    output reg branch,
    output reg MemRead,
    output reg MemtoReg,
    output reg [1:0] ALUop,
    output reg MemWrite,
    output reg AluSrc,
    output reg RegWrite,
    input reset
);

    always @(posedge clk) begin
        if (reset) begin
            RegDst <= 0;
            branch <= 0;
            MemRead <= 0;
            MemtoReg <= 0;
            ALUop <= 2'b00;
            MemWrite <= 0;
            AluSrc <= 0;
            RegWrite <= 0;
        end else begin
            case (opcode)
                6'b000000: begin // R-type
                    RegDst <= 1;
                    branch <= 0;
                    MemRead <= 0;
                    MemtoReg <= 0;
                    ALUop <= 2'b10;
                    MemWrite <= 0;
                    AluSrc <= 0;
                    RegWrite <= 1;
                end
                6'b100011: begin // LW
                    RegDst <= 0;
                    branch <= 0;
                    MemRead <= 1;
                    MemtoReg <= 1;
                    ALUop <= 2'b00;
                    MemWrite <= 0;
                    AluSrc <= 1;
                    RegWrite <= 1;
                end
                6'b101011: begin // SW
                    RegDst <= 0;
                    branch <= 0;
                    MemRead <= 0;
                    MemtoReg <= 0;
                    ALUop <= 2'b00;
                    MemWrite <= 1;
                    AluSrc <= 1;
                    RegWrite <= 0;
                end
                6'b000100: begin // BEQ
                    RegDst <= 0;
                    branch <= 1;
                    MemRead <= 0;
                    MemtoReg <= 0;
                    ALUop <= 2'b01;
                    MemWrite <= 0;
                    AluSrc <= 0;
                    RegWrite <= 0;
                end
                default: begin
                    RegDst <= 0;
                    branch <= 0;
                    MemRead <= 0;
                    MemtoReg <= 0;
                    ALUop <= 2'b00;
                    MemWrite <= 0;
                    AluSrc <= 0;
                    RegWrite <= 0;
                end
            endcase
        end
    end
endmodule
