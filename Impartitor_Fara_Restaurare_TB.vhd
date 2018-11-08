LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.std_logic_unsigned.ALL;
LIBRARY std;
USE std.textio.ALL;



ENTITY impartitor_fara_restaurare_8b_tb is
GENERIC ( per : time := 20 ns;
          NR_BITI: INTEGER :=8);
PORT ( operand1 : OUT std_logic_vector(NR_BITI-1 DOWNTO 0);
       operand2 : OUT std_logic_vector(NR_BITI-1 DOWNTO 0);  
       start:     OUT std_logic;
       ck:        OUT std_logic;
       reset_n:   OUT std_logic );
END impartitor_fara_restaurare_8b_tb;


ARCHITECTURE impartitor_fara_restaurare_8b_tb OF impartitor_fara_restaurare_8b_tb is
    SIGNAL clk_int  : std_logic := '0';
BEGIN
     clk_int <= NOT clk_int AFTER per/2;
     ck      <= clk_int;  
     operand1 <= "00000110";
     operand2 <= "00000001";
     reset_n <='0', '1' AFTER 2*per;
     start <='1';
  
END impartitor_fara_restaurare_8b_tb;


        