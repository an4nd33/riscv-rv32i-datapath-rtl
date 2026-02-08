`timescale 1ns/1ps

module tb_register_file;

    reg clk;
    reg we3;
    reg [4:0] a1, a2, a3;
    reg [31:0] wd3;
    wire [31:0] rd1, rd2;

    register_file uut (
        .clk(clk),
        .we3(we3),
        .a1(a1),
        .a2(a2),
        .a3(a3),
        .wd3(wd3),
        .rd1(rd1),
        .rd2(rd2)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;

        $display("------------------------------------------------------------");
        $display(" WE | A3 | WD3         | A1 | RD1         | A2 | RD2");
        $display("------------------------------------------------------------");

        // Write to x5
        we3 = 1; a3 = 5; wd3 = 32'hAAAA5555;
        #10;

        // Read x5
        we3 = 0; a1 = 5; a2 = 0;
        #1;
        $display(" %b  | %2d | %h | %2d | %h | %2d | %h",
                  we3,a3,wd3,a1,rd1,a2,rd2);

        // Write x10
        we3 = 1; a3 = 10; wd3 = 32'h12345678;
        #10;

        we3 = 0; a1 = 10; a2 = 5;
        #1;
        $display(" %b  | %2d | %h | %2d | %h | %2d | %h",
                  we3,a3,wd3,a1,rd1,a2,rd2);

        $display("------------------------------------------------------------");
        $finish;
    end

endmodule
