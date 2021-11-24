---------------------------------------------------
-- An FPGA version of the Craps Dice Game
-- Author: 	Brad Jones
-- Student ID: 	B00746735
-- File Name: 	RollCounter.vhd
-- Description: 
-- Acknowledgements:
---------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity RollCounter is
	port (
		x  :	in  std_logic;
		y	:	out std_logic_vector(1 downto 0)
	);
end RollCounter;

architecture rtl of RollCounter is
	component DFlipFlop
	port (
		d		:	in  std_logic;
		clk	:	in  std_logic;
		reset	:	in  std_logic;
		q		:	out std_logic
	);
	end component;
	signal internalD	:	std_logic_vector(1 downto 0) := "00";
begin
--x should be the roll input
	U1	:	DFlipFlop port map (x,            x, '1', internalD(0));
	U2	:	DFlipFlop port map (internalD(0), x, '1', internalD(1));
	
end rtl;