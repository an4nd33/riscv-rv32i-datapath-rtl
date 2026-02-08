`timescale 1ns/1ps

module tb_instruction_memory;

    reg [31:0] addr;
    wire [31:0] instr;

    instruction_memory uut (
        .addr(addr),
        .instr(instr)
    );

    initial begin
        $display("--------------------------------------");
        $display(" ADDR        | INSTRUCTION");
        $display("--------------------------------------");

        addr = 0; #5;
        $display(" %h | %h", addr, instr);

        addr = 4; #5;
        $display(" %h | %h", addr, instr);

        addr = 8; #5;
        $display(" %h | %h", addr, instr);

        $display("--------------------------------------");
        $finish;
    end

endmodule
