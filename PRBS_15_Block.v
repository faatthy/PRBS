module PRBS_15_Block (
    input  wire        clk,
    input  wire        rst,
    input  wire [31:0] pattern,  // 4-byte pattern (32 bits)
    input  wire [3:0]  n,        // Number of iterations
    output reg  [7:0]  prbs_out  // 1-byte PRBS output
);

    reg [31:0] prbs;
    reg [1:0]  byte_select; // To track which byte to output
    reg [3:0]  repeat_count; // To track how many times the pattern has been repeated

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            prbs <= pattern; 
            prbs_out <= 0;
            byte_select <= 0;
            repeat_count <= 0;
        end else begin
            if (repeat_count < n) begin
                case (byte_select)
                    2'b00: prbs_out = prbs[31:24]; 
                    2'b01: prbs_out = prbs[23:16];  
                    2'b10: prbs_out = prbs[15:8];   
                    2'b11: prbs_out = prbs[7:0];   
                endcase

                // Move to the next byte
                if (byte_select == 2'b11) begin
                    byte_select = 0;
                    repeat_count = repeat_count + 1;  
                    
                end else begin
                    byte_select = byte_select + 1;
                end
            end else begin
                prbs = {prbs[30:0], prbs[13] ^ prbs[14]};  // Update the PRBS with the feedback equation
                repeat_count = 0;  // Reset the repeat count to start again
            end
        end
    end
endmodule

