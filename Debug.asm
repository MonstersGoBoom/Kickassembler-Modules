
//	lda <value>
//	ldx <msb screen address>
//	ldy <lsb screen address>
//	jsr PrintHex
//	jsr PrintDEC8

Debug:
{
	.segment ZP
		DestinationAddress:	.word 0 
.segment CODE

	PrintDEC8:
	{
			sty DestinationAddress
			stx DestinationAddress+1
			ldy #$2f
			ldx #$3a
			sec
		!:
			iny
			sbc #100
			bcs !-
		!:
			dex
			adc #10
			bmi !-
			adc #$2f
			sty hundreds
			stx tens
			sta ones 
			ldy #$00
	.label hundreds = *+1			
			lda #$00
			sta (DestinationAddress),y 
			iny

	.label tens = *+1			
			lda #$00 
			sta (DestinationAddress),y
			iny 

	.label ones = *+1			
			lda #$00 
			sta (DestinationAddress),y

			rts
	}
	PrintHex:
	{
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

}

