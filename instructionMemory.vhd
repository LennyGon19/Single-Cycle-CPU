library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity instructionMemory is
port(
	readAddress: in std_logic_vector(31 downto 0);
	instruction : out std_logic_vector(31 downto 0);
	immediate : out std_logic_vector(15 downto 0);
	rs: out std_logic_vector(4 downto 0);
	rt: out std_logic_vector(4 downto 0); 
	rd: out std_logic_vector(4 downto 0);
	op: out std_logic_vector(5 downto 0);
	clock : in std_logic
);
end instructionMemory;

architecture arch of instructionMemory is
	begin
		process(clock)
		begin
			if ((clock'event) and (clock = '1')) then
			instruction <= readAddress;
			op <= readAddress(31 downto 26);
			rs <= readAddress(25 downto 21);
			rt <= readAddress(20 downto 16);
			rd <= readAddress(15 downto 11);
			immediate <= readAddress(15 downto 0);
			end if;
		end process;
end arch;