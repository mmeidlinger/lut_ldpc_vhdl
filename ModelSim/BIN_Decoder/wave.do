onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /topleveldecodertb/ClkxC
add wave -noupdate /topleveldecodertb/RstxRB
add wave -noupdate /topleveldecodertb/ChLLRxD
add wave -noupdate /topleveldecodertb/s_LLRout
add wave -noupdate /topleveldecodertb/ChLLRxD2
add wave -noupdate /topleveldecodertb/decoder_delay
add wave -noupdate /topleveldecodertb/DecodedBitsxD
add wave -noupdate /topleveldecodertb/s_LLRout2
add wave -noupdate /topleveldecodertb/mismatch
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {105000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 257
configure wave -valuecolwidth 306
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {622168 ps}
