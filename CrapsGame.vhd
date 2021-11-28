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

-- Largest entity for the Craps Game
entity CrapsGame is
	port (
		roll	:	in std_logic	:= '0';
		reset :	in std_logic	:= '1';
		clk	:	in std_logic;				-- Clock source from internal oscillator is 50MHz clock at PIN_AF14
		win	:	out std_logic	:= '0';
		loss	:	out std_logic	:= '0'
	);
end CrapsGame;

-- RTL architecture setup of the game
architecture rtl of CrapsGame is

	-- Pulse Generator component for creating a system clock from a signal
	component PulseGenerator
		port (
			x	:	in std_logic;
			y	:	out std_logic
		);
	end component;
	
	-- Counting component for creating the psuedo-random numbers for rolls
	component Counter
		port (
			clk :	in std_logic;
			y	:	out std_logic_vector(2 downto 0)
		);
	end component;
	
	component Comparator7
		port (
			a	:	in std_logic_vector(3 downto 0);
			y	:	out std_logic
		);
	end component;

	component Comparator11
		port (
			a	:	in std_logic_vector(3 downto 0);
			y	:	out std_logic
		);
	end component;

	component Comparator2312
		port (
			a	:	in std_logic_vector(3 downto 0);
			y	:	out std_logic
		);
	end component;

	component ComparatorPR is
		port (
			a	:	in std_logic_vector(3 downto 0);
			b :	in std_logic_vector(3 downto 0);
			y	:	out std_logic
		);
	end component;
	
	-- Craps Game Signals
	signal	clock	:	std_logic;
	
	-- Pseudo-random number generator signals
	signal	C0out	:	std_logic_vector(2 downto 0) := "000";
	signal	C1Out	:	std_logic_vector(2 downto 0) := "000";
	
	-- Roll counter (psuedo state register) signals
	signal Dout	:	std_logic_vector(1 downto 0)	:= "00";
	
begin
	C0		:	Counter port map (clk, C1out);			-- Counter component id 0 for creating the psuedo-random number
	C1		:	Counter port map (clk, C2out);			-- Counter component id 1 for creating the psuedo-random number
	-- Adder component
	-- State register component
	-- First stage comparators (7/11, 2/3/12)
	-- Point register component
	-- Point register comparator component
	-- Win/Loss logic
end rtl;