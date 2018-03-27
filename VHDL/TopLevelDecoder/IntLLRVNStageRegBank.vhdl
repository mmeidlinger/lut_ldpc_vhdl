library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_misc.all;
library work;
use work.config.all;


entity IntLLRVNStageRegBank is
  port (
    ClkxCI           : in std_logic;
    RstxRBI          : in std_logic;   
    IntLLRVNStagexDI : in IntLLRTypeVNStage;  -- A 3-D array of M times CNdegree time  Q bit width
    IntLLRVNStagexDO : out IntLLRTypeVNStage
    );    
end IntLLRVNStageRegBank;


architecture behavioral of IntLLRVNStageRegBank is
	

  signal IntLLRVNStagexDN : IntLLRTypeVNStage;
  signal IntLLRVNStagexDP : IntLLRTypeVNStage;  -- The pipeline register at the output of varialbe nodes
    
begin  -- structural
  
  IntLLRVNStagexDN <= IntLLRVNStagexDI;
  -- purpose: Present State
  -- type   : sequential
  -- inputs : ClkxCI, RstxRBI,
  process (ClkxCI, RstxRBI)
    begin  -- process
      if RstxRBI = '0' then            -- asynchronous reset (active low)
        IntLLRVNStagexDP <= (others => (others =>  0 ));
      elsif rising_edge(ClkxCI) then
        IntLLRVNStagexDP <= IntLLRVNStagexDN;
      end if;
  end process;

   -- Output Assignment
  IntLLRVNStagexDO <= IntLLRVNStagexDP;

end behavioral;
