module DataMemory (
    input [31:0] address,
    input [31:0] write_data,
    output reg [31:0] read_data,
    input MemWrite,
    input MemRead,
    input clk
);
   
	 
	 reg [31:0] memory_read [0:31];
	 
	 initial begin 
	 $readmemb("D:/DE 44 CE 2022/mySemData/sem 4/csa/lab/multiplexing_7_segment/text_files/DataMem_wr.txt",memory_read,0,31	);
       
	 end

	 always @ (*) begin
		if (MemRead)
			read_data <= memory_read[address];
	end
	
	
    always @(*) begin
        if (MemWrite) begin
            memory_read[address] <= write_data;
        end
    end
endmodule