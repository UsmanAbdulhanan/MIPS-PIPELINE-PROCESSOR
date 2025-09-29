module RegFile (
    input clock,
    input RegWrite,
    input [4:0] ReadReg1,
    input [4:0] ReadReg2,
    input [4:0] WriteReg,
    input [31:0] WriteData,
    output [31:0] ReadData1,
    output [31:0] ReadData2
);

    reg [31:0] RF [0:31];
	
	
	 initial begin 
	 $readmemb("D:/DE 44 CE 2022/mySemData/sem 4/csa/lab/multiplexing_7_segment/text_files/Reg_File_wr.txt",RF,0,31	);
    
	 end
	 
	 
    assign ReadData1 = RF[ReadReg1];
    assign ReadData2 = RF[ReadReg2];

    always @(*) begin             //
        if (RegWrite) begin
            RF[WriteReg] <= WriteData;
        end
    end
endmodule
