# Kickassembler-Modules
Handy 6510 assembly modules for Kick Assembler

# TaskOS.asm
A simple task system. 

# SystemType.asm 
Detect PAL / NTSC.

	jsr SystemType 
	// A 	= 0 PAL
				= 1 NTSC 

	lda SystemType.isNTSC 

# Debug_PrintHEX.asm 

	lda <value>
	ldx <msb screen address>
	ldy <lsb screen address>
	jsr PrintHex
	








