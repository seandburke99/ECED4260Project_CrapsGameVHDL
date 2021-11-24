---------------------------------------------------
-- An FPGA version of the Craps Dice Game
-- Author: 	Brad Jones
-- Student ID: 	B00746735
-- File Name: 	ComparatorPR.vhd
-- Description: 
-- Acknowledgements:
---------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity ComparatorPR is
	port (
		a	:	in std_logic_vector(3 downto 0);
		b :	in std_logic_vector(3 downto 0);
		y	:	out std_logic
	);
end ComparatorPR;

architecture rtl of ComparatorPR is
begin
--y is low on a match high on a mismatch for now
	y <= (a(0) xor b(0)) or (a(1) xor b(1)) or (a(2) xor b(2)) or (a(3) xor b(3));

end rtl;