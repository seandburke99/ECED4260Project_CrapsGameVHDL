---------------------------------------------------
-- An FPGA version of the Craps Dice Game
-- Author: 	Sean Burke, Brad Jones
-- Student ID: 	B00776071, B00
-- File Name: 	CrapsGame.vhd
-- Description: 
-- Acknowledgements:
---------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity CrapsGame is
	port (
		roll	:	in std_logic;
		reset :	in std_logic;
		win	:	out std_logic;
		loss	:	out std_logic
	);
end CrapsGame;

architecture rtl of CrapsGame is
	component Counter
		port (
			clk :	in std_logic;
			y	:	out std_logic_vector(2 downto 0)
		);
	end component;
	signal	cout	:	std_logic_vector(2 downto 0);
begin
	U1	:	Counter port map (roll, cout(2 downto 0));
end rtl;