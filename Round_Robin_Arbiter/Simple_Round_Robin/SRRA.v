`timescale 1ns / 1ps


module round_robin_arbiter (
    input clk,        
    input rst,      
    input [3:0] req,  
    output reg [3:0] grant 
);

reg [3:0] ring_counter; 

// Ring Counter Logic
always @(posedge clk or posedge rst) begin
    if (rst)
        ring_counter <= 4'b0001; 
    else
        ring_counter <= {ring_counter[2:0], ring_counter[3]}; 
end

// Grant Logic
always @(*) begin
    grant = 4'b0000; 
    if (req & ring_counter) 
        grant = ring_counter; 
end

endmodule




module tb_simple_round_robin_arbiter();

    reg clk;
    reg rst;
    reg [3:0] req;
    wire [3:0] grant;

    // Instantiate the Simple Round Robin Arbiter
    round_robin_arbiter uut (
        .clk(clk),
        .rst(rst),
        .req(req),
        .grant(grant)
    );

    // Clock generation
    always #5 clk = ~clk;  // 10ns clock period

    initial begin
        // Initialize signals
        clk = 0;
        rst = 1;
        req = 4'b0000;

        // Reset pulse
        #10 rst = 0;

        // Test Case 1: No request
        #10 req = 4'b0000;  // No grant expected

        // Test Case 2: Single request from Device 2
        #10 req = 4'b0100;  // Grant should be 0100

        // Test Case 3: Multiple requests (Device 1 and 3)
        #10 req = 4'b1010;  // Grant should rotate and match 0010, then 1000

        // Test Case 4: All devices requesting
        #50 req = 4'b1111;  // Grant should rotate sequentially

        // End simulation
        #50 $finish;
    end

    // Monitor outputs
    initial begin
        $monitor("Time=%0t | Req=%b | Grant=%b", $time, req, grant);
    end

endmodule

