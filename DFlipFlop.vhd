---------------------------------------------------
-- An FPGA version of the Craps Dice Game
-- Author: 	Sean Burke
-- Student ID: 	B00776071
-- File Name: 	DFlipFlop.vhd
-- Description: 
-- Acknowledgements:
---------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity DFlipFlop is
	port (
		d		:	in std_logic	:=	'0';
		clk	:	in std_logic	:=	'0';
		reset	:	in std_logic	:=	'1';
		q		:	out std_logic	:=	'0'
	);
end DFlipFlop;

architecture gate of DFlipFlop is
	signal	gq	:	std_logic_vector(5 downto 0) := "000000";
begin
	gq(0) <= gq(3) nand gq(1);
	gq(1) <= not(gq(0) nand clk) nand reset;
	gq(2) <= not(gq(1) nand clk) nand gq(3);
	gq(3) <= not(gq(2) nand d) nand reset;
	gq(4) <= gq(1) nand gq(5);
	gq(5) <= not(gq(2) nand gq(4)) nand reset;
end gate;