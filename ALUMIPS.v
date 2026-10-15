module ALUMIPS (
    input [3:0] ALUctl,
    input [31:0] A, B,
    output reg [31:0] ALUOut,
    output Zero
);

    assign Zero = (ALUOut == 0);

    always @(ALUctl, A, B) begin
        case (ALUctl)
            4'b0000: ALUOut <= A & B;                 // AND
            4'b0001: ALUOut <= A | B;                 // OR
            4'b0010: ALUOut <= A + B;                 // SUMA
            4'b0110: ALUOut <= A - B;                 // RESTA
            4'b0111: ALUOut <= (A < B) ? 1 : 0;       // SLT
            4'b1100: ALUOut <= ~(A | B);                // NOR
            default: ALUOut <= 0;                     // Valor por defecto
        endcase
    end

endmodule
