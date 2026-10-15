module ROM_Instrucciones(
    input [3:0] DirInstruccion,
    output [11:0] Instruccion
);

reg [11:0] mem_inst [0:15];

assign Instruccion = mem_inst[DirInstruccion];

initial begin
    $readmemb("instrucciones.txt", mem_inst);
end

endmodule