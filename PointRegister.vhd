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
		x               : in  std_logic_vector(3 downto 0);
		fallingEdge     :	in  std_logic;
		rollReg         : in  std_logic;
		y	:	out std_logic_vector(3 downto 0)
	);
end PointRegister;

architecture rtl of PointRegister is
	component DFlipFlop
	port (
		d		:	in  std_logic;
		clk		:	in  std_logic;
		reset	:	in  std_logic;
		q		:	out std_logic
	);
	end component;
	signal internal : std_logic:='0';
begin
	internal <= fallingEdge and not(rollReg);
	U1	:	DFlipFlop port map (x(0), internal, '1', y(0));
	U2	:	DFlipFlop port map (x(1), internal, '1', y(1));
	U3	:	DFlipFlop port map (x(2), internal, '1', y(2));
	U4	:	DFlipFlop port map (x(3), internal, '1', y(3));

end rtl;