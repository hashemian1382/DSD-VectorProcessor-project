module register_file (
    input clk,
    input [511:0] data_in,
    input [511:0] A3_result,
    input [511:0] A4_result,
    input write_enable,
    input select_register,
    input ready,
    output reg [511:0] data_out,
    output reg [511:0] A1_out,
    output reg [511:0] A2_out,
    output reg [511:0] A3_out,
    output reg [511:0] A4_out
);
    reg [511:0] A1, A2, A3, A4;

    always @(posedge clk) begin
        if (write_enable) begin
            case (select_register)
                1'b0: A1 <= data_in;
                1'b1: A2 <= data_in;
            endcase
        end
        if (!write_enable && ready) begin
            A3 <= A3_result;
            A4 <= A4_result;
        end
        A1_out <= A1;
        A2_out <= A2;
        A3_out <= A3;
        A4_out <= A4;
    end

    always @(*) begin
        if (!write_enable) begin
            case (select_register)
                1'b0: data_out = A3;
                1'b1: data_out = A4;
            endcase
        end
    end

endmodule
