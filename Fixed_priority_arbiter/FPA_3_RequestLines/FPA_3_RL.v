`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/27/2025 05:15:47 PM
// Design Name: 
// Module Name: FPA_3_RL
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

module fixed_priority_arbiter_3(
    input wire clk,
    input wire rst,
    input wire [2:0] request,  // 3 request lines
    output reg [2:0] grant     // 3 grant lines
);

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            grant <= 3'b000;  // Reset all grants
        end else begin
            case (request)
                3'b001: grant <= 3'b001;  // Grant request 0 (highest priority)
                3'b010: grant <= 3'b010;  // Grant request 1
                3'b100: grant <= 3'b100;  // Grant request 2 (lowest priority)
                default: grant <= 3'b000; // No grant if no request is active
            endcase
        end
    end

endmodule


module tb_fixed_priority_arbiter_3;

    reg clk;
    reg rst;
    reg [2:0] request;         // 3 request lines
    wire [2:0] grant;          // 3 grant lines

    // Instantiate the arbiter
    fixed_priority_arbiter_3 uut (
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
        request = 3'b000;
        #10 rst = 0;                // De-assert reset

        // Test 1: No request
        #10 request = 3'b000;       // No requests
        #10;

        // Test 2: Only request[0] active
        #10 request = 3'b001;       // Request from line 0
        #10;

        // Test 3: Only request[1] active
        #10 request = 3'b010;       // Request from line 1
        #10;

        // Test 4: Only request[2] active
        #10 request = 3'b100;       // Request from line 2
        #10;

        // Test 5: Multiple requests active
        #10 request = 3'b101;       // Requests 0 and 2 active
        #10 request = 3'b111;       // All requests active
        #10;

        $stop;  // End simulation
    end

endmodule


