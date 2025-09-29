`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:15:52 05/28/2024 
// Design Name: 
// Module Name:    branch_calc 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module branch_calc(
    input [31:0] pc,         // 32-bit Program Counter input
    input [31:0] branch_addr,// 32-bit Branch Address input
    output reg [31:0] new_pc     // 32-bit output for new PC value
);

    always @(*)begin
    new_pc <= pc + branch_addr -1;
end
endmodule

