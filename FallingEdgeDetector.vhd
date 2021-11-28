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
		x	:	in std_logic	:= '0';
		y	:	out std_logic	:= '0'
	);
end FallingEdgeDetector;

architecture gate of FallingEdgeDetector is
	signal reg	:	std_logic_vector(1 downto 0) := "00";
begin
	process(x)
	begin
		if falling_edge(x) then
			reg(0) <= '1';
			reg(1) <= reg(0);
		elsif rising_edge(x) then
			reg(0) <= '0';
			reg(1) <= '0';
		end if;
	end process;
	y <= reg(0) and not(reg(1));
end gate;