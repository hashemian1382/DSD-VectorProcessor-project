module Processor(
    input clk,
    input [8:0] address,
    input op_enable,
    input op,
    input we,
    input select_register,
    output [511:0] A1_out,
    output [511:0] A2_out,
    output [511:0] A3_out,
    output [511:0] A4_out
);

    wire [511:0] mem_data_out;
    wire [511:0] alu_A3, alu_A4;
    wire [511:0] reg_file_data_out;
    wire [511:0] data_to_mem;
    wire read_enable;
    
    assign read_enable = ~we;

    Mem memory (
        .clk(clk),
        .data_in(data_to_mem),
        .address(address),
        .read_enable(read_enable),
        .write_enable(we),
        .data_out(mem_data_out)
    );

    register_file regfile (
        .clk(clk),
        .data_in(mem_data_out),
        .A3_result(alu_A3),
        .A4_result(alu_A4),
        .write_enable(we),
        .select_register(select_register), 
        .ready(op_enable),                   
        .data_out(reg_file_data_out),
        .A1_out(A1_out),
        .A2_out(A2_out),
        .A3_out(A3_out),
        .A4_out(A4_out)
    );

    ALU alu (
        .clk(clk),
        .enable(op_enable),  
        .op(op),
        .A1(A1_out),
        .A2(A2_out),
        .A3(alu_A3),
        .A4(alu_A4)
    );

    assign data_to_mem = reg_file_data_out;

endmodule