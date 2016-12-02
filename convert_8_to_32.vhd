library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity conversion_switches_to_memory is
	port(input : in std_logic_vector(7 downto 0);
	location	  : in std_logic_vector(1 downto 0);
	key		  : in std_logic;
	buffer_conv: out std_logic_vector(31 downto 0));
end conversion_switches_to_memory;

architecture arch of conversion_switches_to_memory is
begin
process(key)
begin
	if key = '1' then
		case location is
		when "00" =>
			buffer_conv(7 downto 0) <= input;
		when "01" =>
			buffer_conv(15 downto 8) <= input;
		when "10" =>
			buffer_conv(23 downto 16) <= input;
		when "11" =>
			buffer_conv(31 downto 24) <= input;
		end case;
	end if;
end process;
end arch;