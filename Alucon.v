module ALUControl(
    input [1:0] ALUOp,
    input [5:0] FuncCode,
    output reg [3:0] ALUCtl
);

    always @(*) begin
        case (ALUOp)
            2'b00: ALUCtl <= 4'b0010; // add for lw, sw, addi
            2'b01: ALUCtl <= 4'b0110; // sub for beq
            2'b10: begin // R-type instructions
                case (FuncCode)
                    6'b000000: ALUCtl <= 4'b0010; // add
                    6'b000001: ALUCtl <= 4'b0110; // sub
                    6'b000010: ALUCtl <= 4'b0000; // and
                    6'b000011: ALUCtl <= 4'b0001; // or
                    6'b000100: ALUCtl <= 4'b0111; // slt
                    default: ALUCtl <= 4'b1111; // should not happen
                endcase
            end
            default: ALUCtl <= 4'b1111; // should not happen
        endcase
    end

endmodule
