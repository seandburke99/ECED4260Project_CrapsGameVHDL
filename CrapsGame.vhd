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
begin
end rtl;