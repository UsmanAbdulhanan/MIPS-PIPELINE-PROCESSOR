
module seven_segment_multiplexer_ALU (
    input wire rst,
    input wire clk,                  // Clock input from Nexys 3 board's oscillator
    input wire [15:0] ALUOut,        // 32-bit input for the ALU output
    output reg [6:0] display,        // 7-bit output to drive the segments of the seven-segment display
    output reg [3:0] anode                 // Anode output for multiplexing
);


// Patterns are based on common cathode configuration
parameter [6:0] ZERO = 7'b1000000;  // 0
parameter [6:0] ONE = 7'b1111001;   // 1
parameter [6:0] TWO = 7'b0100100;   // 2
parameter [6:0] THREE = 7'b0110000; // 3
parameter [6:0] FOUR = 7'b0011001;  // 4
parameter [6:0] FIVE = 7'b0010010;  // 5
parameter [6:0] SIX = 7'b0000010;   // 6
parameter [6:0] SEVEN = 7'b1111000; // 7
parameter [6:0] EIGHT = 7'b0000000; // 8
parameter [6:0] NINE = 7'b0010000;  // 9
parameter [6:0] OFF = 7'b1110111;   // Turn off all segments



reg [1:0] digit_counter = 2'b00; // 2-bit counter to count from 0 to 3 to select SSDU
reg [17:0] counter = 0;  // 18-bit counter to count 100,000 cycles
          

// BCD to 7-segment decoder
reg [3:0] bcd[3:0];    // BCD representation of each digit
reg [6:0] segments[3:0];   // 7-segment pattern for each digit

integer i;

always @* begin
    // Convert binary ALU output to BCD format
    bcd[0] = ALUOut[3:0];
    bcd[1] = ALUOut[7:4];
    bcd[2] = ALUOut[11:8];
    bcd[3] = ALUOut[15:12];
	
    // Decode each BCD digit into the corresponding seven-segment pattern
    for (i = 0; i < 4; i = i + 1) begin
        case (bcd[i])
            4'b0000: segments[i] = ZERO;  // Display digit 0
            4'b0001: segments[i] = ONE;   // Display digit 1
            4'b0010: segments[i] = TWO;   // Display digit 2
            4'b0011: segments[i] = THREE; // Display digit 3
            4'b0100: segments[i] = FOUR;  // Display digit 4
            4'b0101: segments[i] = FIVE;  // Display digit 5
            4'b0110: segments[i] = SIX;   // Display digit 6
            4'b0111: segments[i] = SEVEN; // Display digit 7
            4'b1000: segments[i] = EIGHT; // Display digit 8
            4'b1001: segments[i] = NINE;  // Display digit 9
            default: segments[i] = OFF;   // Turn off all segments
        endcase
    end

    // Multiplexing logic to select which seven-segment display to show based on digit_counter
    case(digit_counter)
        2'b00: begin
            display = segments[0];  // Display lowest digit
            anode = 4'b1110;        // Anode for digit 1
        end
        2'b01: begin
            display = segments[1];  // Display second lowest digit
            anode = 4'b1101;        // Anode for digit 2
        end
        2'b10: begin
            display = segments[2];  // Display second highest digit
            anode = 4'b1011;        // Anode for digit 3
        end
        2'b11: begin
            display = segments[3];  // Display highest digit
            anode = 4'b0111;        // Anode for digit 4
        end
        default: begin
            display = OFF;          // Turn off display if digit_counter is out of range
            anode = 4'b1111;       // Turn off all anodes
        end
    endcase
end

// Clock counter and digit counter
always @(posedge clk) begin
    // Increment	 counter on every clock cycle
    counter <= counter + 1;
    
    // Reset counter if it reaches 100,000
    if (counter == 100000)
        counter <= 0;
    
    // Increment digit counter every 1ms
    if (counter % 100 == 0)
        digit_counter <= digit_counter + 1;
end

endmodule