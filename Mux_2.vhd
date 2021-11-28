-------------------------------------------------------------
-- A 2-1 Mux 
-- Author	: EE4260
-- Student ID	: -------
-- Date	  	: September xx, 2016
-- File Name	: Mux_2.vhd
-- Architecture	: RTL
-- Description	: The select on the mux determines which 
--		  output appears at the output.
-- Acknowledgements:
-------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity Mux_2 is
    port (	
		Input  	: in std_logic_vector(1 downto 0);
		Sel	: in std_logic;
          	Output  : out std_logic
	);
end Mux_2;

architecture rtl of Mux_2 is

-- Declare the signals needed in the entity.
signal sel_bar : std_logic;
signal andSel  : std_logic_vector(1 downto 0);

begin
    
	sel_bar   <= not Sel;
	andSel(0) <= sel_bar and Input(0);
	andSel(1) <= Sel and Input(1);
	Output    <= andSel(1) or andSel(0); 

end rtl;
