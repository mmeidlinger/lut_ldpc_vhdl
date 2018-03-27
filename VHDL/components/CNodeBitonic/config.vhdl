library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
library work;

package config is

  -- LLR bit-widths
  constant QLLR : integer := 3;

  -- Check node degree
  constant CNodeDegree : integer := 32;
  constant CNodeDegreeLog : integer := integer(log2(real(CNodeDegree)));

  -- Internal LLR
  subtype IntLLRSubType is integer range 0 to 2**QLLR-1;
  type IntLLRTypeC is array (0 to CNodeDegree-1) of IntLLRSubType;

  -- Absolute values of internal LLRs
  subtype IntAbsLLRSubType is std_logic_vector(QLLR-2 downto 0);
  type IntAbsLLRTypeC is array (0 to CNodeDegree-1) of IntAbsLLRSubType;

  -- Minmum output type
  type MinType is array (0 to 1) of std_logic_vector(QLLR-2 downto 0);
  
  -- Sorter types
  constant SorterStages : integer := (CNodeDegreeLog-1+2)*(CNodeDegreeLog-1+1)/2;
  subtype StageCounter is integer range 0 to SorterStages;  
  type IntLLRAbsStage is array (0 to SorterStages) of IntAbsLLRTypeC;
  
  -- Function for bitonic sorter
  function GETSTAGECOUNT(ii : in integer range 0 to CNodeDegreeLog-1) return StageCounter;
  
end config;

package body config is

  function GETSTAGECOUNT(ii : in integer range 0 to CNodeDegreeLog-1) return StageCounter is
    variable sum : integer range 0 to SorterStages;
  begin
    sum := 0;
    for jj in 0 to ii loop
      sum := sum + jj;
    end loop;
    return sum;
  end;
  
end config;
