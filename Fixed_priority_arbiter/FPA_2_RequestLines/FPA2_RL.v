`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////


module fixed_priority_arbiter_2(
    input wire clk,
    input wire rst,
    input wire [1:0] request,  
    output reg [1:0] grant    
);

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            grant <= 2'b00;  
        end else begin
            case (request)
                2'b01: grant <= 2'b01;  
                2'b10: grant <= 2'b10; 
                default: grant <= 2'b00; 
            endcase
        end
    end
endmodule



module tb_fixed_priority_arbiter_2;

    reg clk;
    reg rst;
    reg [1:0] request;         
    wire [1:0] grant;          

    // Instantiate the arbiter
    fixed_priority_arbiter_2 uut (
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
        request = 2'b00;
        #10 rst = 0;          

        // Test 1: No request
        #10 request = 2'b00;        
        #10;

        // Test 2: Only request[0] active
        #10 request = 2'b01;       
        #10;

        // Test 3: Only request[1] active
        #10 request = 2'b10;
        #10;

        // Test 4: Both requests active
        #10 request = 2'b11;       
        #10;
        
        #10 request = 2'b11;       
        #10;

         #10 request = 2'b10;
        #10;
        $stop;  // End simulation
    end

endmodule
