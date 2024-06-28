module Mem(
    input clk,
    input [511:0] data_in,
    input [8:0] address,
    input read_enable,
    input write_enable,
    output reg [511:0] data_out
);

    reg [31:0] memory[0:511];
    
    integer i;

    always @(posedge clk) begin
        if (read_enable) begin
            for (i = 0; i < 16; i = i + 1) begin
                data_out[i*32 +: 32] <= memory[address + i];
            end
        end
    end

    always @(posedge clk) begin
        if (write_enable) begin
            for (i = 0; i < 16; i = i + 1) begin
                memory[address + i] <= data_in[i*32 +: 32];
            end
        end
    end

endmodule
