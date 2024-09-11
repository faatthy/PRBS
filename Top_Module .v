module Top_Module (
    input  wire        clk,
    input  wire        rst,
    input  wire [31:0] pattern,       
    input  wire [3:0]  n,             
    output wire        pattern_detected,  
    output wire [7:0]  prbs_out        
);

    PRBS_15_Block prbs_generator (
        .clk(clk),
        .rst(rst),
        .pattern(pattern),
        .n(n),  
        .prbs_out(prbs_out)  
    );

    Pattern_Detector pattern_detector (
        .clk(clk),
        .rst(rst),
        .pattern(pattern),       
        .n(n),                   
        .prbs_out(prbs_out),     
        .pattern_detected(pattern_detected)
    );

endmodule
