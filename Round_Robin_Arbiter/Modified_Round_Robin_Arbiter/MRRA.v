`timescale 1ns / 1ps

module modified_round_robin_arbiter (
    input clk,       
    input rst,        
    input [3:0] req, 
    output reg [3:0] grant 
);

reg [3:0] ring_counter; 

// Reset or rotate ring counter
always @(posedge clk or posedge rst) begin
    if (rst)
        ring_counter <= 4'b0001;
    else begin
        if ((ring_counter & req) == 0) begin
           
            if ((ring_counter[0] & req) == 0)
                ring_counter <= {ring_counter[2:0], ring_counter[3]}; // Rotate
            else if ((ring_counter[1] & req) == 0)
                ring_counter <= {ring_counter[3], ring_counter[2:0]}; // Rotate
            else if ((ring_counter[2] & req) == 0)
                ring_counter <= {ring_counter[1:0], ring_counter[3:2]}; // Rotate
            else if ((ring_counter[3] & req) == 0)
                ring_counter <= {ring_counter[0], ring_counter[3:1]}; // Rotate
        end else begin
            
            ring_counter <= {ring_counter[2:0], ring_counter[3]};
        end
    end
end

// Grant Logic
always @(*) begin
    grant = 4'b0000; 
    if (req & ring_counter) 
        grant = ring_counter; 
end

endmodule

module tb_modified_round_robin_arbiter;

// Testbench signals
reg clk;        
reg rst;        
reg [3:0] req;  


modified_round_robin_arbiter uut (
    .clk(clk),
    .rst(rst),
    .req(req),
    .grant(grant)
);

// Clock generation
always begin
    #5 clk = ~clk; 
end

initial begin
    // Initialize signals
    clk = 0;
    rst = 0;
    req = 4'b0000; 
    // Apply reset
    $display("Applying Reset...");
    rst = 1;
    #10;
    rst = 0;
    #10;

    // Test 1: Single request from device 0
    $display("Test 1: Single request from device 0");
    req = 4'b0001;
    #10;

    // Test 2: Single request from device 2
    $display("Test 2: Single request from device 2");
    req = 4'b0100;
    #10;

    // Test 3: All devices request
    $display("Test 3: All devices request");
    req = 4'b1111; 
    #10;

    // Test 4: Device 1 and Device 3 request
    $display("Test 4: Device 1 and Device 3 request");
    req = 4'b1010;
    #10;

    // Test 5: Device 0 and Device 2 request
    $display("Test 5: Device 0 and Device 2 request");
    req = 4'b0101; 
    #10;

    // Test 6: No request (idle)
    $display("Test 6: No request (idle)");
    req = 4'b0000; 
    #10;

    // Finish simulation
    $stop;
end

endmodule


