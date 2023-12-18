library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.numeric_std.ALL;


entity Data_Acquisition is
    Port ( clk : in STD_LOGIC; -- Horloge 1 Hz
           continu : in STD_LOGIC; -- Mode Continu (1) ou Monocoup (0)
           start_stop : in STD_LOGIC; -- Démarre une acquisition (1) ou remet à 0 data_valid (0)
           resultat : in STD_LOGIC_VECTOR(8 downto 0); -- Valeur de degré en binaire sur 9 bits
           data_valid : out STD_LOGIC; -- Indicateur de mesure valide
           data_compas : out STD_LOGIC_VECTOR(8 downto 0); -- Résultat de l'acquisition
			  raz_n : in STD_LOGIC
          );
end Data_Acquisition;

architecture Behavioral of Data_Acquisition is
    signal data_compas_internal : STD_LOGIC_VECTOR(8 downto 0);
    signal data_valid_internal : STD_LOGIC := '0';

begin
    process (clk,start_stop,raz_n)
    begin
	 
		  if(raz_n='0') then 
		  data_valid_internal <= '0';
		  data_compas_internal <= "000000000";
		  
        else
		  
		     if (clk'event and clk='1')  then
            if continu = '1' then
                data_compas_internal <= resultat;
           -- else
             --   if start_stop = '1' then
              --      data_compas_internal <= resultat;
						--  data_valid_internal <= '1';--
                else
                   data_compas_internal <= "000000000";
						 -- data_valid_internal <= '0';--
              --  end if;
            end if;
				
			 end if; 
		if (start_stop = '1' and raz_n='1') then
               data_valid_internal <= '1';
					data_compas_internal <= resultat;
           else 
               data_valid_internal <= '0';
		--	     data_compas_internal <= "111111111";

           --end if;
        end if;
		end if;
            
         
    end process;
    
     data_valid <= data_valid_internal;
     data_compas <= data_compas_internal;
end Behavioral;
