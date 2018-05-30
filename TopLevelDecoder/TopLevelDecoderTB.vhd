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

  signal ChLLRxD, ChLLRxD2      : ChLLRTypeStage;
  signal TestSLV 	        : std_logic_vector(7 downto 0);
  signal ClkxC                  : std_logic;
  signal RstxRB                 : std_logic;
  signal DecodedBitsxD          : std_logic_vector(N-1 downto 0);
  signal s_LLRout,s_LLRout2     : std_logic_vector(N-1 downto 0) := (others => '0');
  signal mismatch               : integer := N;
  signal stim_iter              : integer := 0;
  
  constant nb_stim_iter : integer := 128;
  type ChLLR_array is array (0 to nb_stim_iter) of ChLLRTypeStage;
  type LLRout_array is array (0 to nb_stim_iter) of std_logic_vector(N-1 downto 0);
  signal array_ChLLRxD : ChLLR_array;
  signal array_LLRout  : LLRout_array;

  constant RST_APPL : time := 100 ns;
  constant CLK_PERIOD : time := 10 ns;
  constant STIM_APPL : time := 1 ns;
  constant Read_LLR : time := 2 ns;
  constant decoder_delay : time := (iter*2)*CLK_PERIOD;--+RST_APPL;


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
    file stim_file : text open read_mode is "OUT/stimuli.txt"; --1)
    variable v_ChLLRxD : std_logic_vector(31 downto 0);
    variable v_LLRout : std_logic;
    variable TextLine : line;
    variable v_stim_iter : integer := 0;
    --variable r_comment : character := ' ';
    --variable comment : character := '#';
            
  begin  -- process p_Stim
    
    while not endfile(stim_File) loop
    
      wait for STIM_APPL;
      readline(stim_File, TextLine );                   --read ascii representation of the values
      for i in 0 to N-1 loop
        hread(TextLine, v_ChLLRxD);		        -- read bytes
        ChLLRxD(i) <= to_integer(unsigned(v_ChLLRxD));	-- Convert the type, be careful about numbers
      end loop;  -- i
      
      readline(stim_File, TextLine );                   -- read output
      for i in 0 to N-1 loop
        read(TextLine, v_LLRout);
        s_LLRout(i) <= v_LLRout;
      end loop;
     
     array_ChLLRxD(v_stim_iter) <= ChLLRxD;               --save all stimuli in an array
     array_LLRout (v_stim_iter) <= s_LLRout;
     
     v_stim_iter := v_stim_iter +1;
     stim_iter <= v_stim_iter;
    end loop; --while stim_iter
    
    
    wait until RstxRB='1';                              -- apply stimuli clk by clk
    for j in 0 to nb_stim_iter loop
        wait until ClkxC='1' and ClkxC'event;
        ChLLRxD2 <= array_ChLLRxD(j);
    end loop;

  end process p_Stim;
  
  -----------------------------------------------------------------------------
  -- Validate Output
  -----------------------------------------------------------------------------
  out_check: process
  begin
    wait for RST_APPL;
    wait for decoder_delay;
    wait for CLK_PERIOD;
  	
    for j in 0 to stim_iter loop
        
      wait until ClkxC='1' and ClkxC'event;
      s_LLRout2  <= array_LLRout(j+1);
      mismatch <= N;
      for i in 0 to N-1 loop
        if (s_LLRout2(i) /= DecodedBitsxD(i)) then
  	  mismatch <= i;
  	end if;
      end loop;
        
      if (j >= 2) then        -- delay the comparison 
        if (mismatch=N) then
        	report "Great! Successfully completed test " & integer'image(j-1);
        else
        	report "ERROR! Mismatch is detected in decoded bit" & integer'image(mismatch) 	severity ERROR;
        end if;
      end if;
        
      
    end loop; --stim_iter
    assert (FALSE) report "Simulation end." severity failure;
  end process out_check;			

  
  -----------------------------------------------------------------------------
  -- DUT
  -----------------------------------------------------------------------------
  DUT : TopLevelDecoder
    port map (
      ChLLRxDI       => ChLLRxD2,
      ClkxCI         => ClkxC,
      RstxRBI        => RstxRB,
      DecodedBitsxDO => DecodedBitsxD);
  

end testbench;
