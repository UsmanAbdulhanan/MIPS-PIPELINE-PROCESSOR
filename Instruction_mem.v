module Instruction_memory(
    input [31:0] read_addr,
    output [31:0] instruction,
    input reset
);

    reg [31:0] Imemory [0:4];
 //   integer k;


    initial begin
	 $readmemb("D:/DE 44 CE 2022/mySemData/sem 4/csa/lab/multiplexing_7_segment/text_files/Instruction_mem.txt",Imemory,0,4	);
    end
    assign instruction = Imemory[read_addr];           
  
		  
       // Imemory[0] = 32'b000000_00100_00101_00110_00000_000000;  //add 6,4,5
		 // Imemory[1] = 32'b000000_00110_00100_01000_00000_000000;  //add 8,6,4
		 // Imemory[2] = 32'b000001_01000_01001_0000000000000000;    //lw 9,0(8)
		 // Imemory[3] = 32'b000000_01001_01011_01010_00000_000000;  //add 10,9,11
		 
		 
		 
		//Imemory[0] = 32'b000000_00010_01001_00011_00000_000000;  //add 3,2,9
	
		//Imemory[1] = 32'b000001_00101_00100_0000000000000000;    //lw 4,0(5)
		//Imemory[2] = 32'b000000_00001_00010_00111_00000_000001;  //sub 7,2,1
		
      //Imemory[3] = 32'b000010_00101_00100_0000000000000000;    //sw 4,0(5)
		
		//Imemory[4] = 32'b000011_00010_00010_00000_00000_001100;  //beq 2,2,12
		 
		 
      
        
   
endmodule
