`timescale 1ns/1ps

module tb_imm_gen;

    reg [31:0] instr;
    wire [31:0] imm;

    imm_gen uut (
        .instr(instr),
        .imm(imm)
    );

    initial begin
        $display("--------------------------------------------------");
        $display(" INSTR           | IMM");
        $display("--------------------------------------------------");

        // ADDI example
        instr = 32'h00500093; #5;
        $display(" %h | %h", instr, imm);

        // SW example
        instr = 32'h00A12023; #5;
        $display(" %h | %h", instr, imm);

        // BEQ example
        instr = 32'h00208663; #5;
        $display(" %h | %h", instr, imm);

        // JAL example
        instr = 32'h004000EF; #5;
        $display(" %h | %h", instr, imm);

        $display("--------------------------------------------------");
        $finish;
    end

endmodule
