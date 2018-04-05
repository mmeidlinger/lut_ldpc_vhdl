#! /bin/tcsh -f

set LIB=work
set rtlpath = ../TopLevelDecoder
set tbpath = ../TopLevelDecoder

# Delete and recreate library 
rm -rf $LIB
eda mgc vlib $LIB

# Config packages
eda mgc vcom -work $LIB $rtlpath/config.vhdl

# Register banks
eda mgc vcom -work $LIB $rtlpath/IntLLRVNStageRegBank.vhdl
eda mgc vcom -work $LIB $rtlpath/IntLLRCNStageRegBank.vhdl
eda mgc vcom -work $LIB $rtlpath/ChLLRRegBank.vhdl
eda mgc vcom -work $LIB $rtlpath/DecodedBitsVNStageRegBank.vhdl

# Check node stage
eda mgc vcom -work $LIB $rtlpath/min4.vhdl
eda mgc vcom -work $LIB $rtlpath/cnodetree.vhdl
eda mgc vcom -work $LIB $rtlpath/CNStage.vhdl

# Variable node stage
eda mgc vcom -work $LIB $rtlpath/VNodeLUT_S0.vhdl
eda mgc vcom -work $LIB $rtlpath/VNodeLUT_S1.vhdl
eda mgc vcom -work $LIB $rtlpath/VNodeLUT_S2.vhdl
eda mgc vcom -work $LIB $rtlpath/VNodeLUT_S3.vhdl
eda mgc vcom -work $LIB $rtlpath/VNodeLUT_S4.vhdl
eda mgc vcom -work $LIB $rtlpath/VNodeLUT_S5.vhdl
eda mgc vcom -work $LIB $rtlpath/VNodeLUT_S6.vhdl
eda mgc vcom -work $LIB $rtlpath/VNodeLUT_S7.vhdl
eda mgc vcom -work $LIB $rtlpath/VNStage_S0.vhdl
eda mgc vcom -work $LIB $rtlpath/VNStage_S1.vhdl
eda mgc vcom -work $LIB $rtlpath/VNStage_S2.vhdl
eda mgc vcom -work $LIB $rtlpath/VNStage_S3.vhdl
eda mgc vcom -work $LIB $rtlpath/VNStage_S4.vhdl
eda mgc vcom -work $LIB $rtlpath/VNStage_S5.vhdl
eda mgc vcom -work $LIB $rtlpath/VNStage_S6.vhdl
eda mgc vcom -work $LIB $rtlpath/VNStage_S7.vhdl

# Top level decoder
eda mgc vcom -work $LIB $rtlpath/TopLevelDecoder.vhdl

# TB
eda mgc vcom -work $LIB $tbpath/TopLevelDecoderTB.vhd
