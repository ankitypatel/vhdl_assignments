-- NAME   : ANKIT PATEL
-- PROCESS: BASIC GATES ON ALTERA DE-1 BOARD
-- 			AND, OR, XOR, NAND, NOR, XNOR




library ieee;
use IEEE.std_logic_1164.all;

entity basic_gates is 
port (
	sw : in std_logic_vector(1 downto 0);
	led : out std_logic_vector(5 downto 0)
);
end basic_gates;
  
architecture RTL of basic_gates is
begin
	process(sw)
	begin
		led(0)<=sw(0) AND sw(1);       -- AND GATE
		led(1)<=sw(0) OR sw(1);        -- OR GATE
		led(2)<=NOT(sw(0) AND sw(1));  -- NAND GATE
		led(3)<=NOT(sw(0) OR sw(1));   -- NOR GATE
		led(4)<=sw(0) XOR sw(1);       -- XOR GATE
		led(5)<=NOT(sw(0) XOR sw(1));  -- XNOR GATE
	end process;
end RTL;
