`timescale 1ns / 1ps


module modified_round_robin_arbiter #(parameter N = 7) (
    input clk,               
    input rst,               
    input [N-1:0] req,      
    output reg [N-1:0] grant
);

    reg [N-1:0] ring_counter; 

    // Rotate the ring counter on each clock cycle, and grant the requested line
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            ring_counter <= 1 << 0;  
        end else begin
            // If any device requested, move the grant to the next device
            if ((ring_counter & req) != 0) begin
                ring_counter <= {ring_counter[N-2:0], ring_counter[N-1]};  // Rotate the counter
            end
        end
    end

    // Grant logic: Grant access to the device indicated by the ring counter if that device requested
    always @(*) begin
        grant = 0;  
        if (req & ring_counter) begin
            grant = ring_counter;  
        end
    end

endmodule









