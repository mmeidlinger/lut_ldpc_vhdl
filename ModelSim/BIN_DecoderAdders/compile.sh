#! /bin/tcsh -f

set LIB=work
set rtlpath = ../TopLevelDecoderAdders
set tbpath = ../TopLevelDecoderAdders

# delete and recreate library 
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
eda mgc vcom -work $LIB $rtlpath/vnodeadders.vhdl
eda mgc vcom -work $LIB $rtlpath/VNStage.vhdl
eda mgc vcom -work $LIB $rtlpath/VNStageLastIter.vhdl

# Top level decoder
eda mgc vcom -work $LIB $rtlpath/TopLevelDecoder.vhdl


# TB
eda mgc vcom -work $LIB $tbpath/TopLevelDecoderTB.vhd
