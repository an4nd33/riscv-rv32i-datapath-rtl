`timescale 1ns/1ps

module tb_data_memory;

    reg clk, we;
    reg [2:0] funct3;
    reg [31:0] a, wd;
    wire [31:0] rd;

    data_memory uut (
        .clk(clk),
        .we(we),
        .funct3(funct3),
        .a(a),
        .wd(wd),
        .rd(rd)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;

        $display("--------------------------------------------------------------");
        $display(" WE | FUNCT3 | ADDR        | WD           | RD");
        $display("--------------------------------------------------------------");

        // SW
        we = 1; funct3 = 3'b010; a = 0; wd = 32'hDEADBEEF;
        #10;

        // LW
        we = 0; funct3 = 3'b010; a = 0;
        #1;
        $display(" %b  |  %b   | %h | %h | %h",
                  we, funct3, a, wd, rd);

        // SB
        we = 1; funct3 = 3'b000; a = 1; wd = 32'h000000AA;
        #10;

        // LB
        we = 0; funct3 = 3'b000; a = 1;
        #1;
        $display(" %b  |  %b   | %h | %h | %h",
                  we, funct3, a, wd, rd);

        $display("--------------------------------------------------------------");
        $finish;
    end

endmodule
