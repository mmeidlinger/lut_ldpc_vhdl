library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_misc.all;
library work;
use work.config.all;

entity Min4 is
  
  port (
    Abs0xDI		: in IntAbsLLRSubType;
    Abs1xDI		: in IntAbsLLRSubType;
    Abs2xDI		: in IntAbsLLRSubType;
    Abs3xDI		: in IntAbsLLRSubType;
    Min0xDO		: out IntAbsLLRSubType;
    Min1xDO		: out IntAbsLLRSubType
    );
end Min4;

architecture arch of Min4 is

  -- Signals used to find second minimum
  signal toComp0xD, toComp1xD   : IntAbsLLRSubType;
  
begin

  -- Min0 (assumes that the input is sorted so that Abs0 < Abs1 and Abs2 < Abs3)
  min0_memless: process(Abs0xDI,Abs2xDI, Abs1xDI,Abs3xDI)
  begin
    if( Abs0xDI < Abs2xDI ) then
      Min0xDO <= Abs0xDI;
      toComp0xD <= Abs1xDI;
      toComp1xD <= Abs2xDI;
    else
      Min0xDO <= Abs2xDI;
      toComp0xD <= Abs0xDI;
      toComp1xD <= Abs3xDI;
    end if;
  end process;

  -- Min1 (assumes that the input is sorted so that Abs0 < Abs1 and Abs2 < Abs3)
  min1_memless: process(toComp0xD,toComp1xD)
  begin
    if( toComp0xD < toComp1xD ) then
      Min1xDO <= toComp0xD;
    else
      Min1xDO <= toComp1xD;
    end if;
  end process;
  
  
end arch;
