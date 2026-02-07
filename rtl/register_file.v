module register_file (
    input         clk,
    input         we3,          // Write Enable
    input  [4:0]  a1,           // Read address 1
    input  [4:0]  a2,           // Read address 2
    input  [4:0]  a3,           // Write address
    input  [31:0] wd3,          // Write data
    output [31:0] rd1,          // Read data 1
    output [31:0] rd2           // Read data 2
);

    reg [31:0] rf [31:0]; // 32 registers

    // Synchronous write (x0 is hardwired to zero)
    always @(posedge clk) begin
        if (we3 && (a3 != 5'b00000)) begin
            rf[a3] <= wd3;
        end
    end

    // Asynchronous read
    assign rd1 = (a1 != 5'b00000) ? rf[a1] : 32'b0;
    assign rd2 = (a2 != 5'b00000) ? rf[a2] : 32'b0;

endmodule

