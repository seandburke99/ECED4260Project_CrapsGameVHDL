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
		loss	:	buffer std_logic	:= '0';
		disp0	:	out std_logic_vector(6 downto 0);
		disp1	:	out std_logic_vector(6 downto 0);
		rc		:	out std_logic_vector(1 downto 0);
		dpr		:	out std_logic_vector(3 downto 0)
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
			x               : in  std_logic_vector(3 downto 0);
			rollReg         : in  std_logic;
			reset			: in	std_logic := '1';
			y	:	out std_logic_vector(3 downto 0) := "0000"
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
			d		:	in std_logic;
			clk	:	in std_logic;
			reset	:	in std_logic;
			q		:	buffer std_logic;
			qbar	:	out std_logic
		);
	end component;

	component RollCounter is
		port (
			x   :	in     std_logic;
			rst :   in     std_logic;
			y	:	buffer std_logic_vector(1 downto 0):="00"
		);
	end component;

	component sevenSegEncoder
		port (
			x   :   in  std_logic_vector(2 downto 0);
			y	:	out std_logic_vector(6 downto 0)
		);
	end component;

	-- Craps Game Signals
	signal	clock		:	std_logic;
	signal	iRoll		:	std_logic;
	
	-- Frequency Divider signals
	signal	fdout		:	std_logic := '0';
	signal	fdin		:	std_logic := '1';
	
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

	-- PointRegister Signals
	signal savedPoint	:	std_logic_vector(3 downto 0) := "0000";

	-- Internal Win/Loss signals
	signal iLoss		:	std_logic := '0';
	signal iWin			:	std_logic := '0';
	signal throw		:	std_logic_vector(1 downto 0) := "00";
	
begin
	iRoll <= not(roll);
	clock <= clk and not(roll) and not(win) and not(loss);
	C0		:	Counter   			port map (clock, C0out);				-- Counter component id 0 for creating the psuedo-random number
	FD		:	DFlipFlop 			port map (fdin, clock, '1', fdout, fdin);	-- Frequency divider component between the two number generators
	C1		:	Counter   			port map (fdout, C1out);			    -- Counter component id 1 for creating the psuedo-random number
	S0		:	sevenSegEncoder		port map (C0out, disp0);
	S1		:	sevenSegEncoder		port map (C1out, disp1);
	A		:	Adder	  			port map (C0out, C1out, rollValue);		-- Adder component for adding the two "random" numbers
	SR      :   RollCounter    		port map (iRoll, reset, Dout);           		-- State register component
	rc <= Dout;
	CMP7    :   Comparator7    		port map (rollValue,   M7);             -- First stage comparators (7/11, 2/3/12)
	CMP11   :   Comparator11   		port map (rollValue,  M11);             -- First stage comparators (7/11, 2/3/12)
	CMP2312 :   Comparator2312 		port map (rollValue,M2312);             -- First stage comparators (7/11, 2/3/12)
	CMPPR   :   ComparatorPR        port map (rollvalue, savedPoint, MSP);
	PR		:	PointRegister       port map (rollValue, Dout(1), reset, savedPoint); -- Point Register
	dpr <= savedPoint;
	-- Win/Loss logic
	iLoss <= ((not(M2312) and not(Dout(1))) or (Dout(1) and not(M7))) and roll and not(win);
	iWin  <= ((not(MSP) and Dout(1)) or (not(Dout(1)) and (M7 nand M11))) and roll and not(loss);
	LD		:	DFlipFlop			port map ('1', iLoss, reset, loss, throw(0));
	WD		:	DFlipFlop			port map ('1', iWin, reset, win, throw(1));
end rtl;