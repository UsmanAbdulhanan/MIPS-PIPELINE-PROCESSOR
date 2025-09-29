`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:48:26 05/27/2024 
// Design Name: 
// Module Name:    mux_3input 
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
module mux_3input 
  (in1, in2, in3, sel, out);
  input [31:0] in1, in2, in3;
  input [1:0] sel;
  output [31:0] out;

  assign out = (sel == 2'd0) ? in1 :
               (sel == 2'd1) ? in2 : in3;
endmodule 
