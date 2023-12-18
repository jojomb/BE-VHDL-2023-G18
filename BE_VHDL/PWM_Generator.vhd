library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity PWM_Generator is
    Port ( clk : in STD_LOGIC;
           pwm_out : out STD_LOGIC);
end PWM_Generator;

architecture Behavioral of PWM_Generator is
    signal counter : unsigned(15 downto 0) := (others => '0');
    signal pwm_period : integer := 50000;  -- 1 ms at 50 MHz
    
    constant duty_cycle_percent : integer := 15;
    signal duty_cycle : integer;
    
begin
    process(clk)
    begin
        if rising_edge(clk) then
            counter <= counter + 1;
            
            -- Calculate duty cycle based on the specified percentage
            duty_cycle <= (duty_cycle_percent * pwm_period) / 100;
            
            if counter < duty_cycle then
                pwm_out <= '1';
            else
                pwm_out <= '0';
            end if;
            
            if counter = pwm_period - 1 then
                counter <= (others => '0');
            end if;
        end if;
    end process;
end Behavioral;
