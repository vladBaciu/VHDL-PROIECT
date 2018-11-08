LIBRARY IEEE;
USE IEEE.numeric_std.ALL;
USE IEEE.std_logic_1164.ALL;

ENTITY impartitor_fara_rest_test is
END impartitor_fara_rest_test;


ARCHITECTURE impartitor_fara_rest_test OF impartitor_fara_rest_test is

        COMPONENT impartitor_fara_restaurare_8b
        GENERIC (
                NR_BITI: INTEGER :=8
        );
        PORT (  start: IN std_logic;                                         -- semnal pentru startul operatiei de împărțire
                ck: IN std_logic;                                            -- semnal de ceas
                reset_n: IN std_logic;                                       -- reset asincron, activ în 0
                op1: IN std_logic_vector (7 DOWNTO 0);                       -- primul operand
                op2: IN std_logic_vector (7 DOWNTO 0);                       -- al doilea operand
                result: OUT std_logic_vector (7 DOWNTO 0);                   -- rezultat
                valid: OUT std_logic); 

        END COMPONENT;


        COMPONENT impartitor_fara_restaurare_8b_tb
        GENERIC ( per : time := 20 ns;
                  NR_BITI: INTEGER :=8);
        PORT ( operand1 : OUT std_logic_vector(NR_BITI-1 DOWNTO 0);
            operand2 : OUT std_logic_vector(NR_BITI-1 DOWNTO 0);  
            start:     OUT std_logic;
            ck:        OUT std_logic;
            reset_n:   OUT std_logic );

        END COMPONENT;

        SIGNAL operand1 :std_logic_vector(7 DOWNTO 0);
        SIGNAL operand2 :std_logic_vector(7 DOWNTO 0);
        SIGNAL start :std_logic;
        SIGNAL ck :std_logic;
        SIGNAL reset_n :std_logic;

        SIGNAL result :std_logic_vector (7 DOWNTO 0);
        SIGNAL valid  :std_logic;
        
        BEGIN
        
        TB: impartitor_fara_restaurare_8b_tb GENERIC MAP (per => 20 ns,NR_BITI => 8)
                                             PORT MAP ( operand1 => operand1,
                                                        operand2 => operand2,
                                                        start    => start,
                                                        ck       => ck,
                                                        reset_n  => reset_n);
        DUTA: impartitor_fara_restaurare_8b GENERIC MAP ( NR_BITI => 8)
                                            PORT MAP (  op1 => operand1,
                                                        op2 => operand2,
                                                        start    => start,
                                                        ck       => ck,
                                                        reset_n  => reset_n,
                                                        result   => result,
                                                        valid    => valid);

END impartitor_fara_rest_test;