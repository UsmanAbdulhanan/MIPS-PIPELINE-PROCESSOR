`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:49:16 05/30/2024 
// Design Name: 
// Module Name:    xilinxoutput 
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
module xilinxoutput(
input reg_write,
input [31:0]  result,

output reg [31:0] out
 );
always@(*)begin
if (reg_write)
	out<= result;
else
	out<= 0;


end
 
 
 


endmodule
