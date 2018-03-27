library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_misc.all;
library work;
use work.config.all;


entity ChLLRRegBank is
  port (
    ClkxCI           : in std_logic;
    RstxRBI          : in std_logic;   
    ChLLRxDI         : in ChLLRTypeStage;  -- A 2-D array of N times Q bit width
    ChLLRxDO         : out ChLLRTypeStage
    );    
end ChLLRRegBank;


architecture behavioral of ChLLRRegBank is
	

  signal ChLLRxDN : ChLLRTypeStage;
  signal ChLLRxDP : ChLLRTypeStage;  -- The pipeline register for the channel LLR
    
begin  -- structural
  
  ChLLRxDN <= ChLLRxDI;
  -- purpose: Present State
  -- type   : sequential
  -- inputs : ClkxCI, RstxRBI,
  process (ClkxCI, RstxRBI)
    begin  -- process
      if RstxRBI = '0' then            -- asynchronous reset (active low)
        ChLLRxDP <= (others=>(others=>'0'));
      elsif rising_edge(ClkxCI) then
        ChLLRxDP <= ChLLRxDN;
      end if;
  end process;

   -- Output Assignment
  ChLLRxDO  <= ChLLRxDP;
  
end behavioral;
