`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/27/2025 05:51:28 PM
// Design Name: 
// Module Name: FPA_4_RL
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module fixed_priority_arbiter(
    input wire clk,
    input wire rst,
    input wire [3:0] request,  // 4 request lines
    output reg [3:0] grant     // 4 grant lines
);

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            grant <= 4'b0000;  // Reset grants to 0
        end else begin
            case (request)
                4'b0001: grant <= 4'b0001;  // Highest priority: grant for request 0
                4'b0010: grant <= 4'b0010;  // Priority for request 1
                4'b0100: grant <= 4'b0100;  // Priority for request 2
                4'b1000: grant <= 4'b1000;  // Lowest priority: grant for request 3
                default: grant <= 4'b0000;  // No grant if no request is active
            endcase
        end
    end

endmodule

`timescale 1ns / 1ps

module tb_fixed_priority_arbiter_4;

    reg clk;
    reg rst;
    reg [3:0] request;         // 4 request lines
    wire [3:0] grant;          // 4 grant lines

    // Instantiate the arbiter
    fixed_priority_arbiter uut (
        .clk(clk),
        .rst(rst),
        .request(request),
        .grant(grant)
    );

    // Clock generation
    always #5 clk = ~clk;  // 10ns clock period

    // Test sequence
    initial begin
        clk = 0;
        rst = 1;
        request = 4'b0000;
        #10 rst = 0;                // De-assert reset

        // Test 1: No request
        #10 request = 4'b0000;      // No requests
        #10;

        // Test 2: Single requests
        #10 request = 4'b0001;      // Request from line 0
        #10 request = 4'b0010;      // Request from line 1
        #10 request = 4'b0100;      // Request from line 2
        #10 request = 4'b1000;      // Request from line 3

        // Test 3: Multiple requests
        #10 request = 4'b1100;      // Requests 2 and 3 active
        #10 request = 4'b0111;      // Requests 0, 1, and 2 active
        #10 request = 4'b1111;      // All requests active
        #10;

        $stop;  // End simulation
    end

endmodule


