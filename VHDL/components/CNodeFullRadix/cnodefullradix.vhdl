library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
use work.config.all;

entity CNodeFullRadix is
  
  port (
    IntLLRxDI : in  IntLLRTypeC;
    IntLLRxDO : out IntLLRTypeC
    );
end CNodeFullRadix;

architecture arch of CNodeFullRadix is


  -- One hot encoding for each minimum
  signal minOneHotxD		: OneHotType;
  -- Matrix holding comparator results
  signal compxD			: CompType;
  -- Signal for absolute values
  signal DataInxD               : IntAbsLLRTypeC;
  -- Minimum output
  signal MinxD                  : MinType;

begin

  -- Get absolute values
  get_abs_val_memless: process(IntLLRxDI)
    variable tempVal : unsigned(QLLR-1 downto 0);
  begin
    for ii in 0 to CNodeDegree-1 loop
      tempVal := to_unsigned(IntLLRxDI(ii),QLLR);
      DataInxD(ii) <= std_logic_vector(tempVal(QLLR-2 downto 0));
    end loop;  -- ii
  end process;
  
  -- Compare all inputs with all inputs
  comp_all_memless: process(DataInxD)
  begin

    -- Default assignment
    compxD <= (others=>(others=>'0'));
    for ii in 0 to CNodeDegree-1 loop
      for jj in ii+1 to CNodeDegree-1 loop
        if( DataInxD(ii) <= DataInxD(jj) ) then
          compxD(ii)(jj) <= '1';
          compxD(jj)(ii) <= '0';
        else
          compxD(ii)(jj) <= '0';
          compxD(jj)(ii) <= '1';
        end if;
      end loop;
    end loop;
    
  end process;

  find_min_memless: process(DataInxD, minOneHotxD, compxD)

    variable tempComp		: std_logic;
    variable maskVec, extMaskVec: std_logic_vector(0 to CNodeDegree-1) := (others=>'0');
    variable tempBit, tempBit2	: std_logic;

  begin

    -- Default assignments
    minOneHotxD <= (others=>(others=>'0'));

    for jj in 0 to 1 loop
      -- First minimum
      if( jj = 0 ) then
        for ii in 0 to CNodeDegree-1 loop
          tempComp := '1';
          for kk in 0 to CNodeDegree-1 loop
            if( kk /= ii ) then
              tempComp := tempComp and compxD(ii)(kk);
            end if;
          end loop;
          minOneHotxD(jj)(ii) <= tempComp;
        end loop;
      -- Rest of minima
      else
        -- Prepare internal masks
        for ii in 0 to CNodeDegree-1 loop
          maskVec(ii) := '0';
          for kk in 0 to jj-1 loop
            maskVec(ii) := maskVec(ii) or minOneHotxD(kk)(ii);
          end loop;
        end loop;
        -- Prepare external mask
        for ii in 0 to CNodeDegree-1 loop
          extMaskVec(ii) := '1';
          for kk in 0 to jj-1 loop
            extMaskVec(ii) := extMaskVec(ii) and (not minOneHotxD(kk)(ii));
          end loop;
        end loop;
        -- Get one hot encoding
        for ii in 0 to CNodeDegree-1 loop
          tempComp := '1';
          for kk in 0 to CNodeDegree-1 loop
            if( kk /= ii ) then
              tempComp := tempComp and (compxD(ii)(kk) or maskVec(kk));
            end if;
          end loop;
          tempComp := tempComp and extMaskVec(ii);
          minOneHotxD(jj)(ii) <= tempComp;
        end loop;
      end if;
    end loop;
   
    -- Create Min outputs
    for jj in 0 to 1 loop
      for ii in 0 to QLLR-2 loop
        tempBit := '0';
        for kk in 0 to CNodeDegree-1 loop	
          tempBit := tempBit or (DataInxD(kk)(ii) and minOneHotxD(jj)(kk));
        end loop;
        MinxD(jj)(ii) <= tempBit;
      end loop;
    end loop;

  end process;

  assign_output_memless: process(MinxD)
  begin
    for ii in 0 to CNodeDegree-1 loop
      if( DataInxD(ii) = MinxD(1) ) then
        IntLLRxDO(ii) <= to_integer(unsigned('0' & MinxD(0)));
      else
        IntLLRxDO(ii) <= to_integer(unsigned('0' & MinxD(1)));
      end if;
    end loop;  -- ii
  end process;
  
end arch;
