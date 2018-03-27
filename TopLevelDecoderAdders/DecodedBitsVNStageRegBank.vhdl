library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_misc.all;
library work;
use work.config.all;


entity DecodedBitsVNStageRegBank is
  port (
    ClkxCI           : in std_logic;
    RstxRBI          : in std_logic;   
    IntLLRVNStagexDI : in std_logic_vector(N-1 downto 0);  -- A 3-D array of M times CNdegree time  Q bit width
    IntLLRVNStagexDO : out std_logic_vector(N-1 downto 0)
    );    
end DecodedBitsVNStageRegBank;


architecture structural of DecodedBitsVNStageRegBank is
	

  signal IntLLRVNStagexDN : std_logic_vector(N-1 downto 0);
  signal IntLLRVNStagexDP : std_logic_vector(N-1 downto 0);  -- The pipeline register at the output of variable nodes
    
begin  -- structural
  
  IntLLRVNStagexDN <= IntLLRVNStagexDI;
  -- purpose: Present State
  -- type   : sequential
  -- inputs : ClkxCI, RstxRBI,
  process (ClkxCI, RstxRBI)
    begin  -- process
      if RstxRBI = '0' then            -- asynchronous reset (active low)
        IntLLRVNStagexDP <= (others=>'0');
      elsif rising_edge(ClkxCI) then
        IntLLRVNStagexDP <= IntLLRVNStagexDN;
      end if;
  end process;

   -- Output Assignment
  IntLLRVNStagexDO <= IntLLRVNStagexDP;

end structural;
