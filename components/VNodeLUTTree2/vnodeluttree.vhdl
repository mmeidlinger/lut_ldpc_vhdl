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

  -- Intermediate LUT outputs
  signal LUTData11_0xD, LUTData11_1xD, LUTData11_2xD, LUTData11_3xD, LUTData11_4xD, LUTData11_5xD  : integer range 0 to 2**QLLR-1;
  signal LUTData21_0xD, LUTData21_1xD, LUTData21_2xD, LUTData21_3xD, LUTData21_4xD, LUTData21_5xD  : integer range 0 to 2**QLLR-1;

begin  -- arch

    -- LUT11 addresses
  LUTAddr11_0xD <= std_logic_vector(to_unsigned(LUTData21_0xD,QLLR)) & std_logic_vector(to_unsigned(ChLLRxDI,QCh));
  LUTAddr11_1xD <= std_logic_vector(to_unsigned(LUTData21_1xD,QLLR)) & std_logic_vector(to_unsigned(ChLLRxDI,QCh));
  LUTAddr11_2xD <= std_logic_vector(to_unsigned(LUTData21_2xD,QLLR)) & std_logic_vector(to_unsigned(ChLLRxDI,QCh));
  LUTAddr11_3xD <= std_logic_vector(to_unsigned(LUTData21_3xD,QLLR)) & std_logic_vector(to_unsigned(ChLLRxDI,QCh));
  LUTAddr11_4xD <= std_logic_vector(to_unsigned(LUTData21_4xD,QLLR)) & std_logic_vector(to_unsigned(ChLLRxDI,QCh));
  LUTAddr11_5xD <= std_logic_vector(to_unsigned(LUTData21_5xD,QLLR)) & std_logic_vector(to_unsigned(ChLLRxDI,QCh));

  -- LUT11 outputs
  IntLLrxDO(0) <= LUT11(to_integer(unsigned(LUTAddr11_0xD)));
  IntLLrxDO(1) <= LUT11(to_integer(unsigned(LUTAddr11_1xD)));
  IntLLrxDO(2) <= LUT11(to_integer(unsigned(LUTAddr11_2xD)));
  IntLLrxDO(3) <= LUT11(to_integer(unsigned(LUTAddr11_3xD)));
  IntLLrxDO(4) <= LUT11(to_integer(unsigned(LUTAddr11_4xD)));
  IntLLrxDO(5) <= LUT11(to_integer(unsigned(LUTAddr11_5xD)));

  -- LUT21 addresses
  LUTAddr21_0xD <= std_logic_vector(to_unsigned(IntLLRxDI(1),QLLR)) & std_logic_vector(to_unsigned(IntLLRxDI(2),QLLR)) & std_logic_vector(to_unsigned(IntLLRxDI(3),QLLR)) & std_logic_vector(to_unsigned(IntLLRxDI(4),QLLR)) & std_logic_vector(to_unsigned(IntLLRxDI(5),QLLR));
  LUTAddr21_1xD <= std_logic_vector(to_unsigned(IntLLRxDI(0),QLLR)) & std_logic_vector(to_unsigned(IntLLRxDI(2),QLLR)) & std_logic_vector(to_unsigned(IntLLRxDI(3),QLLR)) & std_logic_vector(to_unsigned(IntLLRxDI(4),QLLR)) & std_logic_vector(to_unsigned(IntLLRxDI(5),QLLR));
  LUTAddr21_2xD <= std_logic_vector(to_unsigned(IntLLRxDI(0),QLLR)) & std_logic_vector(to_unsigned(IntLLRxDI(1),QLLR)) & std_logic_vector(to_unsigned(IntLLRxDI(3),QLLR)) & std_logic_vector(to_unsigned(IntLLRxDI(4),QLLR)) & std_logic_vector(to_unsigned(IntLLRxDI(5),QLLR));
  LUTAddr21_3xD <= std_logic_vector(to_unsigned(IntLLRxDI(0),QLLR)) & std_logic_vector(to_unsigned(IntLLRxDI(1),QLLR)) & std_logic_vector(to_unsigned(IntLLRxDI(2),QLLR)) & std_logic_vector(to_unsigned(IntLLRxDI(4),QLLR)) & std_logic_vector(to_unsigned(IntLLRxDI(5),QLLR));
  LUTAddr21_4xD <= std_logic_vector(to_unsigned(IntLLRxDI(0),QLLR)) & std_logic_vector(to_unsigned(IntLLRxDI(1),QLLR)) & std_logic_vector(to_unsigned(IntLLRxDI(2),QLLR)) & std_logic_vector(to_unsigned(IntLLRxDI(3),QLLR)) & std_logic_vector(to_unsigned(IntLLRxDI(5),QLLR));
  LUTAddr21_5xD <= std_logic_vector(to_unsigned(IntLLRxDI(0),QLLR)) & std_logic_vector(to_unsigned(IntLLRxDI(1),QLLR)) & std_logic_vector(to_unsigned(IntLLRxDI(2),QLLR)) & std_logic_vector(to_unsigned(IntLLRxDI(3),QLLR)) & std_logic_vector(to_unsigned(IntLLRxDI(4),QLLR));                                                                                                                                                                                          

  -- LUT21 outputs
  LUTData21_0xD <= LUT21(to_integer(unsigned(LUTAddr21_0xD)));
  LUTData21_1xD <= LUT21(to_integer(unsigned(LUTAddr21_1xD)));
  LUTData21_2xD <= LUT21(to_integer(unsigned(LUTAddr21_2xD)));
  LUTData21_3xD <= LUT21(to_integer(unsigned(LUTAddr21_3xD)));
  LUTData21_4xD <= LUT21(to_integer(unsigned(LUTAddr21_4xD)));
  LUTData21_5xD <= LUT21(to_integer(unsigned(LUTAddr21_5xD)));
  
end arch;
