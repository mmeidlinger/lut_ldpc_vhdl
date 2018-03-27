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
		IntLLRVNStagexDO  : out IntLLRTypeVNStage;
		ChLLRVNStagexDO   : out ChLLRTypeStage
    );
    
end VNODELUTNAME;

architecture structural of VNODELUTNAME is
	
  component VNODELUTCOMPONENT  
    port (
      ChLLRxDI  : in  ChLLRType;
      IntLLRxDI : in  IntLLRTypeV;
			IntLLRxDO : out IntLLRTypeV);
  end component;

  -- Register bank to store channel LLRs
  component ChLLRRegBank
  port (
    ClkxCI           : in std_logic;
    RstxRBI          : in std_logic;   
    ChLLRxDI         : in ChLLRTypeStage;  -- A 2-D array of N times Q bit width
    ChLLRxDO         : out ChLLRTypeStage
    );    
  end component;

  -- Register bank to store internal LLRs
  component IntLLRVNStageRegBank
  port (
    ClkxCI           : in std_logic;
    RstxRBI          : in std_logic;   
    IntLLRVNStagexDI : in IntLLRTypeVNStage;
    IntLLRVNStagexDO : out IntLLRTypeVNStage
    );    
  end component;
   
  signal ChLLRVNStagexDN : ChLLRTypeStage;
  signal ChLLRVNStagexDP : ChLLRTypeStage;       -- The pipeline register for the channel LLR
  signal IntLLRVNStagexD : IntLLRTypeVNStage;
    
begin  -- structural

  -- Instantiate register banks
  -- Channel LLRs
  ChLLRRegBank_1: ChLLRRegBank port map (
    ClkxCI => ClkxCI,
    RstxRBI => RstxRBI,
    ChLLRxDI => ChLLRVNStagexDI,
    ChLLRxDO => ChLLRVNStagexDO
  );

  -- Internal messages
  IntLLRVNStageRegBank_1: IntLLRVNStageRegBank port map (
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
       IntLLRxDO => IntLLRVNStagexD(i));
  end generate;
  
end structural;
