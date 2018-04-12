#! /bin/bash

VCOM=~/altera/13.1/modelsim_ase/bin/vcom
VLIB=~/altera/13.1/modelsim_ase/bin/vlib

LIB=work
rtlpath=../TopLevelDecoderAdders
tbpath=../TopLevelDecoderAdders

# delete and recreate library 
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
$VCOM -work $LIB $rtlpath/vnodeadders.vhdl
$VCOM -work $LIB $rtlpath/VNStage.vhdl
$VCOM -work $LIB $rtlpath/VNStageLastIter.vhdl

# Top level decoder
$VCOM -work $LIB $rtlpath/TopLevelDecoder.vhdl


# TB
$VCOM -work $LIB $tbpath/TopLevelDecoderTB.vhd
