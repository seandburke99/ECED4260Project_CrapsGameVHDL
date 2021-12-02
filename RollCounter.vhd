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
		x   :	in     std_logic;
		rst :   in     std_logic;
		y	:	buffer std_logic_vector(1 downto 0):="00"
	);
end RollCounter;

architecture rtl of RollCounter is
	component DFlipFlop is
		port (
			d		:	in     std_logic;
			clk	    :	in     std_logic;
			reset	:	in     std_logic;
			q		:	buffer std_logic;
			qbar	:	out    std_logic
		);
	end component;
	signal throw        :   std_logic_vector(1 downto 0) := "00";
	signal q            :   std_logic := '0';
	signal del			:	std_logic_vector(3 downto 0) := "0000";
begin
	--x should be the roll input
	U2	:	DFlipFlop port map (q,    x, rst, y(1), throw(1));
	U1	:	DFlipFlop port map ('1',   x, rst, y(0), throw(0));
	q <= y(0);
	
end rtl;