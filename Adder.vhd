---------------------------------------------------
-- An FPGA version of the Craps Dice Game
-- Author: 	Sean Burke
-- Student ID: 	B00776071
-- File Name: 	Adder.vhd
-- Description: 
-- Acknowledgements:
---------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity Adder is
	port (
		a	:	in std_logic_vector(2 downto 0);
		b   :	in std_logic_vector(2 downto 0);
		y	:	out std_logic_vector(3 downto 0)
	);
end Adder;

architecture rtl of Adder is
	component FAdder
		port (
			a   :	in  std_logic;
			b   :   in  std_logic;
			cin :	in  std_logic;
			y	:	out std_logic;
			cout:   out std_logic
		);
	end component;
	signal carry	:	std_logic_vector(1 downto 0);
	signal throw	:	std_logic;
begin
	FA0	:	FAdder	port map	(a(0), b(0), '0', y(0), carry(0));
	FA1	:	FAdder	port map	(a(1), b(1), carry(0), y(1), carry(1));
	FA2	:	FAdder	port map	(a(2), b(2), carry(1), y(2), y(3));
end rtl;