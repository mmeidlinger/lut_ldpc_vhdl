library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_misc.all;
library work;
use work.config.all;

entity CNodeTree is  
  port (
    IntLLRxDI : in  IntLLRTypeC;
    IntLLRxDO : out IntLLRTypeC
    );
end CNodeTree;

architecture arch of CNodeTree is

  component Min4
    port (
      Abs0xDI : in  IntAbsLLRSubType;
      Abs1xDI : in  IntAbsLLRSubType;
      Abs2xDI : in  IntAbsLLRSubType;
      Abs3xDI : in  IntAbsLLRSubType;
      Min0xDO : out IntAbsLLRSubType;
      Min1xDO : out IntAbsLLRSubType);
  end component;
  
  -- Signal for absolute values
  signal DataInxD               : IntAbsLLRTypeC;
  -- Signal to store all signs
  signal allSignsxD             : std_logic_vector(0 to CNodeDegree-1);
  -- Signal for product of signs
  signal allSignsProdxD         : std_logic;
  -- Minimum output
  signal MinxD                  : MinType;
  -- Bitonic sorter signals
  signal allIntLLRsxD						: TreeType;
  
begin

  -- Get absolute values and product of all signs
  get_abs_val_memless: process(IntLLRxDI,allSignsxD)
  begin
    for ii in 0 to CNodeDegree-1 loop
      DataInxD(ii) <= std_logic_vector(to_unsigned(IntLLRxDI(ii),QLLR)(QLLR-2 downto 0));
      allSignsxD(ii) <= to_unsigned(IntLLRxDI(ii),QLLR)(QLLR-1);
    end loop;  -- ii
    allSignsProdxD <= xor_reduce(allSignsxD);
  end process;

  -- Sorter tree
  sorter_tree_memless: process(DataInxD)
  begin
		-- Default assignment
		allIntLLRsxD(0) <= (others=>(others=>'1'));
    -- Sort input pairs
    for ii in 0 to CNodeDegree/2-1 loop
      if( DataInxD(2*ii+1) < DataInxD(2*ii) ) then
        allIntLLRsxD(0)(2*ii) <= DataInxD(2*ii+1);
        allIntLLRsxD(0)(2*ii+1) <= DataInxD(2*ii);
      else
        allIntLLRsxD(0)(2*ii) <= DataInxD(2*ii);
        allIntLLRsxD(0)(2*ii+1) <= DataInxD(2*ii+1);
      end if;
    end loop;  -- ii
  end process;

  gen_min4_ext: for ii in 1 to treeDepth-1 generate
    gen_min4_int: for jj in 0 to 2**(treeDepth-ii-1)-1 generate
      min4x: min4 port map(
        Abs0xDI=>allIntLLRsxD(ii-1)(4*jj),
        Abs1xDI=>allIntLLRsxD(ii-1)(4*jj+1),
        Abs2xDI=>allIntLLRsxD(ii-1)(4*jj+2),
        Abs3xDI=>allIntLLRsxD(ii-1)(4*jj+3),
        Min0xDO=>allIntLLRsxD(ii)(2*jj),
        Min1xDO=>allIntLLRsxD(ii)(2*jj+1)
        );
    end generate gen_min4_int;
  end generate gen_min4_ext;

  -- Get minima from last stage
  get_minima_memless: process(allIntLLRsxD)
  begin
    for ii in 0 to 1 loop
      MinxD(ii) <= allIntLLRsxD(treeDepth-1)(ii);
    end loop;
  end process;

  -- Assign output
  assign_output_memless: process(MinxD,DataInxD,allSignsProdxD,allSignsxD)
  begin
    for ii in 0 to CNodeDegree-1 loop
      if( DataInxD(ii) /= MinxD(0) ) then
        if( (allSignsProdxD xor allSignsxD(ii)) = '0' ) then
          IntLLRxDO(ii) <= to_integer(unsigned('0' & MinxD(0)));
        else
          IntLLRxDO(ii) <= to_integer(unsigned('1' & MinxD(0)));
        end if;
      else
        if( (allSignsProdxD xor allSignsxD(ii)) = '0' ) then
          IntLLRxDO(ii) <= to_integer(unsigned('0' & MinxD(1)));
        else
          IntLLRxDO(ii) <= to_integer(unsigned('1' & MinxD(1)));
        end if;
      end if;
    end loop;  -- ii
  end process;

  
  
end arch;
