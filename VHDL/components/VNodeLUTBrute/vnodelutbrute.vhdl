library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
use work.config.all;

entity VNodeLUTBrute is
  
  port (
    ChLLRxDI  : in  ChLLRType;
    IntLLRxDI : in  IntLLRType;
    OutLLRxDO : out IntLLRType
    );
end VNodeLUTBrute;

architecture arch of VNodeLUTBrute is

signal LUTAddrxS : LUTAddrType;
signal LUTAddrSLVxS : LUTAddrSLVType;

begin  -- arch

  genAddr: process (ChLLRxDI,IntLLRxDI)
    variable cnt : integer := 0;
  begin  -- process genAddr

    -- Default assignment
    LUTAddrSLVxS <= (others=>(others=>'0'));

    -- Generate addresses
    for ii in 0 to VNodeDegree-1 loop
      cnt := 0;
      -- Last address is always channel address
      LUTAddrSLVxS(ii)((VNodeDegree-1)*QLLR to (VNodeDegree-1)*QLLR+QCh-1) <= std_logic_vector(to_unsigned(ChLLRxDI,QCh));
      for jj in 0 to VNodeDegree-1 loop
        if( ii /= jj ) then
          LUTAddrSLVxS(ii)(cnt*QLLR to (cnt+1)*QLLR-1) <= std_logic_vector(to_unsigned(IntLLRxDI(ii),QLLR));
          cnt := cnt + 1;
        end if;
      end loop;  -- jj
    end loop;  -- ii
  end process genAddr;

  genOutput: process (LUTAddrSLVxS,LUTAddrxS)
  begin  -- process genOutput
    for ii in 0 to VNodeDegree-1 loop
      LUTAddrxS(ii) <= to_integer(unsigned(LUTAddrSLVxS(ii)));
      OutLLRxDO(ii) <= LUT(LUTAddrxS(ii));
    end loop;  -- ii
  end process genOutput;
    
end arch;
