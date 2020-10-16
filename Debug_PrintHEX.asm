
PrintHex:
{
.segment ZP
	DestinationAddress:	.word 0 

.segment CODE
	// Dest.          = YREG:XREG
	// Value to utput = ACC
		sty DestinationAddress
		stx DestinationAddress+1
		ldy #$00
		pha
		lsr
		lsr
		lsr
		lsr
		tax
		lda tab,x

		sta (DestinationAddress),y
		iny
		pla
		and #$0f
		tax
		lda tab,x
		sta (DestinationAddress),y
		rts

	.encoding "screencode_upper"
	tab:
	.text "0123456789ABCDEF"
}
