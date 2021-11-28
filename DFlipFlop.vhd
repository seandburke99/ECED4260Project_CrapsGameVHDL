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
		q		:	buffer std_logic	:=	'0';
		qbar	:	out std_logic	:= '1'
	);
end DFlipFlop;

architecture gate of DFlipFlop is
begin
	cycle: process(clk, reset)
	begin
		if(reset='0') then
			q <= '0';
		elsif(rising_edge(clk)) then
			q <= d;
		end if;
	end process;
	qbar <= not(q);
end gate;