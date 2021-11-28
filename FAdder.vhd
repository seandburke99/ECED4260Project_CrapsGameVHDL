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

entity FAdder is
	port (
		a   :	in  std_logic;
        b   :   in  std_logic;
		cin :	in  std_logic;
		y	:	out std_logic;
        cout:   out std_logic
	);
end FAdder;

architecture gate of FAdder is
begin
    y = a xor b xor cin;
    cout = (a and b) or (a and cin) or (b and cin);
end gate;