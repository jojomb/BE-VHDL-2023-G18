
	library ieee;
Use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity PWM_TP is
port(
	-- entree
	clk_50M : in std_logic;
	reset_n : in std_logic;
	FREQ 	: in std_logic_vector (7 downto 0);
	DUTY	: in std_logic_vector (7 downto 0);
	-- sortie
	pwm_out : out std_logic
	);
end PWM_TP;

architecture arch of PWM_TP is

-- compteur 8 bits
signal compteur 	: std_logic_vector (7 downto 0):= "00000000";
signal freq_compare : std_logic := '0';
signal duty_compare : std_logic := '0';


begin
	process (clk_50M,reset_n)
	begin
			-- initialisation
			if reset_n = '0' then compteur <= "00000000";
				freq_compare <= '0';
				duty_compare <= '0';
			-- réinitialisation du compteur en cas de reset
				elsif rising_edge (clk_50M) then
					if  freq_compare = '1' then
					compteur <= (others => '0');
					elsif compteur = FREQ then
					freq_compare <= '1';
			-- reinitialisation du compteur à freq atteinte
					else 
					freq_compare <= '0';
					compteur <= compteur + 1;
			-- incrémentation du compteur
				end if;
				
				if compteur < DUTY then
					duty_compare <= '1';
					else
					duty_compare <= '0';
			end if;
			
			pwm_out <= duty_compare;
			end if;
	end process;

end arch;