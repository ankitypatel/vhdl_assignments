--------------- FINAL PROJECT -------------------------------------------------------------
-- NAME   : ANKIT PATEL
-- PROCESS: COMBINATIONAL LOCK USING STATE MACHINE ON ALTERA DE-1 BOARD
--			IF ORDER OF BUTTON PRESSING MATCHES THE FOLLOWING ORDER THAN 
--          LOCK IS OPENED.
--			OPEN LOCK INDICATION : GREEN LED
--          CLOSED LOCK INDICATION : RED LED
-------------------------------------------------------------------------------------------		






library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.std_logic_unsigned.ALL;

entity lock is
port(
	 clk : in std_logic;
	 redled:out std_logic;
	 greenled:out std_logic;
	 keys: in std_logic_vector(3 downto 0)
);
end lock;

architecture RTL of lock is
type combinational_lock is(lock,wait1,key1,wait2,key2,wait3,key3,wait4,key4,unlock);
	signal NextState    : combinational_lock;
	signal currentState : combinational_lock;
	signal debounce     : std_logic_vector(3 downto 0);
	signal reset        : std_logic;
	signal divider      : std_logic_vector(25 downto 0);
	signal divide       : std_logic_vector(25 downto 0);
	signal one_second   : std_logic;
	signal pulse        : std_logic;
	signal seconds      : std_logic_vector (5 downto 0);
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

		process(clk)
		begin
			if(rising_edge(clk)) then
				pulse<='0';
				if (divide = (5000000-1)) then
					divide<= (others => '0');
					pulse <= '1';
				else
					divide <= divide + 1;
				end if;		
			else
				divide <= (others => '0');
			end if;
		end process;
		
		process(clk)
		begin
			if rising_edge(clk)then
				if(pulse<='1')then
					debounce<=keys;
				end if;
			end if;
		end process;
		
		process(CLK)
		begin
			if(rising_edge(CLK)) then
				currentState <= NextState;
			end if;
		end process;

		process(currentState,debounce,seconds) 
		begin
			NextState <= currentState;
			case currentState is
			
				when lock=>
					greenled<='0';
					redled<='1';
					reset<='1';
					if((debounce(0)='0')) then
						nextState<=wait1;
					end if;

				when wait1=>
					if (debounce(0)='1') then
						nextState<=key1;
					end if;				
				
				when key1 =>
					-- greenled<='0';
					-- redled<='1';
					if (debounce(1)='0') then
						NextState<=wait2;
					end if;
					if((debounce(2)='0')or(debounce(3)='0')or(debounce(0)='0'))then
						nextState<=lock;
					end if;
					reset<='1';

				when wait2=>
					if (debounce(1)='1') then
						NextState<=key2;
					end if;
			  
				when key2 =>
					-- redled<='1';
					--greenled<='0';
					if(debounce(2)='0') then
						NextState<=wait3;
					end if;
					if((debounce(3)='0')or(debounce(1)='0')or(debounce(0)='0'))then
						nextState<=lock;
					end if;
					reset<='1';

				when wait3=>
					if (debounce(2)='1') then
						NextState<=key3;
					end if;
				
				when key3 =>
					-- redled<='1';
					--greenled<='0';
					if(debounce(3)='0') then
						NextState<=wait4;
					end if;
					if((debounce(0)='0')or(debounce(1)='0')or(debounce(2)='0'))then
						nextState<=lock;
					end if;
					reset<='1';

				when wait4=>
					if (debounce(3)='1') then
						NextState<=key4;
					end if;

				when key4=>
					-- greenled<='0';
					-- redled<='1';
					if(debounce(3)='0') then
						NextState<=unlock;
					end if;
					if((debounce(0)='0')or(debounce(2)='0')or(debounce(1)='0'))then
						nextState<=lock;
					end if;
					reset<='1';
		 
				when unlock =>--unlock state
					greenled<='1';
					redled<='0';
					if(seconds=10) then
						NextState<=lock;
					end if;
					reset<='0';
					pulse<='0';
			end case;
		end process;
end RTL;
