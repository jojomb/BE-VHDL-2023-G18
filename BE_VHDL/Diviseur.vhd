--Diviseur de fr?quence
LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;


entity Diviseur is
    Port ( clk_50M : in STD_LOGIC;
           raz_n : in STD_LOGIC;
           clk_10K : inout STD_LOGIC
           );
end Diviseur;

architecture Behavioral of Diviseur is
    
begin
    process (clk_50M, raz_n)
	 	 variable count : integer range 0 to 4999 ; -- Compteur pour diviser le signal

    begin
        if raz_n = '0' then
            count := 0; -- Réinitialisation du compteur lorsque raz_n est actif
				clk_10K <= '0';
        else if (clk_50M'event and clk_50M='1') then
		    count := count + 1;
            if count = 4999 then
                count := 0;
                clk_10K <= not clk_10K; -- Inversion de la sortie pour générer une fréquence de 10 KHz
            else
                count := count ;
					-- clk_10K <= '1';
            end if;
        end if;
		 end if;

    end process;
end Behavioral;




