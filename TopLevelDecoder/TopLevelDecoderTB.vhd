-- read from ascii file

library IEEE;
use IEEE.std_logic_1164.all;
--use IEEE.std_logic_arith.all;
use ieee.numeric_std.all;
use std.textio.all;
use IEEE.std_logic_textio.all;
use work.config.all;


entity TopLevelDecoderTB is
  
end TopLevelDecoderTB;


architecture testbench of TopLevelDecoderTB is

  component TopLevelDecoder
    port (
      ChLLRxDI       : in  ChLLRTypeStage;
      ClkxCI         : in  std_logic;
      RstxRBI        : in  std_logic;
      DecodedBitsxDO : out std_logic_vector(N-1 downto 0));
  end component;

  signal ChLLRxD       : ChLLRTypeStage;
  signal TestSLV 	: std_logic_vector(7 downto 0);
  signal ClkxC         : std_logic;
  signal RstxRB        : std_logic;
  signal DecodedBitsxD : std_logic_vector(N-1 downto 0);
  signal s_LLRout : std_logic_vector(N-1 downto 0);
  signal mismatch : integer := N;

  constant RST_APPL : time := 100 ns;
  constant CLK_PERIOD : time := 10 ns;
  constant STIM_APPL : time := 1 ns;
  constant Read_LLR : time := 2 ns;
  constant decoder_delay : time :=10*CLK_PERIOD+RST_APPL;

 -- type IntegerFileType is file of std_logic_vector(31 downto 0);

begin  -- testbench


  -----------------------------------------------------------------------------
  -- Clock and Reset
  -----------------------------------------------------------------------------
  p_Reset: process
  begin  -- process p_Reset
    RstxRB <= '0';
    wait for RST_APPL;
    RstxRB <= '1';
    wait;
  end process p_Reset;
  
  p_cclk: process
  begin  -- process p_cclk
    ClkxC <= '0';
    wait for CLK_PERIOD/2;
    ClkxC <= '1';
    wait for CLK_PERIOD/2;
  end process p_cclk;


  -----------------------------------------------------------------------------
  -- Stimuli Application
  -----------------------------------------------------------------------------
  p_Stim: process
    file stim_file : text open read_mode is "OUT/LLRin.stim"; --1)
    variable v_ChLLRxD : std_logic_vector(31 downto 0);
    variable TextLine : line;
            
  begin  -- process p_Stim

    for i in 0 to N-1 loop
      ChLLRxD(i) <= 1;
    end loop;  -- i
    
    wait until ClkxC='1' and ClkxC'event;
     readline(stim_File, TextLine );		--2)read ascii representation of the values
    
    while true loop
      wait until ClkxC='1' and ClkxC'event;
      wait for STIM_APPL;

      for i in 0 to N-1 loop
        hread(TextLine, v_ChLLRxD);		-- 3)read bytes
        ChLLRxD(i) <= to_integer(unsigned(v_ChLLRxD));	--4)Convert the type, be careful about numbers
         --ChLLRxD(i) <=std_logic_vector(to_unsigned(character'POS(v_ChLLRxD), 32));
   
      end loop;  -- i
      wait;
    end loop;

  end process p_Stim;
  
  -----------------------------------------------------------------------------
  -- Validate Output
  -----------------------------------------------------------------------------
  out_read: process
    file LLRout : text open read_mode is "OUT/LLRout";
    variable v_LLRout : std_logic;
    variable TextLine2 : line;
            
  begin  -- process out_read

    --v_LLRout := (others => '1');

    
    wait until ClkxC='1' and ClkxC'event;
    wait until ClkxC='1' and ClkxC'event;
    readline(LLRout, TextLine2 );
    
    while true loop
      wait until ClkxC='1' and ClkxC'event;
      wait for Read_LLR;

      for i in 0 to N-1 loop
        read(TextLine2, v_LLRout);
        s_LLRout(i) <= v_LLRout;
   
      end loop;  -- i
      wait;
    end loop;

  end process out_read;
  
  
  out_check: process
   --variable mismatch : integer := N;
   
  begin
  	wait for decoder_delay;
  	for i in 0 to N-1 loop
  		if (s_LLRout(i) /= DecodedBitsxD(i)) then
  			mismatch <= i;
  		end if;
        end loop;
        
        wait until ClkxC='1' and ClkxC'event;
        if (mismatch=N) then
        	report "Great! Test Completed successfully.";
        else
        	report "ERROR! Mismatch is detected in decoded bit" & integer'image(mismatch) 	severity ERROR;
        end if;
        wait;
  end process out_check;			

  
  -----------------------------------------------------------------------------
  -- DUT
  -----------------------------------------------------------------------------
  DUT : TopLevelDecoder
    port map (
      ChLLRxDI       => ChLLRxD,
      ClkxCI         => ClkxC,
      RstxRBI        => RstxRB,
      DecodedBitsxDO => DecodedBitsxD);
  

end testbench;
