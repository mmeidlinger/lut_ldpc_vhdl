#! /bin/tcsh -f

set LIB=WORK

# delete and recreate library 
rm -rf $LIB
eda mgc vlib $LIB

# Config packages
eda mgc vcom -work $LIB config.vhdl

# Register banks
eda mgc vcom -work $LIB IntLLRVNStageRegBank.vhdl
eda mgc vcom -work $LIB IntLLRCNStageRegBank.vhdl
eda mgc vcom -work $LIB ChLLRRegBank.vhdl

# Check node stage
eda mgc vcom -work $LIB min4.vhdl
eda mgc vcom -work $LIB cnodetree.vhdl
eda mgc vcom -work $LIB CNStage.vhdl

# Variable node stage
eda mgc vcom -work $LIB vnodeadders.vhdl
eda mgc vcom -work $LIB VNStage.vhdl
eda mgc vcom -work $LIB VNStageLastIter.vhdl

# Top level decoder
eda mgc vcom -work $LIB TopLevelDecoder.vhdl

