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
		y	:	buffer std_logic_vector(2 downto 0)	:= "000"
	);
end Counter;

architecture rtl of Counter is
	component DFlipFlop
	port (
		d	:	in std_logic;
		clk	:	in std_logic;
		reset	:	in std_logic;
		q	:	buffer std_logic;
		qbar: out std_logic
	);
	end component;
	
	component Mux_2
		port (	
			Input  	: in std_logic_vector(1 downto 0);
			Sel	: in std_logic;
			Output  : out std_logic
		);
	end component;
	
	signal ynot		:	std_logic_vector(2 downto 0) := "000";
	signal muxIn		:	std_logic_vector(1 downto 0) := "00";
	signal selector	:	std_logic := '0';
	signal muxOut		: 	std_logic := '0';
begin
	U1	:	DFlipFlop port map (muxOut, clk, '1', y(0), ynot(0));
	U2	:	DFlipFlop port map (ynot(0), clk, '1', y(2), ynot(1));
	U3	:	DFlipFlop port map (ynot(1), clk, '1', y(1), ynot(2));
	muxIn(0) <= ynot(2);
	muxIn(1) <= '0';
	selector <= not(y(0) or y(1) or y(2));
	SMUX	:	Mux_2	port map	(muxIn, selector, muxOut);
end rtl;