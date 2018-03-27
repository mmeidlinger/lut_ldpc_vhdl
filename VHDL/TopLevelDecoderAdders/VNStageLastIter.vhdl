library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_misc.all;
library work;
use work.config.all;


entity VNStageLastIter is
  port (
    ClkxCI            : in std_logic;
    RstxRBI           : in std_logic;
    IntLLRVNStagexDI  : in IntLLRTypeVNStage;  -- A 3-D array of M times CNdegree time  Q bit width
    ChLLRVNStagexDI   : in ChLLRTypeStage;  -- A 2-D array of N times Q bit width
		DecodedBitsxDO    : out std_logic_vector(N-1 downto 0)
    );    
end VNStageLastIter;

architecture structural of VNStageLastIter is
	
  component VNodeAdders
    port (
      ChLLRInxDI   : in  ChLLRType;
      CVLLRInxDI   : in  IntLLRTypeV;
      VCLLROutxDO  : out IntLLRTypeV);
  end component;

  component DecodedBitsVNStageRegBank
    port (
      ClkxCI           : in std_logic;
      RstxRBI          : in std_logic;   
      IntLLRVNStagexDI : in std_logic_vector(N-1 downto 0);  -- A 3-D array of M times CNdegree time  Q bit width
      IntLLRVNStagexDO : out std_logic_vector(N-1 downto 0)
      );    
  end component;
   
  signal IntLLRVNStagexD : IntLLRTypeVNStage;
	signal DecodedBitsxD   : std_logic_vector(N-1 downto 0);

    
begin  -- structural

  Gen_VariableNode: for i in 0 to N-1 generate
     VNode_Inst : VNodeAdders port map (
			 ChLLRInxDI => ChLLRVNStagexDI(i),
       CVLLRInxDI => IntLLRVNStagexDI(i),
       VCLLROutxDO => IntLLRVNStagexD(i));
  end generate;

  DecodedBitsVNStageRegBank_0: DecodedBitsVNStageRegBank port map(
    ClkxCI => ClkxCI,
    RstxRBI => RstxRBI,
    IntLLRVNStagexDI => DecodedBitsxD,
    IntLLRVNStagexDO => DecodedBitsxDO
  );

	hard_decisions_memless: process(IntLLRVNStagexD)
  begin
	  for ii in 0 to N-1 loop
		  DecodedBitsxD(ii) <= to_std_logic(to_integer(IntLLRVNStagexD(ii)(QLLR-1)));
    end loop;
  end process;

end structural;
