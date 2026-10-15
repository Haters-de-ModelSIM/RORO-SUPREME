`timescale 1ns / 1ps

module tb_RORO;

    reg [11:0] Instruccion;

    wire [31:0] Resultado;
    wire ZF;

    RORO u_RORO (
        .Instruccion(Instruccion),
        .Resultado(Resultado),
        .ZF(ZF)
    );

    reg [11:0] instrucciones_test [0:15];
    integer i;

    initial begin
        instrucciones_test[0]  = 12'h200;
        instrucciones_test[1]  = 12'h211;
        instrucciones_test[2]  = 12'h222;
        instrucciones_test[3]  = 12'h233;
        instrucciones_test[4]  = 12'h244;
        instrucciones_test[5]  = 12'h255;
        instrucciones_test[6]  = 12'h666;
        instrucciones_test[7]  = 12'h677;
        instrucciones_test[8]  = 12'h688;
        instrucciones_test[9]  = 12'h699;
        instrucciones_test[10] = 12'h6AA;
        instrucciones_test[11] = 12'h6BB;
        instrucciones_test[12] = 12'h7CC;
        instrucciones_test[13] = 12'h7DD;
        instrucciones_test[14] = 12'h7EE;
        instrucciones_test[15] = 12'h7FF;

        $dumpfile("wave_roro.vcd");
        $dumpvars(0, tb_RORO);
        $display("\n--- INICIANDO PRUEBAS ---\n");
        for (i = 0; i < 16; i = i + 1) begin
            Instruccion = instrucciones_test[i];
            #9;
            $display("RR: Caso: %0d | Instruccion: %h | Resultado: %0d | ZF: %b", 
            i, Instruccion, Resultado, ZF);
            #1;
        end
        $finish;
    end

endmodule