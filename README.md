# Morra Cinese (FSM & Datapath in SystemVerilog/SIS)

Progetto realizzato per il corso di Laboratorio di Architettura degli Elaboratori.
Sviluppo in SIS e SystemVerilog di un dispositivo hardware per la gestione automatizzata di partite di Morra Cinese secondo le regole classiche.

## Regole e Specifiche

Il circuito gestisce una partita composta da più manche.
- **Numero di manche massime:** calcolato dinamicamente sommando un minimo fisso (4) alla concatenazione degli input dei due giocatori durante il primo turno, per un massimo di 19 manche.
- **Condizione di vittoria:** vince il primo giocatore che, superate le 4 manche minime, ottiene un vantaggio di almeno 2 punti sull'avversario, oppure chi si trova in vantaggio al raggiungimento del limite massimo di manche.
- **Limitazione sulle mosse:** il vincitore di una singola manche non può ripetere la stessa mossa nel turno immediatamente successivo.

### Ingressi
- `PRIMO [2]`: Mossa del Giocatore 1 (00: Nessuna mossa, 01: Sasso, 10: Carta, 11: Forbice).
- `SECONDO [2]`: Mossa del Giocatore 2 (00: Nessuna mossa, 01: Sasso, 10: Carta, 11: Forbice).
- `INIZIO [1]`: Segnale di reset per riportare il sistema allo stato iniziale.

### Uscite
- `MANCHE [2]`: Esito della manche (00: Non valida, 01: Vinta da P1, 10: Vinta da P2, 11: Pareggio).
- `PARTITA [2]`: Esito finale della partita (00: Non finita, 01: Vinta da P1, 10: Vinta da P2, 11: Pareggio).

## Architettura del Sistema

Il progetto è strutturato separando la Macchina a Stati Finiti (FSM) dal Datapath per l'elaborazione dei dati.

### Datapath
Il datapath è suddiviso in 4 macro-sezioni:
1. **Counter Manche:** utilizza due registri a 5 bit. Il primo immagazzina il numero massimo di manche consentite (calcolato al primo turno); il secondo funge da contatore incrementandosi a ogni manche valida. Un comparatore segnala il raggiungimento delle manche massime.
2. **Calcolo Combinatorio Manche:**
   - Determina il vincitore confrontando le mosse (es. Sasso vs Carta). In caso di mosse uguali viene generato un pareggio (`MANCHE = 11`).
   - Memorizza in registri dedicati le mosse vincenti vietate per il turno successivo; se viene giocata una mossa vietata, la manche risulta non valida (`MANCHE = 00`).
3. **Storing Punteggi:** due registri a 5 bit memorizzano il punteggio di P1 e P2. Il segnale `MANCHE` pilota un demultiplexer che somma 1 al punteggio del vincitore (in caso di pareggio i punteggi non si incrementano).
4. **Condizioni di Fine Partita:** monitora i punteggi verificando il vantaggio minimo di 2 punti e il superamento delle manche minime. I componenti di calcolo generano il segnale definitivo per l'uscita `PARTITA`.

### FSM
Una FSM minimale a 2 stati (`ATTESA`, `GIOCA`) gestisce i segnali di reset (`INIZIA`) e l'abilitazione del calcolo (`PLAY`). La maggior parte della complessità computazionale è delegata al datapath.

## Flusso di Progettazione

1. **Sintesi Logica (SIS):** i componenti del datapath e la FSM sono stati descritti in formato `.blif`. Tramite il tool SIS (utilizzando script `rugged` e mappatura con libreria `synch.genlib`), la rete è stata ottimizzata con rimozione serial/parallel inverters.
2. **Implementazione Verilog:** il modulo `MorraCinese` implementa l'intera logica (FSM combinata con il datapath sequenziale e combinatorio).
3. **Simulazione e Testbench:** il modulo `testbench.sv` applica una serie temporizzata di input (`PRIMO`, `SECONDO`, `INIZIA`), generando in output un file di testo per la verifica dei segnali e un dump `.vcd` per l'analisi delle forme d'onda.
