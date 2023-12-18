

Library ieee;
use ieee.std_logic_1164.all;

ENTITY ADD IS

	PORT(
			a,b,c1			: IN  STD_LOGIC;
			s,c0			: OUT	STD_LOGIC);
END ADD;
	
	
ARCHITECTURE ARCH_ADD	of ADD is 
BEGIN
	S	<= (a XOR b) XOR c1;
	C0  <= (a AND b) OR ((a XOR b) AND c1);
	
	END arch_ADD;