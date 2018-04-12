#! /bin/bash

VSIM=~/altera/13.1/modelsim_ase/bin/vsim
# Run the testbench
$VSIM -novopt -t 1ps \
			-do BIN_Decoder/SimScripts.do \
                        work.TopLevelDecoderTB &
