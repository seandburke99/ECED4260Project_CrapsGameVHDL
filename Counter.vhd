---------------------------------------------------
-- An FPGA version of the Craps Dice Game
-- Author: 	Sean Burke
-- Student ID: 	B00776071
-- File Name: 	Counter.vhd
-- Description: 
-- Acknowledgements:
---------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity Counter is
	port (
		clk :	in std_logic	:= '0';
		y	:	out std_logic_vector(2 downto 0)	:= "000"
	);
end Counter;

architecture rtl of Counter is
	component DFlipFlop
	port (
		d	:	in std_logic;
		clk	:	in std_logic;
		reset	:	in std_logic;
		q	:	out std_logic
	);
	end component;
	signal internalD	:	std_logic_vector(2 downto 0) := "000";
begin
	U1	:	DFlipFlop port map ("not"(internalD(2)), clk, '1', internalD(0));
	U2	:	DFlipFlop port map ("not"(internalD(0)), clk, '1', internalD(1));
	U3	:	DFlipFlop port map ("not"(internalD(1)), clk, '1', internalD(2));
end rtl;