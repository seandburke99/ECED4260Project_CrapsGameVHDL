---------------------------------------------------
-- An FPGA version of the Craps Dice Game
-- Author: 	Brad Jones
-- Student ID: 	B00746735
-- File Name: 	PointRegister.vhd
-- Description: 
-- Acknowledgements:
---------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity PointRegister is
	port (
		x       :       in  std_logic_vector(3 downto 0);
		clk     :	in  std_logic;
		y	:	out std_logic_vector(3 downto 0)
-- We could change the clk input to 2 inputs (Falling edge and state reg[1]) and implement that in this file to simplify the full system file and kind of have the point reg contained all in one
-- I think we should but going to check this with sean first
	);
end PointRegister;

architecture rtl of PointRegister is
	component DFlipFlop
	port (
		d		:	in  std_logic;
		clk		:	in  std_logic;
		reset		:	in  std_logic;
		q		:	out std_logic
	);
	end component;
begin
	U1	:	DFlipFlop port map (x(0), clk, '1', y(0));
	U2	:	DFlipFlop port map (x(1), clk, '1', y(1));
	U3	:	DFlipFlop port map (x(2), clk, '1', y(2));
	U4	:	DFlipFlop port map (x(3), clk, '1', y(3));

end rtl;