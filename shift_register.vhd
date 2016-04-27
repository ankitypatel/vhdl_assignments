-- NAME   : ANKIT PATEL
-- PROCESS: SHIFT REGISTER ON ALTERA DE-1 BOARD
-- 			

-- NAME   : ANKIT PATEL
-- PROCESS: UNIVERSAL SHIFT REGISTER (LIKE IC 74LS194)ON ALTERA DE-1 BOARD
--			00 => HOLD
--			01 => SHIFT LEFT
--			10 => SHIFT RIGHT
--          11 => PARELLAL LOAD




library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;


entity shift_register is
port(
sw:IN std_logic_vector(7 downto 0);
ledr:OUT std_logic_vector(3 downto 0);
clk:in std_logic
);
end shift_register ;


architecture RTL of shift_register is
	signal R : std_logic_vector(3 downto 0) ;
	signal S : std_logic_vector(1 downto 0);
	begin
		S <= SW(7 downto 6);
		ledr <= R;
		process(CLK)
		begin
		if(rising_edge(CLK)) then 
			case S is
				when "00" => NULL;
				when "01" => R <= (R(2 downto 0) & SW(0));
				when "10" => R <= (SW(5) & R(3 downto 1));
				when "11" => R <= SW(4 downto 1);
				when others => NULL;
			end case;
        end if;
		end process;
end RTL;
