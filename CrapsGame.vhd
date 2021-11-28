---------------------------------------------------
-- An FPGA version of the Craps Dice Game
-- Author: 	Sean Burke, Brad Jones
-- Student ID: 	B00776071, B00746735
-- File Name: 	CrapsGame.vhd
-- Description: 
-- Acknowledgements:
---------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

-- Largest entity for the Craps Game
entity CrapsGame is
	port (
		roll	:	in     std_logic	:= '0';
		reset   :	in     std_logic	:= '1';
		clk	    :	in     std_logic;				-- Clock source from internal oscillator is 50MHz clock at PIN_AF14
		win	    :	buffer std_logic	:= '0';
		loss	:	buffer std_logic	:= '0'
	);
end CrapsGame;

-- RTL architecture setup of the game
architecture rtl of CrapsGame is
	
	-- Counting component for creating the psuedo-random numbers for rolls
	component Counter
		port (
			clk :	in  std_logic;
			y	:	out std_logic_vector(2 downto 0)
		);
	end component;

	component PointRegister is
		port (
			x               :   in  std_logic_vector(3 downto 0);
			fallingEdge     :	in  std_logic;
			rollReg         :   in  std_logic;
			y	            :	out std_logic_vector(3 downto 0)
		);
	end component;

	component FallingEdgeDetector is
		port (
			x	:	in  std_logic;
			y	:	out std_logic
		);
	end component;

	component Adder
		port (
			a	:	in  std_logic_vector(2 downto 0);
			b   :	in  std_logic_vector(2 downto 0);
			y	:	out std_logic_vector(3 downto 0)
		);
	end component;
	
	component Comparator7
		port (
			a	:	in  std_logic_vector(3 downto 0);
			y	:	out std_logic
		);
	end component;

	component Comparator11
		port (
			a	:	in  std_logic_vector(3 downto 0);
			y	:	out std_logic
		);
	end component;

	component Comparator2312
		port (
			a	:	in  std_logic_vector(3 downto 0);
			y	:	out std_logic
		);
	end component;

	component ComparatorPR is
		port (
			a	:	in  std_logic_vector(3 downto 0);
			b   :	in  std_logic_vector(3 downto 0);
			y	:	out std_logic
		);
	end component;
	
	component DFlipFlop is
		port (
			d		:	in  std_logic	:=	'0';
			clk	    :	in  std_logic	:=	'0';
			reset	:	in  std_logic	:=	'1';
			q		:	out std_logic	:=	'0'
		);
	end component;

	component RollCounter is
		port (
			x  	:	in  std_logic;
			y	:	out std_logic_vector(1 downto 0)
		);
	end component;

	-- Craps Game Signals
	signal	clock		:	std_logic;
	
	-- Frequency Divider signals
	signal	fdout		:	std_logic := '0';
	
	-- Pseudo-random number generator signals
	signal	C0out		:	std_logic_vector(2 downto 0) := "000";
	signal	C1Out		:	std_logic_vector(2 downto 0) := "000";
	
	-- Roll counter (psuedo state register) signals
	signal Dout	    	:	std_logic_vector(1 downto 0) := "00";

	-- Adder Signals
	signal rollValue	:	std_logic_vector(3 downto 0) := "0000";

	-- Comparator Signals (Low is match high is mismatch)
	signal M7       	: 	std_logic := '1';
	signal M11			: 	std_logic := '1';
	signal M2312		: 	std_logic := '1';
	signal MSP      	: 	std_logic := '1';
	
	-- FallingEdgeDetector Signals
	signal fedOut		:	std_logic := '0';

	-- PointRegister Signals
	signal savedPoint	:	std_logic_vector(3 downto 0) := "0000";
	
begin
	clock <= clk and roll and not(win) and not(loss);
	C0		:	Counter   			port map (clock, C1out);				-- Counter component id 0 for creating the psuedo-random number
	FD		:	DFlipFlop 			port map ("not"(fdout), clock, fdout);	-- Frequency divider component between the two number generators
	C1		:	Counter   			port map (fdout, C2out);			    -- Counter component id 1 for creating the psuedo-random number
	A		:	Adder	  			port map (C1out, C2out, rollValue);		-- Adder component for adding the two "random" numbers
	SR      :   RollCounter    		port map (roll, Dout);           		-- State register component
	CMP7    :   Comparator7    		port map (rollValue,   M7);             -- First stage comparators (7/11, 2/3/12)
	CMP11   :   Comparator11   		port map (rollValue,  M11);             -- First stage comparators (7/11, 2/3/12)
	CMP2312 :   Comparator2312 		port map (rollValue,M2312);             -- First stage comparators (7/11, 2/3/12)
	CMPPR   :   ComparatorPR        port map (rollvalue, savedPoint, MSP);									   
	FED		:	FallingEdgeDetector port map (roll, fedOut); 				-- Falling edge detector
	PR		:	PointRegister       port map (rollValue, fedOut, "not"(Dout(1)), savedPoint); -- Point Register
	-- Win/Loss logic
	loss <= (not(M2312) and not(Dout(1))) or (Dout(1) and M7);
	win  <= (not(MSP) and Dout(1)) or (not(Dout(1)) and (M7 nand M11));
end rtl;