
-- NAME   : ANKIT PATEL
-- PROCESS: SIMPLE MAGNITUDE COMPARATOR ON ALTERA DE-1 BOARD
--			



library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_logic_unsigned.ALL;
use IEEE.NUMERIC_STD.ALL;

entity magnitude_comparator is
port(
sw: in std_logic_vector(7 downto 0);
led: out std_logic_vector(2 downto 0)
);
end magnitude_comparator;

architecture RTL of magnitude_comparator is

signal A :std_logic_vector(3 downto 0);
signal B :std_logic_vector(3 downto 0);
signal GT:std_logic;
signal EQ:std_logic;
Signal LT:std_logic;

begin
	A <= sw(3 downto 0);
	B(3 downto 0)<=sw(7 downto 4);
	process(A,B)
	begin
		if(A=B) then
			EQ <='1';
		else
			EQ <='0';
		end if;
		
		GT <='0';
		if(to_integer(unsigned(A))>to_integer(unsigned(B)) )then
			GT<='1';
		end if;
 
		LT <='0';
		if(to_integer(unsigned(A))< to_integer(unsigned(B)) )then
			LT<='1';
		end if;
 
	end process;
	led(0)<= LT;
	led(1)<=EQ;
	led(2)<=GT;
end RTL;
