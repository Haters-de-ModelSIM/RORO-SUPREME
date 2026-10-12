module RORO_Supreme(
    input [3:0] DirInstruccion,
    output [31:0] DD,
    output ZF,
    output [11:0] InstOut
);

wire [11:0] w_instruccion;

assign InstOut = w_instruccion;

ROM_Instrucciones ROM_INST(
    .DirInstruccion(DirInstruccion),
    .Instruccion(w_instruccion)
);

RORO RORO_CORE(
    .Instruccion(w_instruccion),
    .Resultado(DD),
    .ZF(ZF)
);

endmodule