
//	SystemType.isNTSC 	== 1 if NTSC 
//				== 0 if PAL

SystemType:
{
	// detect pal / ntsc
	lda #$00 
	sta isNTSC
w0:
	lda $d012
w1:
	cmp $d012
	beq w1
	bmi w0
	and #$03
	//	a == 3 for PAL 
	cmp #$3 
	beq notNTSC
	inc isNTSC
notNTSC:
	//	self mod
	//	don't really need ZP for this variable 
.label isNTSC = *+1			
	lda #$00
	rts
}
