library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity PilotStateMachine is
    Port ( clk_50M : in STD_LOGIC;
	        pwm_1Khz : in STD_LOGIC;
	        clk_1 : in STD_LOGIC;
	       
           raz_n : in STD_LOGIC;
           BP_Babord, BP_Tribord, BP_STBY : in STD_LOGIC;
           codeFonction : out STD_LOGIC_VECTOR(3 downto 0);
           ledBabord, ledTribord, ledSTBY, out_bip : out STD_LOGIC
         );
end PilotStateMachine;

architecture Behavioral of PilotStateMachine is
    type state_type is (Veille, ManuelBabord, ManuelTribord, PiloteAutomatique, Adjust1Incr, Adjust1Decr, Adjust10Incr, Adjust10Decr);
    signal current_state, next_state : state_type;
    signal time_counter  : integer := 350000000;  -- Valeur de consigne de cap en degrés

begin

    process(clk_50M, raz_n)
    begin
        if raz_n = '0' then
               -- étas des sorties 
				out_bip <= '0';
				codeFonction <= "0000" ;
				ledBabord <= '0';
				ledTribord <= '0';
				ledSTBY<= '0';
            
        elsif rising_edge(clk_50M) then
            current_state <= next_state;  -- Met à jour l'état actuel avec l'état suivant
        end if;
    end process;

    process(current_state, BP_Babord, BP_Tribord, BP_STBY)
	 variable counter : integer range 0 to 350000000 ; -- Compteur pour la duré de l'appui
    begin
	 
        -- Logique de transition d'état basée sur les entrées BP_Babord, BP_Tribord, et BP_STBY
        case current_state is
            when Veille =>
				
				ledSTBY <= clk_1;--clignoter la Led 
				ledBabord <= pwm_1Khz;--allumage faible
				ledTribord <= pwm_1Khz;--allumage faible
                if BP_Babord = '0' then

                    next_state <= ManuelBabord;	-- changement d'état  				                    
                elsif BP_Tribord = '0' then					   
                    next_state <= ManuelTribord;  -- changement d'état                 
                elsif BP_STBY = '0' then
					  wait until BP_STBY = '1';

                    next_state <= PiloteAutomatique;-- changement d'état  
                else
                    next_state <= Veille;
                end if;

            when ManuelBabord =>
				 out_bip <= '1';-- faire fonctioner le sonneur 

            when ManuelTribord =>
				out_bip <= '1';-- faire fonctioner le sonneur

            when PiloteAutomatique =>
				------------------------------------------------
				
				ledTribord <= pwm_1Khz;--allumage faible 
				ledBabord <= pwm_1Khz;--allumage faible
              ledSTBY <= '1';  -- Logique de transition d'état pour le mode pilote automatique*
				
		
               if BP_Babord = '0' then
					
					 while BP_Babord = '0' and counter < 150000000 loop -- compter la duré de l'appui

                  counter := counter + 1;
                 
                 end loop;
	 -----------
					
					 if counter>150000000 then --appui plus que 3 secondes

					      counter := 0;
                     next_state <=Adjust10Incr;
						else  --appui moins de 3 secondes
						   next_state <=Adjust1Incr;
							counter := 0;
						
                   end if;
                elsif BP_Tribord = '0' then
					   while BP_Tribord = '0' loop
                 -- Incrémentation du compteur
                   counter:= counter + 1;
                

                -- Sortir de la boucle si une certaine condition est satisfaite
                   if BP_Tribord='1' then
                       exit;
                   end if;
                 end loop; 
					 if counter>150000000 then --appui plus que 3 seconds

                     next_state <=Adjust10Decr;
							counter := 0;
						else --appui moins de 3 secondes
						   next_state <=Adjust1Decr;						
							counter := 0;                  
                 end if ;  
                elsif BP_STBY = '0' then
					  wait until BP_STBY = '1';
                    next_state <= PiloteAutomatique;
                else
                    next_state <= Veille;
                end if;						
 -----------------           
            when Adjust1Incr =>
				ledBabord <= '1';
				wait for  1000 ms;
				ledBabord <= '0';			
				---réglage du sonneur
				out_bip <= '1';
				wait for  1000 ms;
				out_bip <= '0';				              
---------------
            when Adjust1Decr =>				
				ledTribord <= '1';
				wait for  1000 ms;
				ledTribord <= '0';				
				---réglage du sonneur
				out_bip <= '1';
				wait for  1000 ms;
				out_bip <= '0';							
            when Adjust10Incr =>
				ledBabord <= '1'; --clignoter la LED 2 fois
				wait for  1000 ms;
				ledBabord <= '0';
				wait for  500 ms;
				ledBabord <= '1';
				wait for  1000 ms;
				ledBabord <= '0';							
				  out_bip <= '1';-----réglage du sonneur
				  wait for  500 ms;
				  out_bip <= '0';
				  wait for  500 ms;
				  out_bip <= '1';
				  wait for  500 ms;
              out_bip <= '0';              
            when Adjust10Decr =>
				ledTribord <= '1';--clignoter la LED 2 fois
				wait for  1000 ms;
				ledTribord <= '0';
				wait for  500 ms;
				ledTribord <= '1';
				wait for  1000 ms;
				ledTribord <= '0';				
				out_bip <= '1';---réglage du sonneur 
				wait for  500 ms;
				out_bip <= '0';
				wait for  500 ms;
				out_bip <= '1';
				wait for  500 ms;
            out_bip <= '0';
 ------------               
            when others =>
                next_state <= Veille;
        end case;
    end process;
    -- Logique de sortie basée sur l'état actuel
    with current_state select
        codeFonction <= "0000" when Veille, -- état de la sortie codeFonction pour le mode Veille
                        "0001" when ManuelBabord,
                        "0010" when ManuelTribord,
                        "0011" when PiloteAutomatique, -- état de la sortie codeFonction pour le mode PiloteAutomatique
                        "0100" when Adjust1Incr,
                        "0101" when Adjust10Incr,
                        "0111" when Adjust1Decr,
                        "0110" when Adjust10Decr,-- D
                        "0000" when others;   
end Behavioral;
