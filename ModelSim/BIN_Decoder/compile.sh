#! /bin/bash

VCOM=~/altera/13.1/modelsim_ase/bin/vcom
VLIB=~/altera/13.1/modelsim_ase/bin/vlib

LIB=work
rtlpath=../TopLevelDecoder
tbpath=../TopLevelDecoder

# Delete and recreate library 
rm -rf $LIB
$VLIB $LIB

# Config packages
$VCOM -work $LIB $rtlpath/config.vhdl

# Register banks
$VCOM -work $LIB $rtlpath/IntLLRVNStageRegBank.vhdl
$VCOM -work $LIB $rtlpath/IntLLRCNStageRegBank.vhdl
$VCOM -work $LIB $rtlpath/ChLLRRegBank.vhdl
$VCOM -work $LIB $rtlpath/DecodedBitsVNStageRegBank.vhdl

# Check node stage
$VCOM -work $LIB $rtlpath/min4.vhdl
$VCOM -work $LIB $rtlpath/cnodetree.vhdl
$VCOM -work $LIB $rtlpath/CNStage.vhdl

# Variable node stage
$VCOM -work $LIB $rtlpath/VNodeLUT_S0.vhdl
$VCOM -work $LIB $rtlpath/VNodeLUT_S1.vhdl
$VCOM -work $LIB $rtlpath/VNodeLUT_S2.vhdl
$VCOM -work $LIB $rtlpath/VNodeLUT_S3.vhdl
$VCOM -work $LIB $rtlpath/VNodeLUT_S4.vhdl
$VCOM -work $LIB $rtlpath/VNodeLUT_S5.vhdl
$VCOM -work $LIB $rtlpath/VNodeLUT_S6.vhdl
$VCOM -work $LIB $rtlpath/VNodeLUT_S7.vhdl
$VCOM -work $LIB $rtlpath/VNStage_S0.vhdl
$VCOM -work $LIB $rtlpath/VNStage_S1.vhdl
$VCOM -work $LIB $rtlpath/VNStage_S2.vhdl
$VCOM -work $LIB $rtlpath/VNStage_S3.vhdl
$VCOM -work $LIB $rtlpath/VNStage_S4.vhdl
$VCOM -work $LIB $rtlpath/VNStage_S5.vhdl
$VCOM -work $LIB $rtlpath/VNStage_S6.vhdl
$VCOM -work $LIB $rtlpath/VNStage_S7.vhdl

# Top level decoder
$VCOM -work $LIB $rtlpath/TopLevelDecoder.vhdl

# TB
$VCOM -work $LIB $tbpath/TopLevelDecoderTB.vhd
