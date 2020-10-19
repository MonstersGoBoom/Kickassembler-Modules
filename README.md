# Kickassembler-Modules
Handy 6510 assembly modules for Kick Assembler

# TaskOS.asm
A simple task system. 

similar to the one Robotron arcade uses.

note1: now when adding tasks, the system will search for a free slot to use.

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
```

# Joystick.asm 

```
	//	initialize the joystick code
	jsr Joystick.Reset 

	per vblank 
	jsr Joystick.Poll

	ldx #Joystick.FIRE ( or UP,DOWN,LEFT,RIGHT )
	jsr Joystick.Pressed 

	//	A = 1	input just pressed
	//	if you hold the button down this will return 1 only the first time you press the button 
	//	A = 0 all other times 

	ldx #Joystick.FIRE ( or UP,DOWN,LEFT,RIGHT )
	jsr Joystick.Held 

	//	A = 0 if it's currently held
	//	A = 1 if not 

	lda Joystick.data+UP 
	lda Joystick.data+DOWN
	lda Joystick.data+LEFT
	lda Joystick.data+RIGHT
	lda Joystick.data+FIRE

	//	A!=$ff if it's been touched in the last 8 ticks
	//	(A & 1) == 0 if it's currently held 
```

# TestTaskOS.asm 

	A simple test of the above modules.

	detects PAL/NTSC and adjusts the frequency the TaskOS is updated.

	In order to keep logic and timing the same on PAL or NTSC machines.

	Shows how to add and change tasks running in the system. 

	Tapping fire will add a simple task ( these tasks will kill themselves after updating for a while )
	
# APUltra.asm 
	Decompression. 
	
	quick port to Kickassembler module from.

[AP Ultra](https://github.com/emmanuel-marty/apultra)


# Random.asm 

	Random numbers 

## For 8 bit numbers
```
	jsr Random.RND8Seed
	jsr Random.RND8 
	A = number 
```
## For 16 bit 
```
	jsr Random.RND16Seed 
	jsr Random.RND16 
	A = high byte
	Random.result16 is the word 
```

## Using SID chip 
```
	jsr Random.RNDSIDInit
	jsr Random.RNDSID 
```	
	or use macro 
```	
	RNDSID
```













