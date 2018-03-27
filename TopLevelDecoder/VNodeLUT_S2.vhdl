library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
use work.config.all;

entity VNodeLUT_S2 is
  port (
    ChLLRxDI  : in  ChLLRType;
    IntLLRxDI : in  IntLLRTypeV;
    IntLLRxDO : out IntLLRTypeV);
end VNodeLUT_S2;

architecture arch of VNodeLUT_S2 is

  signal LUTAddrL0_N0_0xD, LUTAddrL0_N0_1xD, LUTAddrL0_N0_2xD, LUTAddrL0_N0_3xD, LUTAddrL0_N0_4xD, LUTAddrL0_N0_5xD : LUTAddrL0_N0_S2;
  signal LUTAddrL1_N0_0xD, LUTAddrL1_N0_1xD, LUTAddrL1_N0_2xD, LUTAddrL1_N0_3xD, LUTAddrL1_N0_4xD, LUTAddrL1_N0_5xD : LUTAddrL1_N0_S2;
  signal LUTAddrL2_N0_0xD, LUTAddrL2_N0_1xD, LUTAddrL2_N0_2xD, LUTAddrL2_N0_3xD, LUTAddrL2_N0_4xD, LUTAddrL2_N0_5xD : LUTAddrL2_N0_S2;
  signal LUTAddrL2_N1_0xD, LUTAddrL2_N1_1xD, LUTAddrL2_N1_2xD, LUTAddrL2_N1_3xD, LUTAddrL2_N1_4xD, LUTAddrL2_N1_5xD : LUTAddrL2_N1_S2;
  signal LUTAddrL3_N0_0xD, LUTAddrL3_N0_1xD, LUTAddrL3_N0_2xD, LUTAddrL3_N0_3xD, LUTAddrL3_N0_4xD, LUTAddrL3_N0_5xD : LUTAddrL3_N0_S2;

  signal LUTDataL0_N0_0xD, LUTDataL0_N0_1xD, LUTDataL0_N0_2xD, LUTDataL0_N0_3xD, LUTDataL0_N0_4xD, LUTDataL0_N0_5xD : integer range 0 to 2**3-1;
  signal LUTDataL1_N0_0xD, LUTDataL1_N0_1xD, LUTDataL1_N0_2xD, LUTDataL1_N0_3xD, LUTDataL1_N0_4xD, LUTDataL1_N0_5xD : integer range 0 to 2**3-1;
  signal LUTDataL2_N0_0xD, LUTDataL2_N0_1xD, LUTDataL2_N0_2xD, LUTDataL2_N0_3xD, LUTDataL2_N0_4xD, LUTDataL2_N0_5xD : integer range 0 to 2**3-1;
  signal LUTDataL2_N1_0xD, LUTDataL2_N1_1xD, LUTDataL2_N1_2xD, LUTDataL2_N1_3xD, LUTDataL2_N1_4xD, LUTDataL2_N1_5xD : integer range 0 to 2**3-1;
  signal LUTDataL3_N0_0xD, LUTDataL3_N0_1xD, LUTDataL3_N0_2xD, LUTDataL3_N0_3xD, LUTDataL3_N0_4xD, LUTDataL3_N0_5xD : integer range 0 to 2**3-1;

begin -- arch

  -- Generate LUT read addresses
  LUTAddrL3_N0_0xD <= std_logic_vector(to_unsigned(IntLLRxDI(1),3)) & std_logic_vector(to_unsigned(IntLLRxDI(2),3));
  LUTAddrL3_N0_1xD <= std_logic_vector(to_unsigned(IntLLRxDI(0),3)) & std_logic_vector(to_unsigned(IntLLRxDI(2),3));
  LUTAddrL3_N0_2xD <= std_logic_vector(to_unsigned(IntLLRxDI(0),3)) & std_logic_vector(to_unsigned(IntLLRxDI(1),3));
  LUTAddrL3_N0_3xD <= std_logic_vector(to_unsigned(IntLLRxDI(0),3)) & std_logic_vector(to_unsigned(IntLLRxDI(1),3));
  LUTAddrL3_N0_4xD <= std_logic_vector(to_unsigned(IntLLRxDI(0),3)) & std_logic_vector(to_unsigned(IntLLRxDI(1),3));
  LUTAddrL3_N0_5xD <= std_logic_vector(to_unsigned(IntLLRxDI(0),3)) & std_logic_vector(to_unsigned(IntLLRxDI(1),3));

  LUTAddrL2_N0_0xD <= std_logic_vector(to_unsigned(IntLLRxDI(3),3)) & std_logic_vector(to_unsigned(IntLLRxDI(4),3));
  LUTAddrL2_N0_1xD <= std_logic_vector(to_unsigned(IntLLRxDI(3),3)) & std_logic_vector(to_unsigned(IntLLRxDI(4),3));
  LUTAddrL2_N0_2xD <= std_logic_vector(to_unsigned(IntLLRxDI(3),3)) & std_logic_vector(to_unsigned(IntLLRxDI(4),3));
  LUTAddrL2_N0_3xD <= std_logic_vector(to_unsigned(IntLLRxDI(2),3)) & std_logic_vector(to_unsigned(IntLLRxDI(4),3));
  LUTAddrL2_N0_4xD <= std_logic_vector(to_unsigned(IntLLRxDI(2),3)) & std_logic_vector(to_unsigned(IntLLRxDI(3),3));
  LUTAddrL2_N0_5xD <= std_logic_vector(to_unsigned(IntLLRxDI(2),3)) & std_logic_vector(to_unsigned(IntLLRxDI(3),3));

  LUTAddrL2_N1_0xD <= std_logic_vector(to_unsigned(IntLLRxDI(5),3)) & std_logic_vector(to_unsigned(LUTDataL3_N0_0xD,3));
  LUTAddrL2_N1_1xD <= std_logic_vector(to_unsigned(IntLLRxDI(5),3)) & std_logic_vector(to_unsigned(LUTDataL3_N0_1xD,3));
  LUTAddrL2_N1_2xD <= std_logic_vector(to_unsigned(IntLLRxDI(5),3)) & std_logic_vector(to_unsigned(LUTDataL3_N0_2xD,3));
  LUTAddrL2_N1_3xD <= std_logic_vector(to_unsigned(IntLLRxDI(5),3)) & std_logic_vector(to_unsigned(LUTDataL3_N0_3xD,3));
  LUTAddrL2_N1_4xD <= std_logic_vector(to_unsigned(IntLLRxDI(5),3)) & std_logic_vector(to_unsigned(LUTDataL3_N0_4xD,3));
  LUTAddrL2_N1_5xD <= std_logic_vector(to_unsigned(IntLLRxDI(4),3)) & std_logic_vector(to_unsigned(LUTDataL3_N0_5xD,3));

  LUTAddrL1_N0_0xD <= std_logic_vector(to_unsigned(LUTDataL2_N0_0xD,3)) & std_logic_vector(to_unsigned(LUTDataL2_N1_0xD,3));
  LUTAddrL1_N0_1xD <= std_logic_vector(to_unsigned(LUTDataL2_N0_1xD,3)) & std_logic_vector(to_unsigned(LUTDataL2_N1_1xD,3));
  LUTAddrL1_N0_2xD <= std_logic_vector(to_unsigned(LUTDataL2_N0_2xD,3)) & std_logic_vector(to_unsigned(LUTDataL2_N1_2xD,3));
  LUTAddrL1_N0_3xD <= std_logic_vector(to_unsigned(LUTDataL2_N0_3xD,3)) & std_logic_vector(to_unsigned(LUTDataL2_N1_3xD,3));
  LUTAddrL1_N0_4xD <= std_logic_vector(to_unsigned(LUTDataL2_N0_4xD,3)) & std_logic_vector(to_unsigned(LUTDataL2_N1_4xD,3));
  LUTAddrL1_N0_5xD <= std_logic_vector(to_unsigned(LUTDataL2_N0_5xD,3)) & std_logic_vector(to_unsigned(LUTDataL2_N1_5xD,3));

  LUTAddrL0_N0_0xD <= std_logic_vector(to_unsigned(LUTDataL1_N0_0xD,3)) & std_logic_vector(to_unsigned(ChLLRxDI,4));
  LUTAddrL0_N0_1xD <= std_logic_vector(to_unsigned(LUTDataL1_N0_1xD,3)) & std_logic_vector(to_unsigned(ChLLRxDI,4));
  LUTAddrL0_N0_2xD <= std_logic_vector(to_unsigned(LUTDataL1_N0_2xD,3)) & std_logic_vector(to_unsigned(ChLLRxDI,4));
  LUTAddrL0_N0_3xD <= std_logic_vector(to_unsigned(LUTDataL1_N0_3xD,3)) & std_logic_vector(to_unsigned(ChLLRxDI,4));
  LUTAddrL0_N0_4xD <= std_logic_vector(to_unsigned(LUTDataL1_N0_4xD,3)) & std_logic_vector(to_unsigned(ChLLRxDI,4));
  LUTAddrL0_N0_5xD <= std_logic_vector(to_unsigned(LUTDataL1_N0_5xD,3)) & std_logic_vector(to_unsigned(ChLLRxDI,4));

  -- Read from LUTs
  IntLLrxDO(0) <= LUTL0_N0_S2(to_integer(unsigned(LUTAddrL0_N0_0xD)));
  IntLLrxDO(1) <= LUTL0_N0_S2(to_integer(unsigned(LUTAddrL0_N0_1xD)));
  IntLLrxDO(2) <= LUTL0_N0_S2(to_integer(unsigned(LUTAddrL0_N0_2xD)));
  IntLLrxDO(3) <= LUTL0_N0_S2(to_integer(unsigned(LUTAddrL0_N0_3xD)));
  IntLLrxDO(4) <= LUTL0_N0_S2(to_integer(unsigned(LUTAddrL0_N0_4xD)));
  IntLLrxDO(5) <= LUTL0_N0_S2(to_integer(unsigned(LUTAddrL0_N0_5xD)));

  LUTDataL1_N0_0xD <= LUTL1_N0_S2(to_integer(unsigned(LUTAddrL1_N0_0xD)));
  LUTDataL1_N0_1xD <= LUTL1_N0_S2(to_integer(unsigned(LUTAddrL1_N0_1xD)));
  LUTDataL1_N0_2xD <= LUTL1_N0_S2(to_integer(unsigned(LUTAddrL1_N0_2xD)));
  LUTDataL1_N0_3xD <= LUTL1_N0_S2(to_integer(unsigned(LUTAddrL1_N0_3xD)));
  LUTDataL1_N0_4xD <= LUTL1_N0_S2(to_integer(unsigned(LUTAddrL1_N0_4xD)));
  LUTDataL1_N0_5xD <= LUTL1_N0_S2(to_integer(unsigned(LUTAddrL1_N0_5xD)));

  LUTDataL2_N0_0xD <= LUTL2_N0_S2(to_integer(unsigned(LUTAddrL2_N0_0xD)));
  LUTDataL2_N0_1xD <= LUTL2_N0_S2(to_integer(unsigned(LUTAddrL2_N0_1xD)));
  LUTDataL2_N0_2xD <= LUTL2_N0_S2(to_integer(unsigned(LUTAddrL2_N0_2xD)));
  LUTDataL2_N0_3xD <= LUTL2_N0_S2(to_integer(unsigned(LUTAddrL2_N0_3xD)));
  LUTDataL2_N0_4xD <= LUTL2_N0_S2(to_integer(unsigned(LUTAddrL2_N0_4xD)));
  LUTDataL2_N0_5xD <= LUTL2_N0_S2(to_integer(unsigned(LUTAddrL2_N0_5xD)));

  LUTDataL2_N1_0xD <= LUTL2_N1_S2(to_integer(unsigned(LUTAddrL2_N1_0xD)));
  LUTDataL2_N1_1xD <= LUTL2_N1_S2(to_integer(unsigned(LUTAddrL2_N1_1xD)));
  LUTDataL2_N1_2xD <= LUTL2_N1_S2(to_integer(unsigned(LUTAddrL2_N1_2xD)));
  LUTDataL2_N1_3xD <= LUTL2_N1_S2(to_integer(unsigned(LUTAddrL2_N1_3xD)));
  LUTDataL2_N1_4xD <= LUTL2_N1_S2(to_integer(unsigned(LUTAddrL2_N1_4xD)));
  LUTDataL2_N1_5xD <= LUTL2_N1_S2(to_integer(unsigned(LUTAddrL2_N1_5xD)));

  LUTDataL3_N0_0xD <= LUTL3_N0_S2(to_integer(unsigned(LUTAddrL3_N0_0xD)));
  LUTDataL3_N0_1xD <= LUTL3_N0_S2(to_integer(unsigned(LUTAddrL3_N0_1xD)));
  LUTDataL3_N0_2xD <= LUTL3_N0_S2(to_integer(unsigned(LUTAddrL3_N0_2xD)));
  LUTDataL3_N0_3xD <= LUTL3_N0_S2(to_integer(unsigned(LUTAddrL3_N0_3xD)));
  LUTDataL3_N0_4xD <= LUTL3_N0_S2(to_integer(unsigned(LUTAddrL3_N0_4xD)));
  LUTDataL3_N0_5xD <= LUTL3_N0_S2(to_integer(unsigned(LUTAddrL3_N0_5xD)));


end arch;