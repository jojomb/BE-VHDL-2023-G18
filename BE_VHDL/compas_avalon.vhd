-- Copyright (C) 2018  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel FPGA IP License Agreement, or other applicable license
-- agreement, including, without limitation, that your use is for
-- the sole purpose of programming logic devices manufactured by
-- Intel and sold by Intel or its authorized distributors.  Please
-- refer to the applicable agreement for further details.

-- PROGRAM		"Quartus Prime"
-- VERSION		"Version 18.1.0 Build 625 09/12/2018 SJ Lite Edition"
-- CREATED		"Thu Dec 14 22:46:54 2023"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;

-- LIBRARY work;

ENTITY compas_avalon IS 
	PORT
	(
		clk, chipselect, write_n, reset_n : in std_logic;
		in_compas : in std_logic;
		writedata : in std_logic_vector (31 downto 0);
		readdata : out std_logic_vector (31 downto 0);
		address: std_logic_vector (1 downto 0)
	);
END entity;



ARCHITECTURE arch_avalon_compas OF compas_avalon IS 

COMPONENT gestion_compas
	PORT(in_pwm_compas : IN STD_LOGIC;
		 clk_50M : IN STD_LOGIC;
		 raz_n : IN STD_LOGIC;
		 continu : IN STD_LOGIC;
		 start_stop : IN STD_LOGIC;
		 data_valid : OUT STD_LOGIC;
		 data_compas : OUT STD_LOGIC_VECTOR(8 DOWNTO 0)
	);
END COMPONENT;

signal start_stop, continu, in_pwm_compas,raz_n, data_valid : std_logic;
signal data_compas : std_logic_vector (8 downto 0);



BEGIN 

--écriture registres

process_write : process (clk,reset_n)
begin
if reset_n = '0' then
	raz_n <= '0';
	continu <= '0';
	start_stop <= '0';
	elsif clk'event and clk = '1' then 
	if chipselect = '1' and write_n = '0' then
		if address = "00" then
			raz_n <= writedata(0);
			continu <= writedata(1);
			start_stop <= writedata(2);
		end if;
	end if;
end if;
end process;

-- lecture registres

process_Read : process(address, start_stop, continu, raz_n, data_compas, data_valid)
begin
case address is 
when "00" => readdata <= X"0000000"&"0"&start_stop&continu&raz_n;
when "10" => readdata <= X"00000"&"00"&data_valid&data_compas;
when others => readdata <= (others => '0');
end case;

end process process_Read;



		 
C1 : gestion_compas port map(in_pwm_compas,clk, raz_n, continu, start_stop, data_valid, data_compas);


END arch_avalon_compas;