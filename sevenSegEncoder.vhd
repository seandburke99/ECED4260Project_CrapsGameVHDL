---------------------------------------------------
-- An FPGA version of the Craps Dice Game
-- Author: 	Sean Burke, Brad Jones
-- Student ID: 	B00776071, B00746735
-- File Name: 	PointRegister.vhd
-- Description: 
-- Acknowledgements:
---------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity sevenSegEncoder is
	port (
		x   :   in  std_logic_vector(2 downto 0);
		y	:	out std_logic_vector(6 downto 0)
	);
end sevenSegEncoder;

architecture gate of sevenSegEncoder is
begin
	y(6) <= not(x(2)) and not(x(1));
    y(5) <= not(x(2));
    y(4) <= not(x(1)) or x(0);
    y(3) <= not(x(1)) and (not(x(2)) or not(x(0)));
    y(2) <= not(x(2)) and not(x(0));
    y(1) <= x(2) and (x(0) or x(1));
    y(0) <= not(x(1)) and (not(x(2)) or not(x(0)));
    
end gate;