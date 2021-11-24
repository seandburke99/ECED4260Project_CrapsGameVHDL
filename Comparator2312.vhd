---------------------------------------------------
-- An FPGA version of the Craps Dice Game
-- Author: 	Brad Jones
-- Student ID: 	B00746735
-- File Name: 	Comparator2312.vhd
-- Description: 
-- Acknowledgements:
---------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity Comparator2312 is
	port (
		a	:	in std_logic_vector(3 downto 0);
		y	:	out std_logic
	);
end Comparator2312;

architecture rtl of Comparator2312 is
begin
--y is low on a match high on a mismatch for now
	y <=  ((a(0) xor 0) or (a(1) xor 1) or (a(2) xor 0) or (a(3) xor 0))
	  and ((a(0) xor 1) or (a(1) xor 1) or (a(2) xor 0) or (a(3) xor 0))
	  and ((a(0) xor 0) or (a(1) xor 0) or (a(2) xor 1) or (a(3) xor 1));
		
end rtl;