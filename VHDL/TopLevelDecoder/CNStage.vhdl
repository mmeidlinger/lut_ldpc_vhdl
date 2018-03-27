library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_misc.all;
library work;
use work.config.all;


entity CNStage is
  port (
    ClkxCI           : in std_logic;
    RstxRBI          : in std_logic;
    IntLLRCNStagexDI : in IntLLRTypeCNStage;  -- A 3-D array of M times CNdegree time  Q bit width
    ChLLRCNStagexDI  : in ChLLRTypeStage;  -- A 2-D array of N times Q bit width
    IntLLRCNStagexDO : out IntLLRTypeCNStage;
    ChLLRCNStagexDO  : out ChLLRTypeStage
    );    
end CNStage;

architecture structural of CNStage is

  component CNodeTree
    port (
       IntLLRxDI : in  IntLLRTypeC;
       IntLLRxDO : out IntLLRTypeC
    );
  end component;
  
  component IntLLRCNStageRegBank
  port (
    ClkxCI           : in std_logic;
    RstxRBI          : in std_logic;   
    IntLLRCNStagexDI : in IntLLRTypeCNStage;
    IntLLRCNStagexDO : out IntLLRTypeCNStage
    );    
   end component;
   
  component ChLLRRegBank
  port (
    ClkxCI           : in std_logic;
    RstxRBI          : in std_logic;   
    ChLLRxDI         : in ChLLRTypeStage;
    ChLLRxDO         : out ChLLRTypeStage
    );    
  end component;
   
  signal IntLLRCNStagexD : IntLLRTypeCNStage;

begin  -- structural

  Gen_CheckNode: for i in 0 to M-1 generate
     CNodeTree_Inst : CNodeTree port map (
       IntLLRxDI => IntLLRCNStagexDI(i),
       IntLLRxDO => IntLLRCNStagexD(i));
  end generate;

  IntLLRCNStageRegBank_Inst : IntLLRCNStageRegBank port map (
    ClkxCI           => ClkxCI, 
    RstxRBI          => RstxRBI,
    IntLLRCNStagexDI => IntLLRCNStagexD,
    IntLLRCNStagexDO => IntLLRCNStagexDO);

  ChLLRRegBank_Inst: ChLLRRegBank  port map (
    ClkxCI           => ClkxCI,
    RstxRBI          => RstxRBI,
    ChLLRxDI         => ChLLRCNStagexDI,
    ChLLRxDO         => ChLLRCNStagexDO); 

 
end structural;
