library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;



entity compteur1bcd is 
port(
		H	: in std_logic;
		S	: out std_logic_vector(3 downto 0)
	);
end compteur1bcd;

architecture arch of compteur1bcd is 

signal  cpt_value :  std_logic_vector(3 downto 0) ; 
begin 
				
process(H)
	begin	
	if(H'event and H='1') then
			cpt_value <= "0000";	
				cpt_value <= cpt_value+1;
		end if;

end process;

S <= cpt_value;
				
end arch; 