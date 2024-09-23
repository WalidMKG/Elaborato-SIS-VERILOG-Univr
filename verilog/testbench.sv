
module testebench();
integer tbf, outf ;

reg clk;
reg INIZIA;
reg[1:0] PRIMO, SECONDO;
wire[1:0] MANCHE, PARTITA;
MorraCinese MORRA(clk, PRIMO, SECONDO, INIZIA, MANCHE, PARTITA );
always #10 clk = ~clk;

initial begin
    $dumpfile("dump.vcd");
    $dumpvars(1);
    tbf = $fopen("testbench.script", "w");
    outf = $fopen("output_verilog.txt", "w");
    $fdisplay(tbf, "read_blif FSMD.blif");
    clk = 1'b0;
    PRIMO = 2'b10;
    SECONDO = 2'b10;
    INIZIA = 1'b1;
    $fdisplay(tbf, "simulate %b %b %b %b ", PRIMO[1], PRIMO[0], SECONDO[1], SECONDO[0], INIZIA);
    #20
    $fdisplay(outf, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);
    #20
    PRIMO = 2'b01;
    SECONDO = 2'b11;
    INIZIA = 1'b0;
    $fdisplay(tbf, "simulate %b %b %b %b ", PRIMO[1], PRIMO[0], SECONDO[1], SECONDO[0], INIZIA);
    #20
    $fdisplay(outf, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);
    #20
    PRIMO = 2'b11;
    SECONDO = 2'b01;
    INIZIA = 1'b0;
    $fdisplay(tbf, "simulate %b %b %b %b ", PRIMO[1], PRIMO[0], SECONDO[1], SECONDO[0], INIZIA);
    #20
    $fdisplay(outf, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);
    #20
    PRIMO = 2'b11;
    SECONDO = 2'b10;
    INIZIA = 1'b0;
    $fdisplay(tbf, "simulate %b %b %b %b ", PRIMO[1], PRIMO[0], SECONDO[1], SECONDO[0], INIZIA);
    #20
    $fdisplay(outf, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);
    #20
    PRIMO = 2'b01;
    SECONDO = 2'b01;
    INIZIA = 1'b0;
    $fdisplay(tbf, "simulate %b %b %b %b ", PRIMO[1], PRIMO[0], SECONDO[1], SECONDO[0], INIZIA);
    #20
    $fdisplay(outf, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);
    #20
    PRIMO = 2'b01;
    SECONDO = 2'b10;
    INIZIA = 1'b0;
    $fdisplay(tbf, "simulate %b %b %b %b ", PRIMO[1], PRIMO[0], SECONDO[1], SECONDO[0], INIZIA);
    #20
    $fdisplay(outf, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);
    #20
  	PRIMO = 2'b11;
    SECONDO = 2'b01;
    INIZIA = 1'b0;
    $fdisplay(tbf, "simulate %b %b %b %b ", PRIMO[1], PRIMO[0], SECONDO[1], SECONDO[0], INIZIA);
    #20
    $fdisplay(outf, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);
    #20
  	PRIMO = 2'b11;
    SECONDO = 2'b10;
    INIZIA = 1'b0;
    $fdisplay(tbf, "simulate %b %b %b %b ", PRIMO[1], PRIMO[0], SECONDO[1], SECONDO[0], INIZIA);
    #20
    $fdisplay(outf, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);
    #20
  	PRIMO = 2'b10;
    SECONDO = 2'b01;
    INIZIA = 1'b0;
    $fdisplay(tbf, "simulate %b %b %b %b ", PRIMO[1], PRIMO[0], SECONDO[1], SECONDO[0], INIZIA);
    #20
    $fdisplay(outf, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);
    #20
  	PRIMO = 2'b11;
    SECONDO = 2'b10;
    INIZIA = 1'b0;
    $fdisplay(tbf, "simulate %b %b %b %b ", PRIMO[1], PRIMO[0], SECONDO[1], SECONDO[0], INIZIA);
    #20
    $fdisplay(outf, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);
    #20
  
  
    $fdisplay(tbf, "quit");
    $fclose(tbf);
    $fclose(outf);
    $finish;
end


endmodule