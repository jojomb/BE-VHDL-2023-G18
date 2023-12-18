library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;



entity compteur2bcd is 
port(
		H	: in std_logic;
		C	: in std_logic;
		reset : in std_logic;
		S	: out std_logic_vector(3 downto 0)
	);
end compteur2bcd;

architecture arch of compteur2bcd is 

signal  cpt_value :  std_logic_vector(3 downto 0) ; 
begin 
				
process(H,C)
	begin	
	--if C='1' then 
	if  reset = '1' then cpt_value <=(others => '0');

	elsif(H'event and H='1' and C='1') then
		if cpt_value="0000" then 
					cpt_value <= "1111";
			else
			cpt_value <= cpt_value - 1;
			end if;
		--end if ;
-- else
		elsif(H'event and H='1' and C='0') then 
			if cpt_value = "1111" then 
						cpt_value <= "0000";
			else
				cpt_value <= cpt_value + 1;
			end if;
			
		end if;

end process;

S <= cpt_value;
				
end arch; 