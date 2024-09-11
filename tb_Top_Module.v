module tb_Top_Module;

    reg        clk;
    reg        rst;
    reg [31:0] pattern;
    reg [3:0]  n;
    wire       pattern_detected;
    wire [7:0] prbs_out;

    // Instantiate the top-level module
    Top_Module uut (
        .clk(clk),
        .rst(rst),
        .pattern(pattern),
        .n(n),
        .pattern_detected(pattern_detected),
        .prbs_out(prbs_out)
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

        // Wait for the pattern_detected flag to go high
        #500;

        // Reset the system before the next test
        $display("Applying reset between tests...");
        rst = 1;
        #20;
        rst = 0;

        // Test 2: Incorrect Pattern Detection
        $display("Starting Incorrect Pattern Test...");
        
        // Wait a bit and finish simulation
        #500;
        $stop;
    end

    // Monitor output and signals
    initial begin
        $monitor("Time: %0t | PRBS Output: %02h | Pattern Detected: %b", $time, prbs_out, pattern_detected);
    end

endmodule
