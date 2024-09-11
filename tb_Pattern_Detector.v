module tb_Pattern_Detector;

    reg        clk;
    reg        rst;
    reg [31:0] pattern;
    reg [3:0]  n;
    reg [7:0]  prbs_out;
    wire       pattern_detected;

    // Instantiate the PRBS_Pattern_Detector module
    Pattern_Detector uut (
        .clk(clk),
        .rst(rst),
        .pattern(pattern),
        .n(n),
        .prbs_out(prbs_out),
        .pattern_detected(pattern_detected)
    );

    // Clock generation: 10ns period (100 MHz)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Testbench sequence
    initial begin
        // Initialize signals
        pattern = 32'hA5A6A7A8;  // Pattern to detect
        n = 3;  // Number of pattern repetitions to detect

        // Test 1: Correct Pattern Detection
        $display("Starting Correct Pattern Test...");
        rst = 1;
        #20;
        rst = 0;
        #10;prbs_out = 8'hA5;  // Highest byte
        #10; prbs_out = 8'hA6;  // Next byte
        #10; prbs_out = 8'hA7;  // Next byte
        #10; prbs_out = 8'hA8;  // Lowest byte - 1st pattern match

        #10; prbs_out = 8'hA5;  // Highest byte
        #10; prbs_out = 8'hA6;  // Next byte
        #10; prbs_out = 8'hA7;  // Next byte
        #10; prbs_out = 8'hA8;  // Lowest byte - 2nd pattern match

        #10; prbs_out = 8'hA5;  // Highest byte
        #10; prbs_out = 8'hA6;  // Next byte
        #10; prbs_out = 8'hA7;  // Next byte
        #10; prbs_out = 8'hA8;  // Lowest byte - 3rd pattern match, flag should rise

        // Wait for the pattern_detected flag
        #20;

        // Reset the system before the next test
        $display("Applying reset between tests...");
        rst = 1;
        #20;
        rst = 0;

        // Test 2: Incorrect Pattern Detection
        $display("Starting Incorrect Pattern Test...");
        #10; prbs_out = 8'hB5;  // Incorrect pattern
        #10; prbs_out = 8'hB6;  // Incorrect pattern
        #10; prbs_out = 8'hB7;  // Incorrect pattern
        #10; prbs_out = 8'hB8;  // Incorrect pattern - should not match

        // Correct pattern again to ensure functionality after incorrect pattern
        #10; prbs_out = 8'hA5;  // Correct pattern byte
        #10; prbs_out = 8'hA6;
        #10; prbs_out = 8'hA7;
        #10; prbs_out = 8'hA8;  // Lowest byte - should detect again after 3 matches

        // Wait a bit and finish simulation
        #50;
        $stop;
    end

    // Monitor output and signals
    initial begin
        $monitor("Time: %0t | PRBS Output: %02h | Pattern Detected: %b", $time, prbs_out, pattern_detected);
    end

endmodule
