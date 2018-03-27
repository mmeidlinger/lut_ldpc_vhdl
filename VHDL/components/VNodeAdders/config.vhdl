library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
library work;

package config is

  -- Variable node degree
  constant degree : integer := 6;

  -- Adder tree depth
  constant treeDepth : integer := integer(ceil(log2(real(degree+1)))) + 1;
  constant treeNodes : integer := 2**treeDepth-1;
  constant noLeaves : integer := 2**(treeDepth-1);                                  

  -- Number of input LLR quantization bits
  constant QLLR : integer := 5;
  subtype LLRInType is signed (QLLR-1 downto 0);

  -- Number of internal LLR quantization bits
  constant QLLRInternal : integer := QLLR+treeDepth-1;
  subtype LLRInternalType is signed (QLLRInternal-1 downto 0);

  -- Input vector  
  type CVType is array (0 to degree-1) of LLRInType;

  -- Vector holding tree structure
  type ExtendedInputType is array (0 to noLeaves-1) of LLRInternalType;
  type TreeLevelType is array (0 to noLeaves-1) of LLRInternalType;
  type TreeType is array (0 to treeDepth-1) of TreeLevelType;

end config;

package body config is

end config;
