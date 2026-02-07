module imm_gen (
    input  [31:0] instr,
    output reg [31:0] imm
);

    wire [6:0] opcode = instr[6:0];

    always @(*) begin
        imm = 32'b0; // default

        case (opcode)

            // I-Type (ADDI, LW, JALR, SYSTEM)
            7'b0010011,
            7'b0000011,
            7'b1100111,
            7'b1110011:
                imm = {{20{instr[31]}}, instr[31:20]};

            // S-Type (SW)
            7'b0100011:
                imm = {{20{instr[31]}}, instr[31:25], instr[11:7]};

            // B-Type (BEQ, BNE, BLT, etc.)
            // imm[12|10:5|4:1|11|0]
            7'b1100011:
                imm = {{19{instr[31]}}, instr[31], instr[7],
                       instr[30:25], instr[11:8], 1'b0};

            // U-Type (LUI, AUIPC)
            7'b0110111,
            7'b0010111:
                imm = {instr[31:12], 12'b0};

            // J-Type (JAL)
            // imm[20|10:1|11|19:12|0]
            7'b1101111:
                imm = {{11{instr[31]}}, instr[31],
                       instr[19:12], instr[20], instr[30:21], 1'b0};

        endcase
    end

endmodule

