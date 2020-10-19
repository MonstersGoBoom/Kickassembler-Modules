
.segment ZP
	mem_source:	.word 0 
	mem_dest:		.word 0 
	mem_size:		.word 0 


//	lda value
//	memset(destination,size in bytes)

.macro memset(dest,size) {
	sta mem_source
	lda #<size
	ldy #>size 
	sta mem_size
	sty mem_size+1 
	lda #<dest 
	ldy #>dest
	sta mem_dest
	sty mem_dest+1
	jsr _memset_
}

//	memcpy(source,destination,size in bytes)
.macro memcpy(source,dest,size) {
	lda #<source 
	ldy #>source 
	sta mem_source
	sty mem_source+1
	lda #<size
	ldy #>size 
	sta mem_size
	sty mem_size+1 
	lda #<dest 
	ldy #>dest
	sta mem_dest
	sty mem_dest+1
	jsr _memcpy_
}

.segment CODE 

_memset_:
{
	lda mem_source
	ldy #0
	ldx mem_size+1
  beq remaining_bytes
ms1:
	sta (mem_dest),y
	iny
	bne ms1
	inc mem_dest+1
	dex
	bne ms1
remaining_bytes:
	ldx mem_size
	beq ms4
ms3:
	sta (mem_dest),y
	iny
	dex
	bne ms3
ms4:
	rts
}

_memcpy_:
{
	ldy #0
	ldx mem_size+1
  beq remaining_bytes
mc1:
	lda (mem_source),y
	sta (mem_dest),y
	iny
	bne mc1
	inc mem_dest+1
	inc mem_source+1
	dex
	bne mc1
remaining_bytes:
	ldx mem_size
	beq mc4
mc3:
	lda (mem_source),y
	sta (mem_dest),y
	iny
	dex
	bne mc3
mc4:
	rts
}




