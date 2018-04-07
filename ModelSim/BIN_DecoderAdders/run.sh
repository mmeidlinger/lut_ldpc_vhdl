#! /bin/tcsh -f

# Run the testbench
eda mgc vsim -novopt -t 1ps \
			-do BIN_DecoderAdders/SimScripts.do \
                        work.TopLevelDecoderTB &
