module Pattern_Detector (
    input  wire        clk,
    input  wire        rst,
    input  wire [31:0] pattern,           // 4-byte pattern (32 bits)
    input  wire [3:0]  n,                 // Number of iterations to detect
    input  wire [7:0]  prbs_out,          // PRBS output from PRBS_15_Block
    output reg         pattern_detected   // Flag to indicate pattern detection
);

    reg [31:0] received_pattern;  // Stores the received 4-byte pattern
    reg [1:0]  byte_select;       // To track which byte is being received
    reg [3:0]  pattern_count;     // To count the number of full patterns detected
	reg state;
	localparam IDLE =1'b0;
	localparam DETECT=1'b1;
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            received_pattern <= 0;
            byte_select <= 0;
            pattern_count <= 0;
            pattern_detected <= 0;
			state<=IDLE;
        end 
		else if(state==IDLE)begin
		state<=DETECT;
		end
		
		else if(state==DETECT) begin
            case (byte_select)
                2'b00: received_pattern[31:24] = prbs_out;  
                2'b01: received_pattern[23:16] = prbs_out;  
                2'b10: received_pattern[15:8]  = prbs_out;  
                2'b11: received_pattern[7:0]   = prbs_out;  
            endcase

            if (byte_select == 2'b11) begin
                if (received_pattern == pattern) begin
                    pattern_count = pattern_count + 1;  

                    if (pattern_count  == n) begin
                        pattern_detected = 1;
                    end
                end
            end
            byte_select = byte_select + 1;
        end
    end
endmodule



