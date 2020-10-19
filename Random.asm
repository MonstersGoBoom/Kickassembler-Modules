
//	Reference code 
// 8 bit https://codebase64.org/doku.php?id=base:small_fast_8-bit_prng
// 16 bit https://codebase64.org/doku.php?id=base:small_fast_16-bit_prng

//	for 8 bit numbers
//	jsr Random.RND8Seed
//	jsr Random.RND8 
//	A = number 

// for 16 bit 
//	jsr Random.RND16Seed 
//	jsr Random.RND16 
//	A = high byte
//	Random.result16 is the word 

//	for SID generated random
//	jsr Random.RNDSIDInit
//	jsr Random.RNDSID 
//	or use macro 
//	RNDSID

.label MAGIC8 = $c3 
.label MAGIC16 = $1097

.macro RNDSID {
	lda $d41b 
}

Random:
{
	.segment ZP
	result8:	.byte 0 

	result16:	.word 0 
	magic16:	.word 0

	.segment CODE 

//-------------------------------------------------------------
//	8 bit number
//-------------------------------------------------------------

	//	reseed
	RND8Seed:
	{
		sta result8
	}
	//	intentionally fall through 
	RND8:
	{
		lda result8
		beq doEor
		asl
		beq noEor // if the input was $80, skip the EOR
		bcc noEor
doEor:
		eor #MAGIC8
noEor:
		sta result8
		rts
	}

//-------------------------------------------------------------
//	16 bit
//-------------------------------------------------------------

	RND16Seed:
	{
		sta result16 
		stx result16+1 
	}
	//	intentionally fall through 
	RND16:
	{
		lda result16
		beq lowZero // $0000 and $8000 are special values to test for

		// Do a normal shift
		asl result16
		lda result16+1
		rol
		bcc noEor

doEor:
		// high byte is in .A
		eor #<MAGIC16
		sta result16+1
		lda result16
		eor #>MAGIC16
		sta result16
		rts
  
lowZero:
		lda result16+1
		beq doEor // High byte is also zero, so apply the EOR
							// For speed, you could store 'magic' into 'seed' directly
							// instead of running the EORs

		// wasn't zero, check for $8000
		asl
		beq noEor // if $00 is left after the shift, then it was $80
		bcs doEor // else, do the EOR based on the carry bit as usual

		noEor:
		sta result16+1
		rts
	}

//-------------------------------------------------------------
//	using SID
//-------------------------------------------------------------

	RNDSIDInit:
	{
		lda #$ff  // maximum frequency value
		sta $d40e // voice 3 frequency low byte
		sta $d40f // voice 3 frequency high byte
		lda #$80  // noise waveform, gate bit off
		sta $d412 // voice 3 control register
		rts
	}

	RNDSID:
	{
		lda $d41b 
		rts
	}

}