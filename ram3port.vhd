LIBRARY ieee;
USE ieee.std_logic_1164.all;
LIBRARY altera_mf; USE altera_mf.all;

ENTITY ram3port IS PORT
(
	clock : IN STD_LOGIC ;
	data : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
	rdaddress_a : IN STD_LOGIC_VECTOR (4 DOWNTO 0); 
	rdaddress_b : IN STD_LOGIC_VECTOR (4 DOWNTO 0); 
	wraddress : IN STD_LOGIC_VECTOR (4 DOWNTO 0); 
	wren : IN STD_LOGIC := '1';
	qa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0); 
	qb : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
);
END ram3port;

ARCHITECTURE SYN OF ram3port IS
	SIGNAL sub_wire0 : STD_LOGIC_VECTOR (31 DOWNTO 0); SIGNAL sub_wire1 : STD_LOGIC_VECTOR (31 DOWNTO 0);
	
	COMPONENT alt3pram
		GENERIC (
		indata_aclr : STRING;
		indata_reg : STRING; intended_device_family : STRING; lpm_type : STRING; outdata_aclr_a : STRING;
		outdata_aclr_b : STRING;
		outdata_reg_a : STRING;
		outdata_reg_b : STRING; rdaddress_aclr_a : STRING;
		rdaddress_aclr_b : STRING; rdaddress_reg_a : STRING; rdaddress_reg_b : STRING; rdcontrol_aclr_a : STRING;
		rdcontrol_aclr_b : STRING; rdcontrol_reg_a : STRING; rdcontrol_reg_b : STRING; width : NATURAL;
		widthad : NATURAL; write_aclr : STRING;
		write_reg : STRING
		); 
		
		PORT (
			qa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
			outclock : IN STD_LOGIC ;
			qb : OUT STD_LOGIC_VECTOR (31 DOWNTO 0); 
			wren : IN STD_LOGIC ;
			inclock : IN STD_LOGIC ;
			data: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			rdaddress_a : IN STD_LOGIC_VECTOR (4 DOWNTO 0); 
			wraddress : IN STD_LOGIC_VECTOR (4 DOWNTO 0);
			rdaddress_b : IN STD_LOGIC_VECTOR (4 DOWNTO 0)
		);
	END COMPONENT;
	
	BEGIN
		qa <= sub_wire0(31 DOWNTO 0); qb <= sub_wire1(31 DOWNTO 0);
		alt3pram_component : alt3pram
		
	GENERIC MAP (
		indata_aclr => "OFF", indata_reg => "INCLOCK",
		intended_device_family => "Stratix II", lpm_type => "alt3pram",
		outdata_aclr_a => "OFF", outdata_aclr_b => "OFF", outdata_reg_a => "OUTCLOCK", outdata_reg_b => "OUTCLOCK", rdaddress_aclr_a => "OFF", rdaddress_aclr_b => "OFF", rdaddress_reg_a => "INCLOCK", rdaddress_reg_b => "INCLOCK", rdcontrol_aclr_a => "OFF", rdcontrol_aclr_b => "OFF", rdcontrol_reg_a => "UNREGISTERED", rdcontrol_reg_b => "UNREGISTERED", width => 32,
		widthad => 5, write_aclr => "OFF", write_reg => "INCLOCK"
	)
	
	PORT MAP (
		outclock => clock, wren => wren, inclock => clock, data => data,
		rdaddress_a => rdaddress_a, wraddress => wraddress, rdaddress_b => rdaddress_b, qa => sub_wire0,
		qb => sub_wire1
	);
END SYN;