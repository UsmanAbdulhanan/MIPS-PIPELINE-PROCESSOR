module PipelineProcessor_tb;

    // Testbench signals
    reg clk;
    reg reset;

    // Instantiate the PipelineProcessor
    PipelineProcessor uut (
        .clk(clk),
        .reset(reset)
    );

    // Clock generation
    always begin
        #5 clk = ~clk; // 10 time units clock period
    end

    // Initial block to apply stimulus
    initial begin
        // Initialize inputs
        clk = 0;
        reset = 1; // Apply reset

        // Wait for the first rising edge of the clock
        @(posedge clk);
        
        // Deassert reset after one clock cycle
        reset = 0;

        // Run the simulation for a certain period
        #200;

        // End simulation
        $stop;
    end

    // Optional: Monitor outputs for debugging
    initial begin
        $monitor("Time: %0t | PC: %h | Instruction: %h | ALU Out: %h | Mem Data: %h | RegWrite: %b",
                 $time, uut.pc_out, uut.instruction_out, uut.alu_out, uut.mem_data_out, uut.RegWrite_mem_wb);
    end

endmodule
