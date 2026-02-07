module control_unit (
    input  [6:0] opcode,
    input  [2:0] funct3,
    input  [6:0] funct7,

    output reg        reg_write,
    output reg        mem_write,
    output reg        alu_src,      // 0 = rs2, 1 = imm
    output reg [1:0]  alu_src_a,    // 00 = rs1, 01 = PC, 10 = zero
    output reg [1:0]  result_src,   // 00 = ALU, 01 = MEM, 10 = PC+4
    output reg        branch,
    output reg        jump,
    output reg        jalr,
    output reg [3:0]  alu_ctrl
);

    // ALU control codes (must match ALU)
    localparam ADD  = 4'b0000;
    localparam SUB  = 4'b1000;
    localparam SLL  = 4'b0001;
    localparam SLT  = 4'b0010;
    localparam SLTU = 4'b0011;
    localparam XOR  = 4'b0100;
    localparam SRL  = 4'b0101;
    localparam SRA  = 4'b1101;
    localparam OR   = 4'b0110;
    localparam AND  = 4'b0111;

    always @(*) begin
        // ---------------- Default values (NOP) ----------------
        reg_write  = 1'b0;
        mem_write  = 1'b0;
        alu_src    = 1'b0;
        alu_src_a  = 2'b00;
        result_src = 2'b00;
        branch     = 1'b0;
        jump       = 1'b0;
        jalr       = 1'b0;
        alu_ctrl   = ADD;

        case (opcode)

            // ================= R-TYPE =================
            7'b0110011: begin
                reg_write = 1'b1;
                alu_src   = 1'b0;

                case (funct3)
                    3'b000: alu_ctrl = funct7[5] ? SUB : ADD;
                    3'b001: alu_ctrl = SLL;
                    3'b010: alu_ctrl = SLT;
                    3'b011: alu_ctrl = SLTU;
                    3'b100: alu_ctrl = XOR;
                    3'b101: alu_ctrl = funct7[5] ? SRA : SRL;
                    3'b110: alu_ctrl = OR;
                    3'b111: alu_ctrl = AND;
                endcase
            end

            // ================= I-TYPE ALU =================
            7'b0010011: begin
                reg_write = 1'b1;
                alu_src   = 1'b1;

                case (funct3)
                    3'b000: alu_ctrl = ADD;   // ADDI
                    3'b010: alu_ctrl = SLT;
                    3'b011: alu_ctrl = SLTU;
                    3'b100: alu_ctrl = XOR;
                    3'b110: alu_ctrl = OR;
                    3'b111: alu_ctrl = AND;
                    3'b001: alu_ctrl = SLL;
                    3'b101: alu_ctrl = funct7[5] ? SRA : SRL;
                endcase
            end

            // ================= LOAD =================
            7'b0000011: begin
                reg_write  = 1'b1;
                alu_src    = 1'b1;
                result_src = 2'b01; // memory
                alu_ctrl   = ADD;   // address calc
            end

            // ================= STORE =================
            7'b0100011: begin
                mem_write = 1'b1;
                alu_src   = 1'b1;
                alu_ctrl  = ADD;
            end

            // ================= BRANCH =================
            // BEQ / BNE (branch condition handled in PC logic)
            7'b1100011: begin
                branch   = 1'b1;
                alu_src  = 1'b0;
                alu_ctrl = SUB;   // rs1 - rs2 → zero flag
            end

            // ================= JAL =================
            7'b1101111: begin
                jump       = 1'b1;
                reg_write = 1'b1;
                result_src = 2'b10; // PC+4
            end

            // ================= JALR =================
            7'b1100111: begin
                jalr       = 1'b1;
                reg_write  = 1'b1;
                alu_src    = 1'b1;
                result_src = 2'b10;
                alu_ctrl   = ADD;   // rs1 + imm
            end

            // ================= LUI =================
            7'b0110111: begin
                reg_write = 1'b1;
                alu_src   = 1'b1;
                alu_src_a = 2'b10; // zero
                alu_ctrl  = ADD;   // 0 + imm
            end

            // ================= AUIPC =================
            7'b0010111: begin
                reg_write = 1'b1;
                alu_src   = 1'b1;
                alu_src_a = 2'b01; // PC
                alu_ctrl  = ADD;   // PC + imm
            end

            // ================= SYSTEM =================
            7'b1110011: begin
                // ECALL / EBREAK → treat as NOP
            end

            default: begin
                // Unsupported → NOP
            end
        endcase
    end

endmodule
