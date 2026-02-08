`timescale 1ns/1ps

module tb_program_counter;

    reg clk, rst;
    reg [31:0] next_pc;
    wire [31:0] pc;

    program_counter uut (
        .clk(clk),
        .rst(rst),
        .next_pc(next_pc),
        .pc(pc)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst = 1; next_pc = 0;

        $display("------------------------------------------");
        $display(" RST | NEXT_PC      | PC");
        $display("------------------------------------------");

        #10 rst = 0; next_pc = 32'h00000004;
        #10 $display(" %b   | %h | %h", rst, next_pc, pc);

        next_pc = 32'h00000008;
        #10 $display(" %b   | %h | %h", rst, next_pc, pc);

        rst = 1;
        #10 $display(" %b   | %h | %h", rst, next_pc, pc);

        $display("------------------------------------------");
        $finish;
    end

endmodule
