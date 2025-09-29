`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:07:55 05/31/2024 
// Design Name: 
// Module Name:    top_module 
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
module top_module(
input clk,
input CLK,
input rst,
output [6:0]display,
output [3:0] anode
    );
	 
	 
	 wire [31:0] out;
	 PipelineProcessor p(CLK, rst  , out  );
	 
	 wire [15:0] bcdout ;
	 binary_to_bcd bcd (out[15:0],bcdout );
	 
	  seven_segment_multiplexer_ALU  s(rst,clk,bcdout,display,anode );
	 
	 


endmodule
