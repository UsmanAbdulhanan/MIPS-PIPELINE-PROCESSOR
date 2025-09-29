module main_control_unit(
    input [5:0] opcode,
    output reg [1:0] aluop,
    output reg regdst,
    output reg alusrc,
    output reg memtoreg,
    output reg regwrite,
    output reg memread,
    output reg memwrite,
    output reg branch
);

    always @(*) begin
        case (opcode)
            6'b000000: begin // R-type
                regdst = 1;
                alusrc = 0;
                memtoreg = 0;
                regwrite = 1;
                memread = 0;
                memwrite = 0;
                branch = 0;
                aluop = 2'b10;
            end
            6'b100011: begin // lw
                regdst = 0;
                alusrc = 1;
                memtoreg = 1;
                regwrite = 1;
                memread = 1;
                memwrite = 0;
                branch = 0;
                aluop = 2'b00;
            end
            6'b101011: begin // sw
                regdst = 0;
                alusrc = 1;
                memtoreg = 0;
                regwrite = 0;
                memread = 0;
                memwrite = 1;
                branch = 0;
                aluop = 2'b00;
            end
            6'b000100: begin // beq
                regdst = 0;
                alusrc = 0;
                memtoreg = 0;
                regwrite = 0;
                memread = 0;
                memwrite = 0;
                branch = 1;
                aluop = 2'b01;
            end
            6'b001000: begin // addi
                regdst = 0;
                alusrc = 1;
                memtoreg = 0;
                regwrite = 1;
                memread = 0;
                memwrite = 0;
                branch = 0;
                aluop = 2'b00;
            end
            default: begin
                regdst = 0;
                alusrc = 0;
                memtoreg = 0;
                regwrite = 0;
                memread = 0;
                memwrite = 0;
                branch = 0;
                aluop = 2'b00;
            end
        endcase
    end

endmodule
