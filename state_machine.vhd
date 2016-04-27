-- NAME   : ANKIT PATEL
-- PROCESS: CROSS WALK IMPLEMETION USING STATE MACHINE ON ALTERA DE-1 BOARD
--			IF BUTTON IS PRESSED BY PEDESTRIAN THEN FOLLOWING SEQUENCE WILL BE INITIATED
--			GREEN => GREEN WAIT [3 SEC]=> YELLOW => YELLOW WAIT [5 SEC] => RED => RED WAIT [10 SEC] => GREEN





library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.std_logic_unsigned.ALL;

entity STATE_MACHINE is
port(
     clk : in std_logic;
	 button : in std_logic;
	 redled:out std_logic;
	 greenled:out std_logic;
	 yellowled:out std_logic
);
end STATE_MACHINE;

architecture RTL of STATE_MACHINE is
type crosswalk is(green,greenwait,yellow,yellowwait,red,redwait);
	signal NextState:crosswalk;
	signal currentState:crosswalk;
	signal reset:std_logic;
	signal divider : std_logic_vector(25 downto 0);
	signal one_second : std_logic;
	signal seconds : std_logic_vector (5 downto 0);

	begin
	process(clk)
		begin
			if(rising_edge(clk)) then
				one_second <= '0';
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

	process(CLK)
	begin
		if(rising_edge(CLK)) then
			currentState <= NextState;
		end if;
	end process;

	process(currentState,button,seconds) 
	begin
		NextState <= currentState;
		case currentState is
		
		-- GREEN SIGNAL
			when green => 	
				greenled<='1';
				yellowled<='0';
				redled<='0';
				reset<='1';
				if(button='0') then
					nextState<=greenwait;
				end if;
 
			when greenWait =>	
				greenled<='1';
				yellowled<='0';
				redled<='0';
				if(seconds=3) then
					NextState<=yellow;
				end if;
				reset<='0';
				
		-- YELLOW SIGNAL
			when yellow =>
				redled<='0';
				yellowled<='1';
				greenled<='0';
				reset<='1';
				NextState<=yellowwait;
 
			when yellowwait =>
				redled<='0';
				yellowled<='1';
				greenled<='0';
				if(seconds=5) then
					NextState<=red;
				end if;
				reset<='0';
				
        -- RED SIGNAL
			when red =>
				greenled<='0';
				redled<='1';
				yellowled<='0';
				reset<='1';
				NextState<=redwait;
 
			when redwait =>
				greenled<='0';
				redled<='1';
				yellowled<='0';
				if(seconds=10) then
					NextState<=green;
				end if;
				reset<='0';
 
		end case;
	end process;		
end RTL;
