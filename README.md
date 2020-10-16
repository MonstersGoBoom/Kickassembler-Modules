# Kickassembler-Modules
Handy 6510 assembly modules for Kick Assembler

# TaskOS.asm
A simple task system. 

similar to the one Robotron arcade uses.

# SystemType.asm 
Detect PAL / NTSC.

```
	jsr SystemType 
	// A 	= 0 PAL
		= 1 NTSC 

	lda SystemType.isNTSC 
```

# Debug.asm 
```
	lda <value>
	ldx <msb screen address>
	ldy <lsb screen address>

	//	00-FF
	jsr Debug.PrintHex
	//	0-255
	jsr Debug.PrintDEC8


# TestTaskOS.asm 

	A simple test of the above modules.

	detects PAL/NTSC and adjusts the frequency the TaskOS is updated.

	In order to keep logic and timing the same on PAL or NTSC machines.

	Shows how to add and change tasks running in the system. 

# APUltra.asm 
	Decompression. 
	
	quick port to Kickassembler module from.

[AP Ultra](https://github.com/emmanuel-marty/apultra)
	













