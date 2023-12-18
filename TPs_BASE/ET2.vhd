
Library ieee;
use ieee.std_logic_1164.all;

ENTITY ET2 IS

	PORT(
			a,b			: IN  STD_LOGIC;
			s			: OUT	STD_LOGIC);
END ET2;
	
	
ARCHITECTURE ARCH_ET2	of ET2 is 
BEGIN
	S	<= a AND b;
	
	END arch_ET2;