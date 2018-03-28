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
constant QLLR : integer := 3;
constant QCh : integer := 4;

------ Variable Nodes -----
-- Variable node degree
constant VNodeDegree : integer := 6;

-- Channel LLR type
subtype ChLLRType is integer range 0 to 2**QCh-1;
type ChLLRTypeStage is array(0 to N-1) of ChLLRType;

-- Internal LLR type
subtype IntLLRSubType is integer range 0 to 2**QLLR-1;
type IntLLRTypeV is array (0 to VNodeDegree-1) of IntLLRSubType;

------ LUTs ------
constant LUTInputBits_4bit_to_3bit : integer := 4;
constant LUTSize_4bit_to_3bit : integer := 2**(LUTInputBits_4bit_to_3bit);
type LUTType_4bit_to_3bit is array (0 to LUTSize_4bit_to_3bit-1) of integer range 0 to 2**3-1;
constant LUT_4bit_to_3bit : LUTType_4bit_to_3bit :=(0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7);


constant LUTInputBitsL0_N0_S0 : integer := 7;
constant LUTSizeL0_N0_S0 : integer := 2**(LUTInputBitsL0_N0_S0);
type LUTTypeL0_N0_S0 is array (0 to LUTSizeL0_N0_S0-1) of integer range 0 to 2**3-1;
subtype LUTAddrL0_N0_S0 is std_logic_vector(0 to LUTInputBitsL0_N0_S0-1);
constant LUTL0_N0_S0 : LUTTypeL0_N0_S0 := (5,4,4,0,0,1,1,2,2,1,0,0,4,4,5,5,4,0,0,1,1,2,2,2,2,2,1,1,0,0,4,5,0,1,2,2,2,2,3,3,3,2,2,2,1,1,0,0,2,3,3,3,3,3,3,3,3,3,3,3,2,2,2,1,6,5,4,4,0,0,1,1,1,0,0,4,4,5,5,6,6,6,5,5,4,4,0,1,0,4,4,5,5,6,6,6,7,6,6,6,5,5,4,4,4,5,6,6,6,6,7,7,7,7,7,7,6,6,6,5,6,7,7,7,7,7,7,7);

constant LUTInputBitsL1_N0_S0 : integer := 6;
constant LUTSizeL1_N0_S0 : integer := 2**(LUTInputBitsL1_N0_S0);
type LUTTypeL1_N0_S0 is array (0 to LUTSizeL1_N0_S0-1) of integer range 0 to 2**3-1;
subtype LUTAddrL1_N0_S0 is std_logic_vector(0 to LUTInputBitsL1_N0_S0-1);
constant LUTL1_N0_S0 : LUTTypeL1_N0_S0 := (0,1,2,3,0,4,5,6,1,2,2,3,1,0,4,5,2,2,3,3,2,1,0,4,3,3,3,3,3,2,1,0,4,0,1,2,4,5,6,7,5,4,0,1,5,6,6,7,6,5,4,0,6,6,7,7,7,6,5,4,7,7,7,7);

constant LUTInputBitsL2_N0_S0 : integer := 6;
constant LUTSizeL2_N0_S0 : integer := 2**(LUTInputBitsL2_N0_S0);
type LUTTypeL2_N0_S0 is array (0 to LUTSizeL2_N0_S0-1) of integer range 0 to 2**3-1;
subtype LUTAddrL2_N0_S0 is std_logic_vector(0 to LUTInputBitsL2_N0_S0-1);
constant LUTL2_N0_S0 : LUTTypeL2_N0_S0 := (1,2,3,3,0,5,7,7,2,3,3,3,1,0,6,7,3,3,3,3,3,2,0,6,3,3,3,3,3,3,2,0,4,1,3,3,5,6,7,7,5,4,2,3,6,7,7,7,7,6,4,2,7,7,7,7,7,7,6,4,7,7,7,7);

constant LUTInputBitsL2_N1_S0 : integer := 6;
constant LUTSizeL2_N1_S0 : integer := 2**(LUTInputBitsL2_N1_S0);
type LUTTypeL2_N1_S0 is array (0 to LUTSizeL2_N1_S0-1) of integer range 0 to 2**3-1;
subtype LUTAddrL2_N1_S0 is std_logic_vector(0 to LUTInputBitsL2_N1_S0-1);
constant LUTL2_N1_S0 : LUTTypeL2_N1_S0 := (0,1,3,3,4,5,7,7,1,2,3,3,0,4,6,7,2,3,3,3,1,0,5,7,3,3,3,3,2,1,0,6,0,1,3,3,4,5,7,7,4,0,2,3,5,6,7,7,5,4,1,3,6,7,7,7,6,5,4,2,7,7,7,7);

constant LUTInputBitsL3_N0_S0 : integer := 6;
constant LUTSizeL3_N0_S0 : integer := 2**(LUTInputBitsL3_N0_S0);
type LUTTypeL3_N0_S0 is array (0 to LUTSizeL3_N0_S0-1) of integer range 0 to 2**3-1;
subtype LUTAddrL3_N0_S0 is std_logic_vector(0 to LUTInputBitsL3_N0_S0-1);
constant LUTL3_N0_S0 : LUTTypeL3_N0_S0 := (1,2,3,3,0,5,7,7,2,3,3,3,1,0,6,7,3,3,3,3,3,2,0,6,3,3,3,3,3,3,2,0,4,1,3,3,5,6,7,7,5,4,2,3,6,7,7,7,7,6,4,2,7,7,7,7,7,7,6,4,7,7,7,7);

constant LUTInputBitsL0_N0_S1 : integer := 7;
constant LUTSizeL0_N0_S1 : integer := 2**(LUTInputBitsL0_N0_S1);
type LUTTypeL0_N0_S1 is array (0 to LUTSizeL0_N0_S1-1) of integer range 0 to 2**3-1;
subtype LUTAddrL0_N0_S1 is std_logic_vector(0 to LUTInputBitsL0_N0_S1-1);
constant LUTL0_N0_S1 : LUTTypeL0_N0_S1 := (6,5,4,0,1,1,2,2,2,1,1,0,4,4,5,6,5,4,0,1,1,2,2,3,3,2,2,1,0,0,4,5,0,1,1,2,2,3,3,3,3,3,2,2,1,1,0,4,2,3,3,3,3,3,3,3,3,3,3,3,2,2,2,1,6,5,5,4,0,0,1,2,2,1,0,4,5,5,6,6,7,6,6,5,4,4,0,1,1,0,4,5,5,6,6,7,7,7,6,6,5,5,4,0,4,5,5,6,6,7,7,7,7,7,7,7,6,6,6,5,6,7,7,7,7,7,7,7);

constant LUTInputBitsL1_N0_S1 : integer := 6;
constant LUTSizeL1_N0_S1 : integer := 2**(LUTInputBitsL1_N0_S1);
type LUTTypeL1_N0_S1 is array (0 to LUTSizeL1_N0_S1-1) of integer range 0 to 2**3-1;
subtype LUTAddrL1_N0_S1 is std_logic_vector(0 to LUTInputBitsL1_N0_S1-1);
constant LUTL1_N0_S1 : LUTTypeL1_N0_S1 := (0,1,2,3,0,4,5,6,1,2,3,3,1,0,4,5,2,3,3,3,2,1,0,4,3,3,3,3,3,2,1,0,4,0,1,2,4,5,6,7,5,4,0,1,5,6,7,7,6,5,4,0,6,7,7,7,7,6,5,4,7,7,7,7);

constant LUTInputBitsL2_N0_S1 : integer := 6;
constant LUTSizeL2_N0_S1 : integer := 2**(LUTInputBitsL2_N0_S1);
type LUTTypeL2_N0_S1 is array (0 to LUTSizeL2_N0_S1-1) of integer range 0 to 2**3-1;
subtype LUTAddrL2_N0_S1 is std_logic_vector(0 to LUTInputBitsL2_N0_S1-1);
constant LUTL2_N0_S1 : LUTTypeL2_N0_S1 := (1,2,3,3,0,5,6,7,2,3,3,3,1,0,5,7,3,3,3,3,2,1,0,6,3,3,3,3,3,3,2,0,4,1,2,3,5,6,7,7,5,4,1,3,6,7,7,7,6,5,4,2,7,7,7,7,7,7,6,4,7,7,7,7);

constant LUTInputBitsL2_N1_S1 : integer := 6;
constant LUTSizeL2_N1_S1 : integer := 2**(LUTInputBitsL2_N1_S1);
type LUTTypeL2_N1_S1 is array (0 to LUTSizeL2_N1_S1-1) of integer range 0 to 2**3-1;
subtype LUTAddrL2_N1_S1 is std_logic_vector(0 to LUTInputBitsL2_N1_S1-1);
constant LUTL2_N1_S1 : LUTTypeL2_N1_S1 := (0,1,2,3,4,5,6,7,1,2,3,3,0,4,5,7,2,3,3,3,1,0,4,6,3,3,3,3,2,1,0,5,0,1,2,3,4,5,6,7,4,0,1,3,5,6,7,7,5,4,0,2,6,7,7,7,6,5,4,1,7,7,7,7);

constant LUTInputBitsL3_N0_S1 : integer := 6;
constant LUTSizeL3_N0_S1 : integer := 2**(LUTInputBitsL3_N0_S1);
type LUTTypeL3_N0_S1 is array (0 to LUTSizeL3_N0_S1-1) of integer range 0 to 2**3-1;
subtype LUTAddrL3_N0_S1 is std_logic_vector(0 to LUTInputBitsL3_N0_S1-1);
constant LUTL3_N0_S1 : LUTTypeL3_N0_S1 := (1,2,3,3,0,5,6,7,2,3,3,3,1,0,5,7,3,3,3,3,2,1,0,6,3,3,3,3,3,3,2,0,4,1,2,3,5,6,7,7,5,4,1,3,6,7,7,7,6,5,4,2,7,7,7,7,7,7,6,4,7,7,7,7);

constant LUTInputBitsL0_N0_S2 : integer := 7;
constant LUTSizeL0_N0_S2 : integer := 2**(LUTInputBitsL0_N0_S2);
type LUTTypeL0_N0_S2 is array (0 to LUTSizeL0_N0_S2-1) of integer range 0 to 2**3-1;
subtype LUTAddrL0_N0_S2 is std_logic_vector(0 to LUTInputBitsL0_N0_S2-1);
constant LUTL0_N0_S2 : LUTTypeL0_N0_S2 := (6,5,4,0,0,1,2,3,2,1,1,0,4,4,5,6,5,4,0,1,1,2,2,3,3,2,1,1,0,4,4,6,4,0,1,2,2,2,3,3,3,3,2,2,1,0,0,5,1,2,3,3,3,3,3,3,3,3,3,3,2,2,1,0,6,5,5,4,0,0,1,2,2,1,0,4,4,5,6,7,7,6,5,5,4,0,0,2,1,0,4,5,5,6,6,7,7,7,6,6,5,4,4,1,0,4,5,6,6,6,7,7,7,7,7,7,6,6,5,4,5,6,7,7,7,7,7,7);

constant LUTInputBitsL1_N0_S2 : integer := 6;
constant LUTSizeL1_N0_S2 : integer := 2**(LUTInputBitsL1_N0_S2);
type LUTTypeL1_N0_S2 is array (0 to LUTSizeL1_N0_S2-1) of integer range 0 to 2**3-1;
subtype LUTAddrL1_N0_S2 is std_logic_vector(0 to LUTInputBitsL1_N0_S2-1);
constant LUTL1_N0_S2 : LUTTypeL1_N0_S2 := (0,1,2,3,0,4,5,6,1,2,2,3,1,0,4,5,2,2,3,3,2,1,0,4,3,3,3,3,3,2,2,0,4,0,1,2,4,5,6,7,5,4,0,1,5,6,6,7,6,5,4,0,6,6,7,7,7,6,6,4,7,7,7,7);

constant LUTInputBitsL2_N0_S2 : integer := 6;
constant LUTSizeL2_N0_S2 : integer := 2**(LUTInputBitsL2_N0_S2);
type LUTTypeL2_N0_S2 is array (0 to LUTSizeL2_N0_S2-1) of integer range 0 to 2**3-1;
subtype LUTAddrL2_N0_S2 is std_logic_vector(0 to LUTInputBitsL2_N0_S2-1);
constant LUTL2_N0_S2 : LUTTypeL2_N0_S2 := (1,2,3,3,0,5,6,7,2,3,3,3,1,0,5,7,3,3,3,3,2,1,0,6,3,3,3,3,3,3,2,0,4,1,2,3,5,6,7,7,5,4,1,3,6,7,7,7,6,5,4,2,7,7,7,7,7,7,6,4,7,7,7,7);

constant LUTInputBitsL2_N1_S2 : integer := 6;
constant LUTSizeL2_N1_S2 : integer := 2**(LUTInputBitsL2_N1_S2);
type LUTTypeL2_N1_S2 is array (0 to LUTSizeL2_N1_S2-1) of integer range 0 to 2**3-1;
subtype LUTAddrL2_N1_S2 is std_logic_vector(0 to LUTInputBitsL2_N1_S2-1);
constant LUTL2_N1_S2 : LUTTypeL2_N1_S2 := (0,1,2,3,4,5,6,7,1,2,3,3,0,4,5,7,2,3,3,3,1,0,4,6,3,3,3,3,2,2,0,4,0,1,2,3,4,5,6,7,4,0,1,3,5,6,7,7,5,4,0,2,6,7,7,7,6,6,4,0,7,7,7,7);

constant LUTInputBitsL3_N0_S2 : integer := 6;
constant LUTSizeL3_N0_S2 : integer := 2**(LUTInputBitsL3_N0_S2);
type LUTTypeL3_N0_S2 is array (0 to LUTSizeL3_N0_S2-1) of integer range 0 to 2**3-1;
subtype LUTAddrL3_N0_S2 is std_logic_vector(0 to LUTInputBitsL3_N0_S2-1);
constant LUTL3_N0_S2 : LUTTypeL3_N0_S2 := (1,2,3,3,0,5,6,7,2,3,3,3,1,0,5,7,3,3,3,3,2,1,0,6,3,3,3,3,3,3,2,0,4,1,2,3,5,6,7,7,5,4,1,3,6,7,7,7,6,5,4,2,7,7,7,7,7,7,6,4,7,7,7,7);

constant LUTInputBitsL0_N0_S3 : integer := 7;
constant LUTSizeL0_N0_S3 : integer := 2**(LUTInputBitsL0_N0_S3);
type LUTTypeL0_N0_S3 is array (0 to LUTSizeL0_N0_S3-1) of integer range 0 to 2**3-1;
subtype LUTAddrL0_N0_S3 is std_logic_vector(0 to LUTInputBitsL0_N0_S3-1);
constant LUTL0_N0_S3 : LUTTypeL0_N0_S3 := (7,5,4,4,1,1,2,3,3,2,1,0,4,5,6,7,6,5,4,0,1,2,2,3,3,2,2,1,0,4,5,6,6,4,1,1,2,2,3,3,3,3,2,2,1,0,4,6,0,2,2,3,3,3,3,3,3,3,3,2,2,1,0,5,7,6,5,4,0,1,2,3,3,1,0,0,5,5,6,7,7,6,6,5,4,0,1,2,2,1,0,4,5,6,6,7,7,7,6,6,5,4,0,2,2,0,5,5,6,6,7,7,7,7,7,6,6,5,4,1,4,6,6,7,7,7,7,7);

constant LUTInputBitsL1_N0_S3 : integer := 6;
constant LUTSizeL1_N0_S3 : integer := 2**(LUTInputBitsL1_N0_S3);
type LUTTypeL1_N0_S3 is array (0 to LUTSizeL1_N0_S3-1) of integer range 0 to 2**3-1;
subtype LUTAddrL1_N0_S3 is std_logic_vector(0 to LUTInputBitsL1_N0_S3-1);
constant LUTL1_N0_S3 : LUTTypeL1_N0_S3 := (0,1,2,3,0,4,5,6,1,2,2,3,1,0,4,5,2,2,3,3,2,1,0,4,3,3,3,3,3,2,2,0,4,0,1,2,4,5,6,7,5,4,0,1,5,6,6,7,6,5,4,0,6,6,7,7,7,6,6,4,7,7,7,7);

constant LUTInputBitsL2_N0_S3 : integer := 6;
constant LUTSizeL2_N0_S3 : integer := 2**(LUTInputBitsL2_N0_S3);
type LUTTypeL2_N0_S3 is array (0 to LUTSizeL2_N0_S3-1) of integer range 0 to 2**3-1;
subtype LUTAddrL2_N0_S3 is std_logic_vector(0 to LUTInputBitsL2_N0_S3-1);
constant LUTL2_N0_S3 : LUTTypeL2_N0_S3 := (1,2,3,3,0,5,6,7,2,3,3,3,1,0,5,6,3,3,3,3,2,1,0,5,3,3,3,3,3,2,1,0,4,1,2,3,5,6,7,7,5,4,1,2,6,7,7,7,6,5,4,1,7,7,7,7,7,6,5,4,7,7,7,7);

constant LUTInputBitsL2_N1_S3 : integer := 6;
constant LUTSizeL2_N1_S3 : integer := 2**(LUTInputBitsL2_N1_S3);
type LUTTypeL2_N1_S3 is array (0 to LUTSizeL2_N1_S3-1) of integer range 0 to 2**3-1;
subtype LUTAddrL2_N1_S3 is std_logic_vector(0 to LUTInputBitsL2_N1_S3-1);
constant LUTL2_N1_S3 : LUTTypeL2_N1_S3 := (0,1,2,3,4,5,6,7,1,2,3,3,0,4,5,6,2,3,3,3,1,0,4,5,3,3,3,3,2,2,1,4,0,1,2,3,4,5,6,7,4,0,1,2,5,6,7,7,5,4,0,1,6,7,7,7,6,6,5,0,7,7,7,7);

constant LUTInputBitsL3_N0_S3 : integer := 6;
constant LUTSizeL3_N0_S3 : integer := 2**(LUTInputBitsL3_N0_S3);
type LUTTypeL3_N0_S3 is array (0 to LUTSizeL3_N0_S3-1) of integer range 0 to 2**3-1;
subtype LUTAddrL3_N0_S3 is std_logic_vector(0 to LUTInputBitsL3_N0_S3-1);
constant LUTL3_N0_S3 : LUTTypeL3_N0_S3 := (1,2,3,3,0,5,6,7,2,3,3,3,1,0,5,6,3,3,3,3,2,1,0,5,3,3,3,3,3,2,1,0,4,1,2,3,5,6,7,7,5,4,1,2,6,7,7,7,6,5,4,1,7,7,7,7,7,6,5,4,7,7,7,7);

constant LUTInputBitsL0_N0_S4 : integer := 7;
constant LUTSizeL0_N0_S4 : integer := 2**(LUTInputBitsL0_N0_S4);
type LUTTypeL0_N0_S4 is array (0 to LUTSizeL0_N0_S4-1) of integer range 0 to 2**3-1;
subtype LUTAddrL0_N0_S4 is std_logic_vector(0 to LUTInputBitsL0_N0_S4-1);
constant LUTL0_N0_S4 : LUTTypeL0_N0_S4 := (7,6,4,4,1,1,2,3,3,2,1,0,4,5,6,7,7,5,4,0,1,2,2,3,3,2,1,1,0,4,5,7,7,4,1,1,2,2,3,3,3,2,2,1,1,0,5,7,6,1,2,2,3,3,3,3,3,3,2,2,2,1,4,6,7,6,5,4,0,1,2,3,3,2,0,0,5,5,6,7,7,6,5,5,4,0,1,3,3,1,0,4,5,6,6,7,7,6,6,5,5,4,1,3,3,0,5,5,6,6,7,7,7,7,6,6,6,5,0,2,2,5,6,6,7,7,7,7);

constant LUTInputBitsL1_N0_S4 : integer := 6;
constant LUTSizeL1_N0_S4 : integer := 2**(LUTInputBitsL1_N0_S4);
type LUTTypeL1_N0_S4 is array (0 to LUTSizeL1_N0_S4-1) of integer range 0 to 2**3-1;
subtype LUTAddrL1_N0_S4 is std_logic_vector(0 to LUTInputBitsL1_N0_S4-1);
constant LUTL1_N0_S4 : LUTTypeL1_N0_S4 := (0,1,2,3,0,5,6,7,1,2,2,3,1,0,5,6,2,2,3,3,2,1,0,6,3,3,3,3,3,3,2,0,4,1,2,3,4,5,6,7,5,4,1,2,5,6,6,7,6,5,4,2,6,6,7,7,7,7,6,4,7,7,7,7);

constant LUTInputBitsL2_N0_S4 : integer := 6;
constant LUTSizeL2_N0_S4 : integer := 2**(LUTInputBitsL2_N0_S4);
type LUTTypeL2_N0_S4 is array (0 to LUTSizeL2_N0_S4-1) of integer range 0 to 2**3-1;
subtype LUTAddrL2_N0_S4 is std_logic_vector(0 to LUTInputBitsL2_N0_S4-1);
constant LUTL2_N0_S4 : LUTTypeL2_N0_S4 := (1,2,2,3,0,5,6,7,2,2,3,3,1,0,5,6,2,3,3,3,2,1,0,5,3,3,3,3,3,2,1,0,4,1,2,3,5,6,6,7,5,4,1,2,6,6,7,7,6,5,4,1,6,7,7,7,7,6,5,4,7,7,7,7);

constant LUTInputBitsL2_N1_S4 : integer := 6;
constant LUTSizeL2_N1_S4 : integer := 2**(LUTInputBitsL2_N1_S4);
type LUTTypeL2_N1_S4 is array (0 to LUTSizeL2_N1_S4-1) of integer range 0 to 2**3-1;
subtype LUTAddrL2_N1_S4 is std_logic_vector(0 to LUTInputBitsL2_N1_S4-1);
constant LUTL2_N1_S4 : LUTTypeL2_N1_S4 := (0,1,2,3,4,5,6,7,1,2,3,3,1,4,5,6,2,3,3,3,2,1,4,5,3,3,3,3,3,3,2,1,0,1,2,3,4,5,6,7,5,0,1,2,5,6,7,7,6,5,0,1,6,7,7,7,7,7,6,5,7,7,7,7);

constant LUTInputBitsL3_N0_S4 : integer := 6;
constant LUTSizeL3_N0_S4 : integer := 2**(LUTInputBitsL3_N0_S4);
type LUTTypeL3_N0_S4 is array (0 to LUTSizeL3_N0_S4-1) of integer range 0 to 2**3-1;
subtype LUTAddrL3_N0_S4 is std_logic_vector(0 to LUTInputBitsL3_N0_S4-1);
constant LUTL3_N0_S4 : LUTTypeL3_N0_S4 := (1,2,2,3,0,5,6,7,2,2,3,3,1,0,5,6,2,3,3,3,2,1,0,5,3,3,3,3,3,2,1,0,4,1,2,3,5,6,6,7,5,4,1,2,6,6,7,7,6,5,4,1,6,7,7,7,7,6,5,4,7,7,7,7);

constant LUTInputBitsL0_N0_S5 : integer := 7;
constant LUTSizeL0_N0_S5 : integer := 2**(LUTInputBitsL0_N0_S5);
type LUTTypeL0_N0_S5 is array (0 to LUTSizeL0_N0_S5-1) of integer range 0 to 2**3-1;
subtype LUTAddrL0_N0_S5 is std_logic_vector(0 to LUTInputBitsL0_N0_S5-1);
constant LUTL0_N0_S5 : LUTTypeL0_N0_S5 := (7,7,6,5,1,2,3,3,3,3,2,1,5,6,7,7,7,7,5,4,2,2,3,3,3,3,2,1,4,6,7,7,7,6,5,1,2,3,3,3,3,3,2,2,0,5,6,7,7,5,1,2,3,3,3,3,3,3,3,2,1,4,6,7,7,7,6,5,1,2,3,3,3,3,2,1,5,6,7,7,7,7,6,5,0,2,3,3,3,3,1,0,6,6,7,7,7,7,6,6,4,1,2,3,3,2,1,5,6,7,7,7,7,7,7,6,5,0,2,3,3,1,5,6,7,7,7,7);

constant LUTInputBitsL1_N0_S5 : integer := 6;
constant LUTSizeL1_N0_S5 : integer := 2**(LUTInputBitsL1_N0_S5);
type LUTTypeL1_N0_S5 is array (0 to LUTSizeL1_N0_S5-1) of integer range 0 to 2**3-1;
subtype LUTAddrL1_N0_S5 is std_logic_vector(0 to LUTInputBitsL1_N0_S5-1);
constant LUTL1_N0_S5 : LUTTypeL1_N0_S5 := (0,1,2,3,0,4,5,7,1,2,3,3,1,0,4,6,2,3,3,3,2,1,0,5,3,3,3,3,3,3,3,1,4,0,1,3,4,5,6,7,5,4,0,2,5,6,7,7,6,5,4,1,6,7,7,7,7,7,7,5,7,7,7,7);

constant LUTInputBitsL2_N0_S5 : integer := 6;
constant LUTSizeL2_N0_S5 : integer := 2**(LUTInputBitsL2_N0_S5);
type LUTTypeL2_N0_S5 is array (0 to LUTSizeL2_N0_S5-1) of integer range 0 to 2**3-1;
subtype LUTAddrL2_N0_S5 is std_logic_vector(0 to LUTInputBitsL2_N0_S5-1);
constant LUTL2_N0_S5 : LUTTypeL2_N0_S5 := (0,1,2,3,0,5,5,6,1,1,2,3,1,0,5,6,2,2,3,3,1,1,0,5,3,3,3,3,2,2,1,0,4,1,1,2,4,5,6,7,5,4,1,2,5,5,6,7,5,5,4,1,6,6,7,7,6,6,5,4,7,7,7,7);

constant LUTInputBitsL2_N1_S5 : integer := 6;
constant LUTSizeL2_N1_S5 : integer := 2**(LUTInputBitsL2_N1_S5);
type LUTTypeL2_N1_S5 is array (0 to LUTSizeL2_N1_S5-1) of integer range 0 to 2**3-1;
subtype LUTAddrL2_N1_S5 is std_logic_vector(0 to LUTInputBitsL2_N1_S5-1);
constant LUTL2_N1_S5 : LUTTypeL2_N1_S5 := (0,0,1,2,4,4,5,6,1,1,2,3,1,0,4,5,2,2,3,3,1,1,0,4,3,3,3,3,3,3,2,1,0,0,1,2,4,4,5,6,5,4,0,1,5,5,6,7,5,5,4,0,6,6,7,7,7,7,6,5,7,7,7,7);

constant LUTInputBitsL3_N0_S5 : integer := 6;
constant LUTSizeL3_N0_S5 : integer := 2**(LUTInputBitsL3_N0_S5);
type LUTTypeL3_N0_S5 is array (0 to LUTSizeL3_N0_S5-1) of integer range 0 to 2**3-1;
subtype LUTAddrL3_N0_S5 is std_logic_vector(0 to LUTInputBitsL3_N0_S5-1);
constant LUTL3_N0_S5 : LUTTypeL3_N0_S5 := (0,1,2,3,0,5,5,6,1,1,2,3,1,0,5,6,2,2,3,3,1,1,0,5,3,3,3,3,2,2,1,0,4,1,1,2,4,5,6,7,5,4,1,2,5,5,6,7,5,5,4,1,6,6,7,7,6,6,5,4,7,7,7,7);

constant LUTInputBitsL0_N0_S6 : integer := 7;
constant LUTSizeL0_N0_S6 : integer := 2**(LUTInputBitsL0_N0_S6);
type LUTTypeL0_N0_S6 is array (0 to LUTSizeL0_N0_S6-1) of integer range 0 to 2**3-1;
subtype LUTAddrL0_N0_S6 is std_logic_vector(0 to LUTInputBitsL0_N0_S6-1);
constant LUTL0_N0_S6 : LUTTypeL0_N0_S6 := (6,5,5,1,1,1,1,3,3,1,1,1,1,5,5,6,6,4,1,1,1,1,1,3,3,1,1,1,1,1,5,6,6,1,1,1,1,1,1,3,3,1,1,1,1,1,1,6,5,1,1,1,1,1,1,3,3,1,1,1,1,1,1,5,7,5,5,5,5,1,1,2,2,1,1,5,5,5,5,7,7,5,5,5,5,5,1,2,2,0,5,5,5,5,5,7,7,5,5,5,5,5,5,2,2,5,5,5,5,5,5,7,7,5,5,5,5,5,5,1,1,5,5,5,5,5,5,7);

constant LUTInputBitsL1_N0_S6 : integer := 6;
constant LUTSizeL1_N0_S6 : integer := 2**(LUTInputBitsL1_N0_S6);
type LUTTypeL1_N0_S6 is array (0 to LUTSizeL1_N0_S6-1) of integer range 0 to 2**3-1;
subtype LUTAddrL1_N0_S6 is std_logic_vector(0 to LUTInputBitsL1_N0_S6-1);
constant LUTL1_N0_S6 : LUTTypeL1_N0_S6 := (2,3,3,3,2,1,0,7,3,3,3,3,3,3,3,7,3,3,3,3,3,3,3,7,3,3,3,3,3,3,3,3,6,5,4,3,6,7,7,7,7,7,7,3,7,7,7,7,7,7,7,3,7,7,7,7,7,7,7,7,7,7,7,7);

constant LUTInputBitsL2_N0_S6 : integer := 6;
constant LUTSizeL2_N0_S6 : integer := 2**(LUTInputBitsL2_N0_S6);
type LUTTypeL2_N0_S6 is array (0 to LUTSizeL2_N0_S6-1) of integer range 0 to 2**3-1;
subtype LUTAddrL2_N0_S6 is std_logic_vector(0 to LUTInputBitsL2_N0_S6-1);
constant LUTL2_N0_S6 : LUTTypeL2_N0_S6 := (1,3,3,3,0,6,7,7,3,3,3,3,2,0,7,7,3,3,3,3,3,3,0,7,3,3,3,3,3,3,3,0,4,2,3,3,5,7,7,7,6,4,3,3,7,7,7,7,7,7,4,3,7,7,7,7,7,7,7,4,7,7,7,7);

constant LUTInputBitsL2_N1_S6 : integer := 6;
constant LUTSizeL2_N1_S6 : integer := 2**(LUTInputBitsL2_N1_S6);
type LUTTypeL2_N1_S6 is array (0 to LUTSizeL2_N1_S6-1) of integer range 0 to 2**3-1;
subtype LUTAddrL2_N1_S6 is std_logic_vector(0 to LUTInputBitsL2_N1_S6-1);
constant LUTL2_N1_S6 : LUTTypeL2_N1_S6 := (0,0,1,2,4,4,5,6,0,1,1,2,0,4,5,6,1,1,1,2,0,4,5,6,3,3,3,3,3,3,2,1,0,0,1,2,4,4,5,6,4,0,1,2,4,5,5,6,4,0,1,2,5,5,5,6,7,7,6,5,7,7,7,7);

constant LUTInputBitsL3_N0_S6 : integer := 6;
constant LUTSizeL3_N0_S6 : integer := 2**(LUTInputBitsL3_N0_S6);
type LUTTypeL3_N0_S6 is array (0 to LUTSizeL3_N0_S6-1) of integer range 0 to 2**3-1;
subtype LUTAddrL3_N0_S6 is std_logic_vector(0 to LUTInputBitsL3_N0_S6-1);
constant LUTL3_N0_S6 : LUTTypeL3_N0_S6 := (1,3,3,3,0,6,7,7,3,3,3,3,2,0,7,7,3,3,3,3,3,3,0,7,3,3,3,3,3,3,3,0,4,2,3,3,5,7,7,7,6,4,3,3,7,7,7,7,7,7,4,3,7,7,7,7,7,7,7,4,7,7,7,7);

constant LUTInputBitsL0_N0_S7 : integer := 7;
constant LUTSizeL0_N0_S7 : integer := 2**(LUTInputBitsL0_N0_S7);
type LUTTypeL0_N0_S7 is array (0 to LUTSizeL0_N0_S7-1) of integer range 0 to 2**1-1;
subtype LUTAddrL0_N0_S7 is std_logic_vector(0 to LUTInputBitsL0_N0_S7-1);
constant LUTL0_N0_S7 : LUTTypeL0_N0_S7 := (0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,1,0,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1);

constant LUTInputBitsL1_N0_S7 : integer := 6;
constant LUTSizeL1_N0_S7 : integer := 2**(LUTInputBitsL1_N0_S7);
type LUTTypeL1_N0_S7 is array (0 to LUTSizeL1_N0_S7-1) of integer range 0 to 2**3-1;
subtype LUTAddrL1_N0_S7 is std_logic_vector(0 to LUTInputBitsL1_N0_S7-1);
constant LUTL1_N0_S7 : LUTTypeL1_N0_S7 := (0,2,3,3,0,6,7,7,1,3,3,3,1,0,7,7,3,3,3,3,3,1,7,7,3,3,3,3,3,3,0,0,4,2,3,3,4,6,7,7,5,4,3,3,5,7,7,7,7,5,3,3,7,7,7,7,7,7,4,4,7,7,7,7);

constant LUTInputBitsL2_N0_S7 : integer := 6;
constant LUTSizeL2_N0_S7 : integer := 2**(LUTInputBitsL2_N0_S7);
type LUTTypeL2_N0_S7 is array (0 to LUTSizeL2_N0_S7-1) of integer range 0 to 2**3-1;
subtype LUTAddrL2_N0_S7 is std_logic_vector(0 to LUTInputBitsL2_N0_S7-1);
constant LUTL2_N0_S7 : LUTTypeL2_N0_S7 := (1,3,3,3,0,6,7,7,3,3,3,3,3,0,0,0,3,3,3,3,3,0,0,0,3,3,3,3,3,0,0,0,4,2,3,3,5,7,7,7,7,4,4,4,7,7,7,7,7,4,4,4,7,7,7,7,7,4,4,4,7,7,7,7);

constant LUTInputBitsL2_N1_S7 : integer := 6;
constant LUTSizeL2_N1_S7 : integer := 2**(LUTInputBitsL2_N1_S7);
type LUTTypeL2_N1_S7 is array (0 to LUTSizeL2_N1_S7-1) of integer range 0 to 2**3-1;
subtype LUTAddrL2_N1_S7 is std_logic_vector(0 to LUTInputBitsL2_N1_S7-1);
constant LUTL2_N1_S7 : LUTTypeL2_N1_S7 := (0,1,3,3,0,5,7,7,1,2,3,3,1,0,7,7,3,3,3,3,3,3,0,0,3,3,3,3,3,3,0,0,4,1,3,3,4,5,7,7,5,4,3,3,5,6,7,7,7,7,4,4,7,7,7,7,7,7,4,4,7,7,7,7);

constant LUTInputBitsL3_N0_S7 : integer := 6;
constant LUTSizeL3_N0_S7 : integer := 2**(LUTInputBitsL3_N0_S7);
type LUTTypeL3_N0_S7 is array (0 to LUTSizeL3_N0_S7-1) of integer range 0 to 2**3-1;
subtype LUTAddrL3_N0_S7 is std_logic_vector(0 to LUTInputBitsL3_N0_S7-1);
constant LUTL3_N0_S7 : LUTTypeL3_N0_S7 := (1,3,3,3,0,6,7,7,3,3,3,3,3,0,0,0,3,3,3,3,3,0,0,0,3,3,3,3,3,0,0,0,4,2,3,3,5,7,7,7,7,4,4,4,7,7,7,7,7,4,4,4,7,7,7,7,7,4,4,4,7,7,7,7);

constant LUTInputBitsL3_N1_S7 : integer := 6;
constant LUTSizeL3_N1_S7 : integer := 2**(LUTInputBitsL3_N1_S7);
type LUTTypeL3_N1_S7 is array (0 to LUTSizeL3_N1_S7-1) of integer range 0 to 2**3-1;
subtype LUTAddrL3_N1_S7 is std_logic_vector(0 to LUTInputBitsL3_N1_S7-1);
constant LUTL3_N1_S7 : LUTTypeL3_N1_S7 := (1,3,3,3,0,6,7,7,3,3,3,3,3,0,0,0,3,3,3,3,3,0,0,0,3,3,3,3,3,0,0,0,4,2,3,3,5,7,7,7,7,4,4,4,7,7,7,7,7,4,4,4,7,7,7,7,7,4,4,4,7,7,7,7);

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