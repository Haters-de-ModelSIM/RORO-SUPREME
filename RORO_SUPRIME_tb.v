`timescale 1ns / 1ps

module RORO_Supreme_tb();

    reg [3:0] DirInstruccion;
    wire [31:0] DD;
    wire ZF;
    wire [11:0] InstOut;

    RORO_Supreme uut (
        .DirInstruccion(DirInstruccion),
        .DD(DD),
        .ZF(ZF),
        .InstOut(InstOut)
    );

    reg [31:0] expected_DD [0:15];
    reg expected_ZF [0:15];
    integer i;

    initial begin
        expected_DD[0]=32'd17;          
        expected_ZF[0]=1'b0;
        expected_DD[1]=32'd21;          
        expected_ZF[1]=1'b0;
        expected_DD[2]=32'd35;          
        expected_ZF[2]=1'b0;
        expected_DD[3]=32'd12;          
        expected_ZF[3]=1'b0;
        expected_DD[4]=32'd60;          
        expected_ZF[4]=1'b0;
        expected_DD[5]=32'd48;          
        expected_ZF[5]=1'b0;
        expected_DD[6]=32'd0;           
        expected_ZF[6]=1'b1;
        expected_DD[7]=32'd9;          
        expected_ZF[7]=1'b0;
        expected_DD[8]=32'd51;          
        expected_ZF[8]=1'b0;
        expected_DD[9]=32'hFFFFFFD7;    
        expected_ZF[9]=1'b0; 
        expected_DD[10]=32'd97;         
        expected_ZF[10]=1'b0;
        expected_DD[11]=32'd0;          
        expected_ZF[11]=1'b1;
        expected_DD[12]=32'd0;          
        expected_ZF[12]=1'b1;
        expected_DD[13]=32'd0;          
        expected_ZF[13]=1'b1;
        expected_DD[14]=32'd1;          
        expected_ZF[14]=1'b0;
        expected_DD[15]=32'd0;          
        expected_ZF[15]=1'b1;

        $dumpfile("wave.vcd");
        $dumpvars(0, RORO_Supreme_tb);

        for (i = 0; i < 16; i = i + 1) begin
            DirInstruccion = i;
            #10;
            if (DD === expected_DD[i] && ZF === expected_ZF[i]) begin
                $display("RRS: [PASS] Caso: %0d | OP: %0d | ROMa_Dir: %0d | ROMina_Dir: %0d | DD: %0d | ZF: %b\n", 
                         i, InstOut[11:8], InstOut[7:4], InstOut[3:0], DD, ZF);
            end else begin
                $display("RRS: [FAIL] Caso: %0d | OP: %0d | ROMa_Dir: %0d | ROMina_Dir: %0d | DD Obt: %0d (Esp: %0d) | ZF Obt: %b (Esp: %b)\n", 
                         i, InstOut[11:8], InstOut[7:4], InstOut[3:0], DD, expected_DD[i], ZF, expected_ZF[i]);
            end
        end

        $finish;
    end

endmodule