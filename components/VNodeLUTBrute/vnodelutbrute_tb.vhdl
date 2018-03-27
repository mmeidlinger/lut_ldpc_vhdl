library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
use work.config.all;

entity VNodeLUTBrute_TB is
  
  port (
    ChLLRxDI  : in  ChLLRType;
    IntLLRxDI  : in  IntLLRType;
    OutLLRxDO : out IntLLRType
    );
end VNodeLUTBrute_TB;

architecture tb of VNodeLUTBrute_TB is
  
component VNodeLUTBrute is
    port (
    ChLLRxDI  : in  ChLLRType;
    IntLLRxDI : in  IntLLRType;
    OutLLRxDO : out IntLLRType
    );
end component;

signal ChLLRxD : ChLLRType;
signal IntLLRxD : IntLLRType;
signal OutLLRxD : IntLLRType;

begin  -- tb

vn1 : VNodeLutBrute port map (
  ChLLRxDI => ChLLRxD,
  IntLLrxDI => IntLLRxD,
  OutLLRxDO => OutLLRxD
  );

proc_tb: process
begin  -- process

  ChLLRxD <= 0;
  IntLLRxD(0) <= 0;
  IntLLRxD(1) <= 0;
  IntLLRxD(2) <= 0;

  wait for 10 ns;

  ChLLRxD <= 1;
  IntLLRxD(0) <= 0;
  IntLLRxD(1) <= 0;
  IntLLRxD(2) <= 0;

  wait for 10 ns;

  ChLLRxD <= 2;
  IntLLRxD(0) <= 1;
  IntLLRxD(1) <= 3;
  IntLLRxD(2) <= 4;

  wait for 10 ns;
  
end process;
  
end tb;
