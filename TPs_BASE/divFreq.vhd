library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;



entity divFreq is 
port(
		H_IN	: in std_logic;
		H_OUT	: out std_logic

	);
end divFreq;

architecture arch of divFreq is 

signal  cpt_value :  unsigned (24 downto 0) := (others => '0');
constant div_value : unsigned (24 downto 0) := "0000000000000000000000001";

signal etat : STD_LOGIC := '0';

begin
		process (H_IN)
		begin
			if rising_edge (H_IN) then
		cpt_value <= cpt_value + 1;
		if cpt_value = div_value;
	then
		etat <= not etat;
		cpt_value <= (others => '0');
		
		end if;
	end if;
	end process;
	H_OUT <= etat;
end arch;



 
begin 
				
process(H)
	begin	
	if(H'event and H='1') then
		
		end if;

end process;
		
end arch; 