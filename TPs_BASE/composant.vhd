library ieee;
Use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;


entity composant is
	port(
			-- entree
			clk_50M		: in std_logic;
			reset 		: in std_logic;
			--C     		: in std_logic;
			-- sortie
			S_u : out std_logic_vector (6 downto 0)
			--S_d : out std_logic_vector (6 downto 0)
			);
			
end composant;

architecture arch of composant is

signal clk0_prim,clk1_prim : std_logic;
signal b_prim : std_logic_vector(3 downto 0);

component DivFreq
	port(
		-- entree
		clk_50M		: in std_logic;
		reset 		: in std_logic;
		-- sortie
		clk_1		: out std_logic
		);
end component;

component compteur1bcd 
	port ( 
			H	: in std_logic;
			--C	: in std_logic;
			--reset : in std_logic;
			S	: out std_logic_vector(3 downto 0)
	   	   );
end component;

component deco7seg 
	port ( 	E 	: in std_logic_vector(3 downto 0);
			seg_u : out std_logic_vector(6 downto 0)	
		);

end component;

begin
DivFreq0: DivFreq
port map (clk_50M => clk_50M,
		reset => reset, clk_1=>clk0_prim);

compteur1bcd0:compteur1bcd
Port map (H=>clk0_prim,
			S=> b_prim);
		--(H=>clk0_prim, C=>C, Q=> b_prim);

deco7seg0:deco7seg
Port map (E=>b_prim, 
		  seg_u=>seg_u
		  );
			--b=>b_prim, S_u=>S_u, S_d=> S_d);
			
S_u<=seg_u ;

end arch;