library IEEE;
USE IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

-- împărțirtor fara restaurare (impartitor negativ, deimpartit pozitiv) --
--  n=8 biti
--                  op1[n:0]    op2[n:0]
--                   ____|______|_____
--                  |                 |
--         start  __|    Impartitor   |
--                  |       fara      |__  valid
--            ck  __|    restaurare   |
--                  |                 |
--       reset_n  __|                 |
--                  |                 |
--                  |_________________|
--                          |
--                      result[n:0]


ENTITY impartitor_fara_restaurare_8b IS 
GENERIC (
            NR_BITI: INTEGER :=8
        );

PORT ( start: IN std_logic;                                         -- semnal pentru startul operatiei de împărțire
       ck: IN std_logic;                                            -- semnal de ceas
       reset_n: IN std_logic;                                       -- reset asincron, activ în 0
       op1: IN std_logic_vector (7 DOWNTO 0);                       -- primul operand
       op2: IN std_logic_vector (7 DOWNTO 0);                       -- al doilea operand
       result: OUT std_logic_vector (7 DOWNTO 0);                   -- rezultat
       valid: OUT std_logic);                                       -- rezultat valid al operației de împărțire
END impartitor_fara_restaurare_8b;

