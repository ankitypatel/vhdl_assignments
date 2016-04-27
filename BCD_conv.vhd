
-- NAME   : ANKIT PATEL
-- PROCESS: BCD CONVERTOR ON ALTERA DE-1 BOARD
--			

library IEEE;
use IEEE.std_logic_1164.all;
entity bcd_conv is 
port (
	INP : in std_logic_vector(3 downto 0);
	SEG : out std_logic_vector(6 downto 0)
);
end bcd_conv;
  
architecture RTL of bcd_conv is
begin
	process (INP) 
	begin
	case INP is
		when "0000" => SEG <= "0000001"; -- 0
		when "0001" => SEG <= "1001111"; -- 1
		when "0010" => SEG <= "0010010"; -- 2
		when "0011" => SEG <= "0000110"; -- 3
		when "0100" => SEG <= "1001100"; -- 4
		when "0101" => SEG <= "0100100"; -- 5
		when "0110" => SEG <= "0100000"; -- 6
		when "0111" => SEG <= "0001111"; -- 7
		when "1000" => SEG <= "0000000"; -- 8
		when "1001" => SEG <= "0000100"; -- 9
		when "1010" => SEG <= "0001000"; -- A
		when "1011" => SEG <= "0000000"; -- B
		when "1100" => SEG <= "0110001"; -- C
		when "1101" => SEG <= "0000001"; -- D
		when "1110" => SEG <= "0110000"; -- E
		when "1111" => SEG <= "0111000"; -- F
		when others => SEG <= "1111111"; 
	end case;
	end process;
end RTL;
