`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:44:24 05/28/2024 
// Design Name: 
// Module Name:    hazard 
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
module hazard_detection(
    input MemRead_ID_EX,             // MemRead signal from ID/EX pipeline register
    input [4:0] RegisterRt_ID_EX,    // RegisterRt from ID/EX pipeline register
    input [4:0] RegisterRs_IF_ID,    // RegisterRs from IF/ID pipeline register
    input [4:0] RegisterRt_IF_ID,    // RegisterRt from IF/ID pipeline register
    output reg hazard_detected       // Output signal indicating a hazard
);
    always @(*) begin
        // Default to no hazard
        hazard_detected = 0;
        
        // Check for load-use hazard condition
        if (MemRead_ID_EX && 
           ((RegisterRt_ID_EX == RegisterRs_IF_ID) || 
            (RegisterRt_ID_EX == RegisterRt_IF_ID))) begin
            hazard_detected = 1;
        end
    end
endmodule