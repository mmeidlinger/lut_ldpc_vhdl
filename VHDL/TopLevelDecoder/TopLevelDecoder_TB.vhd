library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;


entity TopLevelDecoderTB_new is
  
end TopLevelDecoderTB_new;


architecture testbench of TopLevelDecoderTB_new is

  component TopLevelDecoder
    port (
      ChLLRxDI       : in  ChLLRTypeStage;
      ClkxCI         : in  std_logic;
      RstxRBI        : in  std_logic;
      DecodedBitsxDO : out std_logic_vector(N-1 downto 0));
  end component;

  signal ChLLRxD       : ChLLRTypeStage;
  signal ClkxC         : std_logic;
  signal RstxRB        : std_logic;
  signal DecodedBitsxD : std_logic_vector(N-1 downto 0);

  constant RST_APPL : 100ns;
  constant CLK_PERIOD : 10ns;
  constant STIM_APPL : 1ns;
  
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
    file stim_file : integer is in """../LLRblabl";
  begin  -- process p_Stim

    while true loop
      wait until ClkxCI='1' and ClkxCI'event;
      wait for STIM_APPL;

      for i in 0 to N-1 loop
        READ(stim_File, ChLLRxD(i));
      end loop;  -- i
    end loop;

    
  end process p_Stim;

  
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
