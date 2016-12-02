library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_arith.all;

entity ALU is
port(
	A,B: in std_logic_vector(31 downto 0);
	aluopcode : in std_logic_vector(2 downto 0);
	zero: out std_logic;
	aluresult : out std_logic_vector(31 downto 0)
);
end ALU;

architecture arch of ALU is

	component add_sub
	PORT
	(
		add_sub : IN STD_LOGIC ;
		dataa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		datab : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		overflow		: OUT STD_LOGIC ;
		result : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
	);
	end component;
	
	component mult16 IS

		PORT
	(
		dataa		: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
		datab		: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
		result		: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
	);

	END component;
	
	component div32 IS
	PORT
	(
		denom		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		numer		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		quotient		: OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
		remain		: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
	);
	END component;
	
	signal arithmeticresult : std_logic_vector(31 downto 0);
	signal product : std_logic_vector(31 downto 0);
	signal quotients: std_logic_vector(31 downto 0);
	signal remainder: std_logic_vector(31 downto 0);
	signal output : std_logic_vector(31 downto 0);
	signal cmpr: std_logic_vector(31 downto 0);
	signal overflw: STD_LOGIC ;
	signal zeroreg: STD_LOGIC ;
	
	begin
	process (A,B,aluopcode,cmpr,arithmeticresult, product) 
		begin
			if(cmpr = x"00000000") then --if equal, zeroreg == 1, otherwise 0; used for beq instruction
				zeroreg <= '1';
			else 
				zeroreg <= '0';
			end if;
		
			case aluopcode is
				when "000" => output <= arithmeticresult; -- addition 
				when "001" => output <= arithmeticresult; -- subtraction
				when "010" => output <= product; --multiply unsigned
				when "011" => output <= quotients; --divide unsigned
				when "100" => output <= (A or B); -- or
				when "101" => output <= (A and B); --and
				when "110" => output <= (A nor B); --nor
				when "111" => output <= (A xor B); --xor
				when others => NULL;
			end case;
		end process;
		aluresult <= output;
		zero <= zeroreg;
		addsubber: add_sub port map (not(aluopcode(0)), A, B, overflw, arithmeticresult);
		comparison: add_sub port map ('0', A, B,overflw, cmpr);
		multiply: mult16 port map(A(15 downto 0),B(15 downto 0), product );
		divide: div32 port map(B,A,quotients,remainder);
end arch;