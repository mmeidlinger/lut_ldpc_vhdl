library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_misc.all;
library work;
use work.config.all;


entity IntLLRCNStageRegBank is
  port (
    ClkxCI           : in std_logic;
    RstxRBI          : in std_logic;   
    IntLLRCNStagexDI : in IntLLRTypeCNStage;  -- A 3-D array of M times CNdegree time  Q bit width
    IntLLRCNStagexDO : out IntLLRTypeCNStage
    );    
end IntLLRCNStageRegBank;


architecture behavioral of IntLLRCNStageRegBank is
	

  signal IntLLRCNStagexDN : IntLLRTypeCNStage;
  signal IntLLRCNStagexDP : IntLLRTypeCNStage;  -- The pipeline register at the output of check nodes
    
begin  -- structural
  
  IntLLRCNStagexDN <= IntLLRCNStagexDI;
  -- purpose: Present State
  -- type   : sequential
  -- inputs : ClkxCI, RstxRBI,
  process (ClkxCI, RstxRBI)
    begin  -- process
      if RstxRBI = '0' then            -- asynchronous reset (active low)
        IntLLRCNStagexDP <= (others=>(others=>(others=>'0')));
      elsif rising_edge(ClkxCI) then
        IntLLRCNStagexDP <= IntLLRCNStagexDN;
      end if;
  end process;

   -- Output Assignment
  IntLLRCNStagexDO <= IntLLRCNStagexDP;

end behavioral;
