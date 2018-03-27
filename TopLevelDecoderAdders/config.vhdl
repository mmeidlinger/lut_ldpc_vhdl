library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
library work;

package config is

-- Number of variable nodes
constant N : integer := 2048;

-- Number of check nodes
constant M : integer := 384;

-- LLR bit-widths
constant QLLR : integer := 5;
constant QCh : integer := 5;

------ Variable Nodes -----
-- Variable node degree
constant VNodeDegree : integer := 6;

-- Channel LLR type
subtype ChLLRType is signed (QLLR-1 downto 0);
type ChLLRTypeStage is array(0 to N-1) of ChLLRType;

-- Internal LLR type
subtype IntLLRSubType is signed (QLLR-1 downto 0);
type IntLLRTypeV is array (0 to VNodeDegree-1) of IntLLRSubType;

-- Adder tree depth
constant VNodetreeDepth : integer := integer(ceil(log2(real(VNodeDegree+1)))) + 1;
constant VNodetreeNodes : integer := 2**VNodetreeDepth-1;
constant VNodenoLeaves : integer := 2**(VNodetreeDepth-1);

constant QLLRInternal : integer := QLLR+VNodetreeDepth-1;
subtype LLRInternalType is signed (QLLRInternal-1 downto 0);

-- Vector holding tree structure;
type ExtendedInputType is array (0 to VNodenoLeaves-1) of LLRInternalType;
type VNodeTreeLevelType is array (0 to VNodenoLeaves-1) of LLRInternalType;
type VNodeTreeType is array (0 to VNodetreeDepth-1) of VNodeTreeLevelType;

------ Check Nodes ------ 
-- Check node degree
constant CNodeDegree : integer := 32;
constant CNodeDegreeLog : integer := integer(log2(real(CNodeDegree)));

-- Comparator tree depth
constant treeDepth : integer := integer(ceil(log2(real(CNodeDegree/2)))) + 1;
constant noLeaves : integer := 2**treeDepth;
-- Internal LLR
type IntLLRTypeC is array (0 to CNodeDegree-1) of IntLLRSubType;

-- Absolute values of internal LLRs
subtype IntAbsLLRSubType is std_logic_vector(QLLR-2 downto 0);
type IntAbsLLRTypeC is array (0 to CNodeDegree-1) of IntAbsLLRSubType;

-- Minimum output type
type MinType is array (0 to 1) of std_logic_vector(QLLR-2 downto 0);

-- Sorter tree types
type TreeLevelType is array (0 to noLeaves-1) of IntAbsLLRSubType;
type TreeType is array (0 to treeDepth-1) of TreeLevelType;

------ Check node stage ------
-- Check node stage input signal
type IntLLRTypeCNStage is array(0 to M-1) of IntLLRTypeC;

------ Variable node stage ------
-- Variable node stage input signal
type IntLLRTypeVNStage is array(0 to N-1) of IntLLRTypeV;

function to_std_logic(i : in integer range 0 to 1) return std_logic;

end config;

package body config is

  function to_std_logic(i : in integer range 0 to 1) return std_logic is
  begin
  if i = 0 then
      return '0';
  end if;
  return '1';
  end function;

end config;