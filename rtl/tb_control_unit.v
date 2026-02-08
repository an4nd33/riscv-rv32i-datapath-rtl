`timescale 1ns/1ps

module tb_control_unit;

    reg [6:0] opcode;
    reg [2:0] funct3;
    reg [6:0] funct7;

    wire reg_write, mem_write, alu_src;
    wire [1:0] alu_src_a, result_src;
    wire branch, jump, jalr;
    wire [3:0] alu_ctrl;

    control_unit uut (
        .opcode(opcode),
        .funct3(funct3),
        .funct7(funct7),
        .reg_write(reg_write),
        .mem_write(mem_write),
        .alu_src(alu_src),
        .alu_src_a(alu_src_a),
        .result_src(result_src),
        .branch(branch),
        .jump(jump),
        .jalr(jalr),
        .alu_ctrl(alu_ctrl)
    );

    initial begin
        $display("-------------------------------------------------------------------------------------------------");
        $display(" OPCODE  | REGW MEMW ALUS ALUA RES BR J JALR ALUCTRL");
        $display("-------------------------------------------------------------------------------------------------");

        // R-type ADD
        opcode = 7'b0110011; funct3 = 3'b000; funct7 = 7'b0000000; #5;
        $display(" %b |  %b    %b    %b   %b   %b  %b  %b  %b   %b",
                  opcode, reg_write, mem_write, alu_src,
                  alu_src_a, result_src, branch, jump, jalr, alu_ctrl);

        // LOAD
        opcode = 7'b0000011; funct3 = 3'b010; funct7 = 0; #5;
        $display(" %b |  %b    %b    %b   %b   %b  %b  %b  %b   %b",
                  opcode, reg_write, mem_write, alu_src,
                  alu_src_a, result_src, branch, jump, jalr, alu_ctrl);

        // STORE
        opcode = 7'b0100011; funct3 = 3'b010; #5;
        $display(" %b |  %b    %b    %b   %b   %b  %b  %b  %b   %b",
                  opcode, reg_write, mem_write, alu_src,
                  alu_src_a, result_src, branch, jump, jalr, alu_ctrl);

        // JAL
        opcode = 7'b1101111; #5;
        $display(" %b |  %b    %b    %b   %b   %b  %b  %b  %b   %b",
                  opcode, reg_write, mem_write, alu_src,
                  alu_src_a, result_src, branch, jump, jalr, alu_ctrl);

        $display("-------------------------------------------------------------------------------------------------");
        $finish;
    end

endmodule
