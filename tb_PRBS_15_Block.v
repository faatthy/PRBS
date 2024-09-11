module tb_PRBS_15_Block;

    reg        clk;
    reg        rst;
    reg [31:0] pattern;
    reg [3:0]  n;
    wire [7:0] prbs_out;

    // Instantiate the PRBS_15_Block module
    PRBS_15_Block uut (
        .clk(clk),
        .rst(rst),
        .pattern(pattern),
        .n(n),
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
        rst = 1;
        pattern = 32'hA5A6A7A8;  // Example pattern (10100101 repeating)
        n = 4;  // Number of pattern repetitions

        // Hold reset for a few cycles
        #20;
        rst = 0;

        // Monitor output for several clock cycles
        #200;

        // Apply a new pattern and reset
        rst = 1;
        #20;
        rst = 0;
        pattern = 32'h5A5A5A5A;  // Example pattern (01011010 repeating)
        n = 8;  // More repetitions

        // Monitor output for several clock cycles
        #400;

        // Finish simulation
        $stop;
    end

    // Monitor output and other signals
    initial begin
        $monitor("Time: %0t | PRBS Output: %02h | Pattern: %08h | Iteration: %d", $time, prbs_out, pattern, n);
    end

endmodule

