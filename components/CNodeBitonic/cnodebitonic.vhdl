library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_misc.all;
library work;
use work.config.all;

entity CNodeBitonic is
  
  port (
    IntLLRxDI : in  IntLLRTypeC;
    IntLLRxDO : out IntLLRTypeC
    );
end CNodeBitonic;

architecture arch of CNodeBitonic is


  -- Signal for absolute values
  signal DataInxD               : IntAbsLLRTypeC;
  -- Signal to store all signs
  signal allSignsxD             : std_logic_vector(0 to CNodeDegree-1);
  -- Signal for product of signs
  signal allSignsProdxD         : std_logic;
  -- Minimum output
  signal MinxD                  : MinType;
  -- Bitonic sorter signals
  signal allIntLLRsxD		: IntLLRAbsStage;
  
begin

  -- Get absolute values
  get_abs_val_memless: process(IntLLRxDI)
    variable tempVal : unsigned(QLLR-1 downto 0);
  begin
    for ii in 0 to CNodeDegree-1 loop
      tempVal := to_unsigned(IntLLRxDI(ii),QLLR);
      DataInxD(ii) <= std_logic_vector(tempVal(QLLR-2 downto 0));
      allSignsxD(ii) <= tempVal(QLLR-1);
    end loop;  -- ii
    allSignsProdxD <= xor_reduce(allSignsxD);
  end process;

  -- Get product of all signs
  
  -- Perform bitonic sort
  bitonicSort_memless: process(DataInxD,allIntLLRsxD)
  begin

    -- Assign input to stage 0
    for ii in 0 to CNodeDegree-1 loop
      allIntLLRsxD(0)(ii) <= DataInxD(ii);
    end loop;

    -- Sorting network
    for ii in 0 to (CNodeDegreeLog-1+1)-1 loop
      for jj in 0 to ii loop
        -- First sorter substage within each stage has special structure
        if( jj = 0 ) then
          for kk in 0 to (CNodeDegree/2)/(2**ii)-1 loop
            for ll in 0 to 2**ii-1 loop
               -- Swap inputs or not, based on comparison
              if( allIntLLRsxD(GETSTAGECOUNT(ii)+jj)(kk*2**(ii+1)+ll) > allIntLLRsxD(GETSTAGECOUNT(ii)+jj)((kk+1)*2**(ii+1) - (ll+1)) ) then
                allIntLLRsxD(GETSTAGECOUNT(ii)+jj+1)(kk*2**(ii+1)+ll) <= allIntLLRsxD(GETSTAGECOUNT(ii)+jj)((kk+1)*2**(ii+1) - (ll+1));
                allIntLLRsxD(GETSTAGECOUNT(ii)+jj+1)((kk+1)*2**(ii+1) - (ll+1)) <= allIntLLRsxD(GETSTAGECOUNT(ii)+jj)(kk*2**(ii+1)+ll);
              else
                allIntLLRsxD(GETSTAGECOUNT(ii)+jj+1)(kk*2**(ii+1)+ll) <= allIntLLRsxD(GETSTAGECOUNT(ii)+jj)(kk*2**(ii+1)+ll);
                allIntLLRsxD(GETSTAGECOUNT(ii)+jj+1)((kk+1)*2**(ii+1) - (ll+1)) <= allIntLLRsxD(GETSTAGECOUNT(ii)+jj)((kk+1)*2**(ii+1) - (ll+1));
              end if;
            end loop;
          end loop;
        -- Remaining sorters have similar structure
        else
          for kk in 0 to (CNodeDegree/2)/2**(ii-jj)-1 loop
            for ll in 0 to 2**(ii-jj)-1 loop
               -- Swap inputs or not, based on comparison
              if( allIntLLRsxD(GETSTAGECOUNT(ii)+jj)(kk*2**(ii-jj+1)+ll) > allIntLLRsxD(GETSTAGECOUNT(ii)+jj)(kk*2**(ii-jj+1)+ll+2**(ii-jj)) ) then
                allIntLLRsxD(GETSTAGECOUNT(ii)+jj+1)(kk*2**(ii-jj+1)+ll) <= allIntLLRsxD(GETSTAGECOUNT(ii)+jj)(kk*2**(ii-jj+1)+ll+2**(ii-jj));
                allIntLLRsxD(GETSTAGECOUNT(ii)+jj+1)(kk*2**(ii-jj+1)+ll+2**(ii-jj)) <= allIntLLRsxD(GETSTAGECOUNT(ii)+jj)(kk*2**(ii-jj+1)+ll);
              else
                allIntLLRsxD(GETSTAGECOUNT(ii)+jj+1)(kk*2**(ii-jj+1)+ll) <= allIntLLRsxD(GETSTAGECOUNT(ii)+jj)(kk*2**(ii-jj+1)+ll);
                allIntLLRsxD(GETSTAGECOUNT(ii)+jj+1)(kk*2**(ii-jj+1)+ll+2**(ii-jj)) <= allIntLLRsxD(GETSTAGECOUNT(ii)+jj)(kk*2**(ii-jj+1)+ll+2**(ii-jj));
              end if;
            end loop;
          end loop;
        end if;
      end loop;
    end loop;
  end process;

  -- Get minima from last stage
  get_minima_memless: process(allIntLLRsxD)
  begin
    for ii in 0 to 1 loop
      MinxD(ii) <= allIntLLRsxD(SorterStages)(ii);
    end loop;
  end process;

  -- Assign output
  assign_output_memless: process(MinxD,DataInxD)
  begin
    for ii in 0 to CNodeDegree-1 loop
      if( DataInxD(ii) = MinxD(1) ) then
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
