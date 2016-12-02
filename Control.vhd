library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.Numeric_Std.all;

entity Control is
  port (
    opcode  : in  std_logic_vector(5 downto 0);
    aluop   : out  std_logic_vector(2 downto 0);
    regdest : out  std_logic;
	 extop : out  std_logic;
	 alusrc : out  std_logic;
	 memwr : out  std_logic;
	 memtoreg : out  std_logic;
    pcsrc  : out  std_logic;
    regwr : out std_logic
  );
end entity Control;

architecture arch of Control is

begin

aluop(2) <= ((not(opcode(4)) and opcode(3) and not(opcode(2)) and not(opcode(1))) or (not(opcode(3)) and opcode(2) and not(opcode(1)))  or (not(opcode(3)) and not(opcode(2)) and opcode(1))) ;
aluop(1) <= ((opcode(3) and opcode(1) and not(opcode(0))) or (opcode(2) and not(opcode(1)))) ;
aluop(0) <= ((opcode(3) and opcode(2) and not(opcode(0))) or (not(opcode(4)) and opcode(0)));
regdest <= ((opcode(2) and opcode(1)) or opcode(4) or (opcode(3) and not(opcode(2)) and not(opcode(1)))) ;
extop <= (opcode(4)) ;
alusrc <= (((opcode(4) and not(opcode(0)))) or (not(opcode(3)) and opcode(2) and opcode(1)) or (opcode(3) and not(opcode(2)) and not(opcode(1)))) ;
memwr <= (opcode(4) and opcode(3) and not(opcode(0)));
memtoreg <= (opcode(3) or not(opcode(4))) ;
pcsrc <= (opcode(5)) ;
regwr <= (not(opcode(3)) or not(opcode(4))) ;

end arch;