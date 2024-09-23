// Code your design here
module MorraCinese (
    input clk,
    input[1:0] PRIMO,
    input[1:0] SECONDO,
    input INIZIA,
  	output reg [1:0] MANCHE,
    output reg [1:0] PARTITA
 );
 parameter NESSUNA = 2'b00;
 parameter SASSO = 2'b01;
 parameter CARTA = 2'b10;
 parameter FORBICE = 2'b11;
 parameter W1 = 2'b01;
 parameter W2 = 2'b10;
 parameter DRAW = 2'b11;
 parameter NA = 2'b00;

 reg stato = 1'b0;
 reg stato_prossimo = 1'b0;
 reg play = 1'b0;
 reg [4:0] MAX = 5'b0;
 reg [4:0] PT1 = 5'b0;
 reg [4:0] PT2 = 5'b0;
 reg [1:0] IND1 = 2'b0;
 reg [1:0] IND2 = 2'b0;
 reg [4:0] ROUND = 5'b0;



// FSM 
    always @(clk) begin : UPDATE
    stato = stato_prossimo;
    end

    always @(stato, PARTITA, INIZIA ) begin : FSM
    case(stato)
    1'b0 :
    if (INIZIA)begin
        play = 1;
        stato_prossimo = 1'b0;
    end else begin
        stato_prossimo = 1'b1;
        play = 0;
    end
    1'b1:
        if( ~INIZIA && PARTITA == 2'b00 )begin
            stato_prossimo  = 1'b1;
            play = 0;
        end else begin
            stato_prossimo = 1'b0;
            play = 1; 
        end
    endcase
    end

  always @(posedge clk) begin : DATAPATH

    //RESET IN CASO play SIA 1 E DETERMINO ANCHE IL NUMERO DI MANCHE 
    if(play)begin
        MAX = {PRIMO, SECONDO} + 4;
        PT1 = 0;
        PT2 = 0;
        IND1 = 0;
        IND2 = 0;
        ROUND = 0;
        PARTITA = 0;
    end
    //PARTE COMBINATORIA PER DETERMINARE IL RISULTATO DELLA MANCHE
    if ( PRIMO == IND1 || SECONDO == IND2 || PRIMO == NESSUNA || SECONDO == NESSUNA )begin
        MANCHE = NA; 
        IND1 = IND1;
        IND2 = IND2;
    end 
    else if(PRIMO == SECONDO )begin
        MANCHE = DRAW;
        IND1 = NESSUNA;
        IND2 = NESSUNA;
    end
    else if((PRIMO == SASSO && SECONDO == FORBICE )  ||  (PRIMO == CARTA && SECONDO == SASSO )  || (PRIMO == FORBICE && SECONDO == CARTA ))
    begin
        MANCHE = W1;
        IND1  = PRIMO;
        IND2 = NESSUNA;
    end 
    else if((SECONDO == SASSO && PRIMO == FORBICE )  ||  (SECONDO == CARTA && PRIMO == SASSO )  || (SECONDO == FORBICE && PRIMO == CARTA )) 
      begin
        MANCHE = W2;
        IND1 = NESSUNA;
        IND2 = SECONDO;
    end

    // A STO PUNTO HO IL RISULTATO DELLA MANCHE AGGIORNO I REGISTRI NECESSARI
    if(MANCHE == NA) begin
        ROUND = ROUND;
        PT1 = PT1;
        PT2 = PT2;
    end
    else if(MANCHE == W1)begin
        ROUND = ROUND + 5'b00001; 
        PT1 = PT1 + 5'b00001;
        PT2 = PT2;
    end
    else if(MANCHE == W2)begin
        ROUND = ROUND + 5'b00001; 
        PT1 = PT1;
        PT2 = PT2 + 5'b00001;
    end
    else if(MANCHE == DRAW) begin
        ROUND = ROUND +1;
    end
	
    //aggiornamento del registro PARTITA    
if(ROUND > 3 && (PT1-PT2>=5'b00010 || ROUND == MAX) && PT1>PT2)begin
      PARTITA <= W1;
    end
    else if(ROUND > 3 && (PT2-PT1>=5'b00010 || ROUND == MAX) && PT2>PT1)begin
      PARTITA <= W2;
    end
    else if(ROUND == MAX && PT1==PT2 )begin
        PARTITA <= DRAW;
    end

    //FINE DATAPATH
    end
endmodule