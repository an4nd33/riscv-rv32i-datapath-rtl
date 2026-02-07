module instruction_memory (
    input  [31:0] addr,
    output [31:0] instr
);

    reg [31:0] mem [0:255]; // 256 x 32-bit instruction memory

    wire [7:0] word_addr = addr[9:2]; // limit address range

    assign instr = mem[word_addr]; // word-aligned access

    initial begin
        $readmemh("program.hex", mem);
    end

endmodule
