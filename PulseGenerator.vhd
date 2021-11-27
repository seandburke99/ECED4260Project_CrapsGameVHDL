---------------------------------------------------
-- An FPGA version of the Craps Dice Game
-- Author: 	Sean Burke
-- Student ID: 	B00776071
-- File Name: 	PulseGenerator.vhd
-- Description: 
-- Acknowledgements:
---------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity PulseGenerator is
	port (
		x	:	in std_logic	:= '0';
		y	:	out std_logic	:=	'0'
	);
end PulseGenerator;

architecture gate of PulseGenerator is
	signal	internal	:	std_logic_vector(2 downto 0) := "101";
begin
	internal(0) <= x nand internal(2);
	internal(1) <= internal(0) nand internal(0);
	internal(2) <= internal(1) nand internal(1);
	y <= internal(1);
end gate;