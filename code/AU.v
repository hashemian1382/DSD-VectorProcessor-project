module ALU (
    input clk,
    input enable,
    input op,
    input [511:0] A1,
    input [511:0] A2,
    output reg [511:0] A3,
    output reg [511:0] A4
);

reg [31:0] A1_array[15:0];
reg [31:0] A2_array[15:0];
reg [31:0] A3_array[15:0];
reg [31:0] A4_array[15:0];
reg [32:0] sum_temp[15:0];
reg [63:0] product_temp[15:0];

always @(posedge clk) begin
    if (enable) begin
        integer i;
        for (i = 0; i < 16; i = i + 1) begin
            A1_array[i] = A1[32*i +: 32];
            A2_array[i] = A2[32*i +: 32];
        end

        for (i = 0; i < 16; i = i + 1) begin
            if (op == 0) begin
                sum_temp[i] = A1_array[i] + A2_array[i];
                A3_array[i] = sum_temp[i][31:0];
                A4_array[i] = sum_temp[i][32];
            end else begin
                product_temp[i] = A1_array[i] * A2_array[i];
                A3_array[i] = product_temp[i][31:0];
                A4_array[i] = product_temp[i][63:32];
            end
        end

        for (i = 0; i < 16; i = i + 1) begin
            A3[32*i +: 32] = A3_array[i];
            A4[32*i +: 32] = A4_array[i];
        end
    end
end

endmodule