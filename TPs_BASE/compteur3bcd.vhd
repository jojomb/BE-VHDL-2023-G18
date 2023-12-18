library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity compteur3bcd is
port ( H : in std_logic;
	   C 	: in std_logic;
	   reset : in std_logic;
	   load : in std_logic;
	   data : in std_logic_vector (3 downto 0);
	   Q 	: out std_logic_vector(3 downto 0)
	   	   );
end compteur3bcd;
	  
architecture arch OF compteur3bcd is
signal  iq, id: std_logic_vector(3 downto 0); 


begin 
--- bloc de mémoire	
	process(H,reset)
		begin
		--if C='1' then
			if reset='1' then iq <=(others => '0');
			elsif H'event and H ='1' then 
			iq <= id;
			end if;
	end process; 
	
-- Description du bloc combinatoire
	id <=  (others =>'0') when reset ='1' else 
					data when load ='1' and data <= "1001" else
					iq	when load = '1' and data < "1001" else
					iq+1 when C='0' and iq< "1001" else
					(others =>'0') when C='0' and iq>= "1001" else
					iq-1		when C='1' and iq/="0000" else
					"1001"		when C='1' and iq = "0000" else
					iq;
						
	Q <= iq;
end arch;