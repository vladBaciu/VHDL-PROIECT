
ARCHITECTURE impartitor_fara_restaurare_8b_beh OF impartitor_fara_restaurare_8b is



--************START DECLARATII FSM**************--
TYPE state IS (init,load_op,shift_decision,shift_P1,shift_P2,shift_A,addto_P,addto_A,ready);
SIGNAL currentState: state;
SIGNAL nextState:    state;
--************STOP DECLARATII FSM****************--


--*******************START SEMNALE DE CONTROL*********************--
SIGNAL SG_INIT_OP: std_logic :='0';
SIGNAL SG_LOAD_OP: std_logic :='0';
SIGNAL SG_SHIFT_P1: std_logic :='0';
SIGNAL SG_SHIFT_P2: std_logic :='0';
SIGNAL SG_SHIFT_A: std_logic :='0';
SIGNAL SG_ADDTO_P: std_logic :='0';
SIGNAL SG_ADDTO_A: std_logic :='0';
SIGNAL SG_READY: std_logic   :='0';
SIGNAL SG_DECISION: std_logic :='0';

--*******************STOP SEMNALE DE CONTROL*********************--


SIGNAL A: std_logic_vector (NR_BITI-1 DOWNTO 0) := "00000000";
SIGNAL A_negat: signed (NR_BITI-1 DOWNTO 0) := "00000000";
SIGNAL B: std_logic_vector (NR_BITI-1 DOWNTO 0) := "00000000";
SIGNAL B_negat: signed (NR_BITI-1 DOWNTO 0) := "00000000";
SIGNAL P: signed (NR_BITI DOWNTO 0)   := "000000000";
SIGNAL n: std_logic_vector (NR_BITI-5 DOWNTO 0) := "1000";
BEGIN   


-- FSM MOORE
    CONTROL: PROCESS (reset_n,ck)
	

 BEGIN

    IF (reset_n = '0') THEN
    nextState <= init;
    ELSIF rising_edge (ck) THEN
 
        CASE currentState is
        WHEN init =>    IF (start = '1')        THEN
                             nextState <= load_op;
                             
                        END IF;
        WHEN load_OP => IF (reset_n = '0')      THEN
                            nextState <= init;
                        ELSE 
                            nextState <= shift_decision;
                        END IF;
        WHEN shift_decision =>  IF (reset_n = '0')      THEN
                                      nextState <= init;
                                ELSIF (P(NR_BITI)='0') THEN
                                       nextState <= shift_P1;  
                                ELSIF (P(NR_BITI)='1') THEN
                                       nextState <= shift_P2;  
                                END IF;


        WHEN shift_P1 => IF (reset_n = '0')      THEN
                            nextState <= init;
                        ELSE 
                            nextState <=shift_A;
            
                        END IF;
        WHEN shift_P2 => IF (reset_n = '0')      THEN
                             nextState <= init;
                        ELSE 
                             nextState <=shift_A;
        
                        END IF;
        WHEN shift_A => IF (reset_n = '0')      THEN
                            nextState <= init;
                        ELSIF (n = "0000")         THEN
                            IF (P(NR_BITI)='1')    THEN 
                                nextState <=addto_P;
                            ELSE
                                nextState <=addto_A;
                            END IF;
                        ELSE
                            nextState <=shift_decision;
                         
                        END IF;
        WHEN addto_P => IF (reset_n = '0')      THEN
                            nextState <= init;
                        ELSE 
                            nextState <=addto_A;
                        END IF;
        WHEN addto_A => IF (reset_n = '0')      THEN
                            nextState <= init;
                        ELSE 
                            nextState <= ready;
                        END IF;
        WHEN ready  =>  IF (reset_n = '0')      THEN
                            nextState <= init;
                        ELSE 
                            nextState <=init;
                        END IF;             
        END CASE; 
    END IF;
    
    END PROCESS CONTROL;            

-- STARE CURENTA
    REG: PROCESS (ck,reset_n) BEGIN
      IF (reset_n='0')				 THEN
            currentState <= init;
      ELSIF rising_edge (ck) THEN   
            currentState <= nextState;
      END IF;
    END PROCESS REG;

-- SEMNALE DE CONTROL
     SEMNALE: PROCESS (currentState) BEGIN 
        IF (currentState = init)                THEN    

                SG_INIT_OP <= '1';
                SG_LOAD_OP <= '0';
                SG_SHIFT_P1 <= '0';
                SG_SHIFT_A <= '0';
                SG_ADDTO_P <= '0';
                SG_ADDTO_A <= '0';
                SG_READY   <= '0';
                SG_DECISION <= '0';
                SG_SHIFT_P2 <= '0';

         ELSIF (currentState = shift_decision)          THEN

                SG_INIT_OP <= '0';
                SG_LOAD_OP <= '0';
                SG_SHIFT_P1 <= '0';
                SG_SHIFT_A <= '0';
                SG_ADDTO_P <= '0';
                SG_ADDTO_A <= '0';
                SG_READY   <= '0';
                SG_DECISION <= '1';
                SG_SHIFT_P2 <= '0';

        ELSIF (currentState = load_op)          THEN
        
                SG_INIT_OP <= '0';
                SG_LOAD_OP <= '1';
                SG_SHIFT_P1 <= '0';
                SG_SHIFT_A <= '0';
                SG_ADDTO_P <= '0';
                SG_ADDTO_A <= '0';
                SG_READY   <= '0';
                SG_DECISION <= '0';
                SG_SHIFT_P2 <= '0';

        ELSIF (currentState = shift_P1)          THEN  

                SG_SHIFT_P2 <= '0';
                SG_LOAD_OP <= '0';
                SG_SHIFT_P1 <= '1';
                SG_SHIFT_A <= '0';
                SG_ADDTO_P <= '0';
                SG_ADDTO_A <= '0';
                SG_READY   <= '0';
                SG_INIT_OP <= '0';
                SG_DECISION <= '0';

        ELSIF (currentState = shift_P2)          THEN  

                SG_SHIFT_P2 <= '1';
                SG_LOAD_OP <= '0';
                SG_SHIFT_P1 <= '0';
                SG_SHIFT_A <= '0';
                SG_ADDTO_P <= '0';
                SG_ADDTO_A <= '0';
                SG_READY   <= '0';
                SG_INIT_OP <= '0';
                SG_DECISION <= '0';        

        ELSIF (currentState = shift_A)          THEN

                SG_LOAD_OP <= '0';
                SG_SHIFT_P1 <= '0';
                SG_SHIFT_A <= '1';
                SG_ADDTO_P <= '0';
                SG_ADDTO_A <= '0';
                SG_READY   <= '0';
                SG_INIT_OP <= '0';
                SG_DECISION <= '0';
                SG_SHIFT_P2 <= '0';

        ELSIF (currentState = addto_P)          THEN

                SG_LOAD_OP <= '0';
                SG_SHIFT_P1 <= '0';
                SG_SHIFT_A <= '0';
                SG_ADDTO_P <= '1';
                SG_ADDTO_A <= '0';
                SG_READY   <= '0';
                SG_INIT_OP <= '0';
                SG_DECISION <= '0';
                SG_SHIFT_P2 <= '0';

        ELSIF (currentState = addto_A)          THEN  

                SG_LOAD_OP <= '0';
                SG_SHIFT_P1 <= '0';
                SG_SHIFT_A <= '0';
                SG_ADDTO_P <= '0';
                SG_ADDTO_A <= '1';
                SG_READY   <= '0';
                SG_INIT_OP <= '0';
                SG_DECISION <= '0';
                SG_SHIFT_P2 <= '0';

        ELSIF (currentState = ready)            THEN  

                SG_LOAD_OP <= '0';
                SG_SHIFT_P1 <= '0';
                SG_SHIFT_A <= '0';
                SG_ADDTO_P <= '0';
                SG_ADDTO_A <= '0';
                SG_READY   <= '1';
                SG_INIT_OP <= '0';
                SG_DECISION <= '0';
                SG_SHIFT_P2 <= '0';
        END IF;
     END PROCESS SEMNALE;

-- INIT OUTPUT PORTS
        INIT_OUTPUTS: PROCESS(reset_n)  BEGIN 
        IF (reset_n = '0')   THEN
                    valid  <= '0'; 
                    result <= "00000000";  
         
        END IF;
        END PROCESS INIT_OUTPUTS;

         
        CALE_CONTROL: PROCESS (currentState, SG_LOAD_OP,SG_SHIFT_P1,SG_SHIFT_A,SG_ADDTO_P,SG_ADDTO_A,SG_READY,SG_INIT_OP,SG_DECISION,SG_SHIFT_P2)
        BEGIN
                IF rising_edge(SG_LOAD_OP) THEN          -- INCARCARE OPERANZI IN REGISTRII
                    A <= op1;
                    B <= op2;
                    A_negat <= signed(to_unsigned(to_integer(unsigned( not(op1) )) + 1, 8));      -- A negat in complement fata de 2
                    B_negat <= signed(to_unsigned(to_integer(unsigned( not(op2) )) + 1, 8));      -- A negat in complement fata de 2
                    P <= P + signed(to_unsigned(to_integer(unsigned( not(op2) )) + 1, 8));
                ELSIF rising_edge(SG_DECISION) THEN
                
                    P <= P sll 1;  
                    P(0) <= A(NR_BITI-1);
                    n <=std_logic_vector(unsigned(n)-1);
                    
                     

                ELSIF rising_edge(SG_SHIFT_P1) THEN

                    P <= signed(P+B_negat);

                    

                ELSIF rising_edge(SG_SHIFT_P2) THEN

                     P <= P + signed(B); 
                   
                ELSIF rising_edge(SG_SHIFT_A) THEN

                    A <= std_logic_vector(signed(A) sll 1);
                    A(0) <= P(NR_BITI);      

                ELSIF rising_edge(SG_ADDTO_P) THEN

                    P<= P + B_negat;                    

                ELSIF rising_edge(SG_ADDTO_A) THEN

                    A <= std_logic_vector(signed(A) sll 1);
                    A(0) <= P(NR_BITI);
                    A <= std_logic_vector(unsigned(A) + 1);

                ELSIF rising_edge(SG_READY) THEN
                  
                ELSIF rising_edge(SG_INIT_OP) THEN
                   n <= "1000";
                   A <= "00000000";
                   A_negat <= "00000000";
                   B <= "00000000";
                   B_negat <= "00000000";
                   P <= "000000000";
                END IF;

        END PROCESS CALE_CONTROL;




END impartitor_fara_restaurare_8b_beh;


