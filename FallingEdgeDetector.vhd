---------------------------------------------------
-- An FPGA version of the Craps Dice Game
-- Author: 	Sean Burke
-- Student ID: 	B00776071
-- File Name: 	FallingEdgeDetector.vhd
-- Description: 
-- Acknowledgements:
---------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity FallingEdgeDetector is
	port (
		x	:	in std_logic;
		y	:	out std_logic
	);
end FallingEdgeDetector;

architecture gate of FallingEdgeDetector is
	signal inter :	std_logic_vector(4 downto 0);
begin
	
	inter(0) <= x nand x;
	inter(1) <= inter(0) nand inter(0);
	inter(2) <= inter(1) nand inter(1);
	inter(3) <= inter(2) nand inter(2);
	inter(4) <= inter(3) nand inter(3);
	y <= inter(4) nand inter(4);
end gate;