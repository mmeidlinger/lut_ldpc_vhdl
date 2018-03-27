library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
use work.config.all;

entity VNodeLUTTree is  
  port (
    ChLLRxDI  : in  ChLLRType;
    IntLLRxDI : in  IntLLRTypeV;
    IntLLRxDO : out IntLLRTypeV);
end VNodeLUTTree;

architecture arch of VNodeLUTTree is

  -- LUT addresses
  signal LUTAddr11_0xD, LUTAddr11_1xD, LUTAddr11_2xD, LUTAddr11_3xD, LUTAddr11_4xD, LUTAddr11_5xD  : LUTAddr11;
  signal LUTAddr21_0xD, LUTAddr21_1xD, LUTAddr21_2xD, LUTAddr21_3xD, LUTAddr21_4xD, LUTAddr21_5xD  : LUTAddr21;
  signal LUTAddr22_0xD, LUTAddr22_1xD, LUTAddr22_2xD, LUTAddr22_3xD, LUTAddr22_4xD, LUTAddr22_5xD  : LUTAddr22;
  signal LUTAddr23_0xD, LUTAddr23_1xD, LUTAddr23_2xD, LUTAddr23_3xD, LUTAddr23_4xD, LUTAddr23_5xD  : LUTAddr23;

  -- Intermediate LUT outputs
  signal LUTData11_0xD, LUTData11_1xD, LUTData11_2xD, LUTData11_3xD, LUTData11_4xD, LUTData11_5xD  : integer range 0 to 2**QLLR-1;
  signal LUTData21_0xD, LUTData21_1xD, LUTData21_2xD, LUTData21_3xD, LUTData21_4xD, LUTData21_5xD  : integer range 0 to 2**QLLR-1;
  signal LUTData22_0xD, LUTData22_1xD, LUTData22_2xD, LUTData22_3xD, LUTData22_4xD, LUTData22_5xD  : integer range 0 to 2**QLLR-1;
  signal LUTData23_0xD, LUTData23_1xD, LUTData23_2xD, LUTData23_3xD, LUTData23_4xD, LUTData23_5xD  : integer range 0 to 2**QLLR-1;

begin  -- arch

    -- LUT11 addresses
  LUTAddr11_0xD <= std_logic_vector(to_unsigned(LUTData21_0xD,QLLR)) & std_logic_vector(to_unsigned(LUTData22_0xD,QLLR)) & std_logic_vector(to_unsigned(LUTData23_0xD,QLLR));
  LUTAddr11_1xD <= std_logic_vector(to_unsigned(LUTData21_1xD,QLLR)) & std_logic_vector(to_unsigned(LUTData22_1xD,QLLR)) & std_logic_vector(to_unsigned(LUTData23_1xD,QLLR));
  LUTAddr11_2xD <= std_logic_vector(to_unsigned(LUTData21_2xD,QLLR)) & std_logic_vector(to_unsigned(LUTData22_2xD,QLLR)) & std_logic_vector(to_unsigned(LUTData23_2xD,QLLR));
  LUTAddr11_3xD <= std_logic_vector(to_unsigned(LUTData21_3xD,QLLR)) & std_logic_vector(to_unsigned(LUTData22_3xD,QLLR)) & std_logic_vector(to_unsigned(LUTData23_3xD,QLLR));
  LUTAddr11_4xD <= std_logic_vector(to_unsigned(LUTData21_4xD,QLLR)) & std_logic_vector(to_unsigned(LUTData22_4xD,QLLR)) & std_logic_vector(to_unsigned(LUTData23_4xD,QLLR));
  LUTAddr11_5xD <= std_logic_vector(to_unsigned(LUTData21_5xD,QLLR)) & std_logic_vector(to_unsigned(LUTData22_5xD,QLLR)) & std_logic_vector(to_unsigned(LUTData23_5xD,QLLR));

  -- LUT11 outputs
  IntLLrxDO(0) <= LUT11(to_integer(unsigned(LUTAddr11_0xD)));
  IntLLrxDO(1) <= LUT11(to_integer(unsigned(LUTAddr11_1xD)));
  IntLLrxDO(2) <= LUT11(to_integer(unsigned(LUTAddr11_2xD)));
  IntLLrxDO(3) <= LUT11(to_integer(unsigned(LUTAddr11_3xD)));
  IntLLrxDO(4) <= LUT11(to_integer(unsigned(LUTAddr11_4xD)));
  IntLLrxDO(5) <= LUT11(to_integer(unsigned(LUTAddr11_5xD)));

  -- LUT21 addresses
  LUTAddr21_0xD <= std_logic_vector(to_unsigned(IntLLRxDI(1),QLLR)) & std_logic_vector(to_unsigned(IntLLRxDI(2),QLLR));
  LUTAddr21_1xD <= std_logic_vector(to_unsigned(IntLLRxDI(0),QLLR)) & std_logic_vector(to_unsigned(IntLLRxDI(2),QLLR));
  LUTAddr21_2xD <= std_logic_vector(to_unsigned(IntLLRxDI(0),QLLR)) & std_logic_vector(to_unsigned(IntLLRxDI(1),QLLR));
  LUTAddr21_3xD <= std_logic_vector(to_unsigned(IntLLRxDI(0),QLLR)) & std_logic_vector(to_unsigned(IntLLRxDI(1),QLLR));
  LUTAddr21_4xD <= std_logic_vector(to_unsigned(IntLLRxDI(0),QLLR)) & std_logic_vector(to_unsigned(IntLLRxDI(1),QLLR));
  LUTAddr21_5xD <= std_logic_vector(to_unsigned(IntLLRxDI(0),QLLR)) & std_logic_vector(to_unsigned(IntLLRxDI(1),QLLR));

  -- LUT21 outputs
  LUTData21_0xD <= LUT21(to_integer(unsigned(LUTAddr21_0xD)));
  LUTData21_1xD <= LUT21(to_integer(unsigned(LUTAddr21_1xD)));
  LUTData21_2xD <= LUT21(to_integer(unsigned(LUTAddr21_2xD)));
  LUTData21_3xD <= LUT21(to_integer(unsigned(LUTAddr21_3xD)));
  LUTData21_4xD <= LUT21(to_integer(unsigned(LUTAddr21_4xD)));
  LUTData21_5xD <= LUT21(to_integer(unsigned(LUTAddr21_5xD)));
  
  -- LUT22 addresses
  LUTAddr22_0xD <= std_logic_vector(to_unsigned(IntLLRxDI(3),QLLR)) & std_logic_vector(to_unsigned(IntLLRxDI(4),QLLR));
  LUTAddr22_1xD <= std_logic_vector(to_unsigned(IntLLRxDI(3),QLLR)) & std_logic_vector(to_unsigned(IntLLRxDI(4),QLLR));
  LUTAddr22_2xD <= std_logic_vector(to_unsigned(IntLLRxDI(3),QLLR)) & std_logic_vector(to_unsigned(IntLLRxDI(4),QLLR));
  LUTAddr22_3xD <= std_logic_vector(to_unsigned(IntLLRxDI(2),QLLR)) & std_logic_vector(to_unsigned(IntLLRxDI(4),QLLR));
  LUTAddr22_4xD <= std_logic_vector(to_unsigned(IntLLRxDI(2),QLLR)) & std_logic_vector(to_unsigned(IntLLRxDI(3),QLLR));
  LUTAddr22_5xD <= std_logic_vector(to_unsigned(IntLLRxDI(2),QLLR)) & std_logic_vector(to_unsigned(IntLLRxDI(3),QLLR));

  -- LUT22 outputs
  LUTData22_0xD <= LUT22(to_integer(unsigned(LUTAddr22_0xD)));
  LUTData22_1xD <= LUT22(to_integer(unsigned(LUTAddr22_1xD)));
  LUTData22_2xD <= LUT22(to_integer(unsigned(LUTAddr22_2xD)));
  LUTData22_3xD <= LUT22(to_integer(unsigned(LUTAddr22_3xD)));
  LUTData22_4xD <= LUT22(to_integer(unsigned(LUTAddr22_4xD)));
  LUTData22_5xD <= LUT22(to_integer(unsigned(LUTAddr22_5xD)));

   -- LUT22 addresses
  LUTAddr23_0xD <= std_logic_vector(to_unsigned(IntLLRxDI(5),QLLR)) & std_logic_vector(to_unsigned(ChLLRxDI,QLLR));
  LUTAddr23_1xD <= std_logic_vector(to_unsigned(IntLLRxDI(5),QLLR)) & std_logic_vector(to_unsigned(ChLLRxDI,QLLR));
  LUTAddr23_2xD <= std_logic_vector(to_unsigned(IntLLRxDI(5),QLLR)) & std_logic_vector(to_unsigned(ChLLRxDI,QLLR));
  LUTAddr23_3xD <= std_logic_vector(to_unsigned(IntLLRxDI(5),QLLR)) & std_logic_vector(to_unsigned(ChLLRxDI,QLLR));
  LUTAddr23_4xD <= std_logic_vector(to_unsigned(IntLLRxDI(5),QLLR)) & std_logic_vector(to_unsigned(ChLLRxDI,QLLR));
  LUTAddr23_5xD <= std_logic_vector(to_unsigned(IntLLRxDI(4),QLLR)) & std_logic_vector(to_unsigned(ChLLRxDI,QLLR));

  -- LUT22 outputs
  LUTData23_0xD <= LUT23(to_integer(unsigned(LUTAddr23_0xD)));
  LUTData23_1xD <= LUT23(to_integer(unsigned(LUTAddr23_1xD)));
  LUTData23_2xD <= LUT23(to_integer(unsigned(LUTAddr23_2xD)));
  LUTData23_3xD <= LUT23(to_integer(unsigned(LUTAddr23_3xD)));
  LUTData23_4xD <= LUT23(to_integer(unsigned(LUTAddr23_4xD)));
  LUTData23_5xD <= LUT23(to_integer(unsigned(LUTAddr23_5xD)));
  
end arch;
