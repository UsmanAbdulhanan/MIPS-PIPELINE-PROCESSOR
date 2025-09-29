`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:59:27 05/31/2024
// Design Name:   top_module
// Module Name:   D:/DE 44 CE 2022/mySemData/sem 4/csa/lab/Pipelineg/top_tb.v
// Project Name:  Pipelineg
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: top_module
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module top_tb;

	// Inputs
	reg clk;
	reg CLK;
	reg rst;

	// Outputs
	wire [6:0] display;
	wire [3:0] anode;

	// Instantiate the Unit Under Test (UUT)
	top_module uut (
		.clk(clk), 
		.CLK(CLK), 
		.rst(rst),
			
		.display(display), 
		.anode(anode)
	);
	
	always begin
        #5 clk = ~clk;
		  end
  always begin 
			#5000 CLK = ~CLK;
			// 10 time units clock period
    end
	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 1;
		CLK = 0;
		
		#5
		
		rst=0;

		// Wait 100 ns for global reset to finish
		        
		// Add stimulus here
		
		
		

	end
      
endmodule

