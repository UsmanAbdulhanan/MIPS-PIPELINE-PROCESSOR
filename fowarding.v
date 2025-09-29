`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:00:29 05/27/2024 
// Design Name: 
// Module Name:    fowarding 
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
module forwarding(src1_EXE, src2_EXE,  dest_MEM, dest_WB, WB_EN_MEM, WB_EN_WB, val1_sel, val2_sel);
 input [4:0] src1_EXE, src2_EXE;    // `REG_FILE_ADDR_LEN-1:0` is 5
input [4:0] dest_MEM, dest_WB;                 // `REG_FILE_ADDR_LEN-1:0` is 5
input WB_EN_MEM, WB_EN_WB;
output reg [1:0] val1_sel, val2_sel; // `FORW_SEL_LEN-1:0` is 

  always @ ( * ) begin
    
    {val1_sel, val2_sel} <= 0;

    // determining forwarding control signal for ALU val1
    if (!WB_EN_MEM && src1_EXE == dest_MEM) val1_sel <= 2'd1;
    else if (!WB_EN_WB && src1_EXE == dest_WB) val1_sel <= 2'd2;

    // determining forwarding control signal for ALU val2
    if (!WB_EN_MEM && src2_EXE == dest_MEM) val2_sel <= 2'd1;
    else if (!WB_EN_WB && src2_EXE == dest_WB) val2_sel <= 2'd2;
  end
endmodule // forwarding
