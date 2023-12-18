--Diviseur de fr?quence
LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;


entity Diviseur1HZ is
    Port ( clk_50M : in STD_LOGIC;
           raz_n : in STD_LOGIC;
           clk_1Hz : inout STD_LOGIC
           );
end Diviseur1HZ;

architecture Behavioral of Diviseur1HZ is
begin
process (clk_50M, raz_n)
	 	 variable count : integer range 0 to 49999999 ; -- Compteur pour diviser le signal

    begin
        if raz_n = '0' then
            count := 0; -- Réinitialisation du compteur lorsque raz_n est actif
				clk_1Hz <= '0';
        else if (clk_50M'event and clk_50M='1') then
		    count := count + 1;
            if count = 49999999 then
                count := 0;
                clk_1Hz <= not clk_1Hz; -- Inversion de la sortie pour générer une fréquence de 1Hz
            else
                count := count ;
					
            end if;
        end if;
		 end if;

    end process;
end Behavioral;

