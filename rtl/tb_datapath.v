`timescale 1ns/1ps
module tb_datapath;

    reg clk, rst;
    wire [31:0] alu_res;

    datapath uut (
        .clk(clk),
        .rst(rst),
        .alu_result_out(alu_res)
    );

    // Clock: 10 ns period
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        $dumpfile("cpu_waveforms.vcd");
        $dumpvars(0, tb_datapath);

        // Apply reset cleanly
        rst = 1;
        @(posedge clk);
        @(posedge clk);
        rst = 0;

        // Print state once per cycle
        repeat (30) begin
            @(posedge clk);
            $display("T=%0t | PC=%h | Instr=%h | ALU=%h",
                     $time, uut.pc, uut.instr, alu_res);
        end

        $finish;
    end

endmodule
