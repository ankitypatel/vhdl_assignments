-- NAME   : ANKIT PATEL
-- PROCESS: DIGITAL COUNTER ON ALTERA DE-1 BOARD
--			CLOCK: 50 MHZ
			



library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.std_logic_unsigned.ALL;

entity counter is
port(
     clk : in std_logic;
	 reset : in std_logic;
	 count : out std_logic_vector(5 downto 0)

);
end counter;

architecture RTL of counter is
	signal divider : std_logic_vector(25 downto 0);
	signal one_second : std_logic;
	signal seconds : std_logic_vector (5 downto 0);
begin
-- PROCESS BLOCK TO COUNT ONE SECOND ON BASIS OF CLOCK CYCLE
	process(clk)
	begin
		if(rising_edge(clk)) then
			if(reset='0') then
				if (divider = (50000000-1)) then
					divider <= (others => '0');
					one_second <= '1';
				else
					divider <= divider + 1;
				end if;		
			else
				divider <= (others => '0');
			end if;
		end if;
	end process;

-- PROCESS BLOCK TO INCREMENT COUNTER PER SECOND
	process(clk)
	begin
		if(rising_edge(clk)) then
			if (reset ='0') then
				if (one_second = '1') then
					seconds <= seconds+1;
				end if;
			else
				seconds <= (others => '0');
			end if;
		end if;
	end process;
	count <= seconds;
end RTL;
