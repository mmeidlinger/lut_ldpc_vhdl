library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_misc.all;
library work;
use work.config.all;


entity VNODELUTNAME is
  port (
    ClkxCI            : in std_logic;
    RstxRBI           : in std_logic;
    IntLLRVNStagexDI  : in IntLLRTypeVNStage;  -- A 3-D array of M times CNdegree time  Q bit width
    ChLLRVNStagexDI   : in ChLLRTypeStage;  -- A 2-D array of N times Q bit width
		IntLLRVNStagexDO  : out std_logic_vector(N-1 downto 0) -- Decoded bits
    );
    
end VNODELUTNAME;

architecture structural of VNODELUTNAME is
	
  component VNODELUTCOMPONENT  
    port (
      ChLLRxDI      : in  ChLLRType;
      IntLLRxDI     : in  IntLLRTypeV;
			DecodedBitxDO : out std_logic);
  end component;

  -- Register bank to store internal LLRs
  component DecodedBitsVNStageRegBank
  port (
    ClkxCI           : in std_logic;
    RstxRBI          : in std_logic;   
    IntLLRVNStagexDI : in std_logic_vector(N-1 downto 0);
    IntLLRVNStagexDO : out std_logic_vector(N-1 downto 0)
    );    
  end component;
   
  signal IntLLRVNStagexD : std_logic_vector(N-1 downto 0);
    
begin  -- structural

  -- Instantiate output bit register bank
  DecodedBitsVNStageRegBank_1: DecodedBitsVNStageRegBank port map (
    ClkxCI => ClkxCI,
    RstxRBI => RstxRBI,
    IntLLRVNStagexDI => IntLLRVNStagexD,
    IntLLRVNStagexDO => IntLLRVNStagexDO
    );    

  -- Instantiate variable nodes
  Gen_VariableNode: for i in 0 to N-1 generate
     VNode_Inst : VNODELUTCOMPONENT port map (
			 ChLLRxDI => ChLLRVNStagexDI(i),
       IntLLRxDI => IntLLRVNStagexDI(i),
       DecodedBitxDO => IntLLRVNStagexD(i));
  end generate;
  
end structural;
