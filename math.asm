#if MATH16
.macro mov16i(value,output) {
	lda #(value)&$ff
	sta output+1
	lda #(value>>8)&$ff
	sta output
}

.macro mov16d(value,output) {
	lda value
	sta output
	lda value+1
	sta output+1
}

.macro add16i(input,value,output) {
	clc
	lda input 
	adc #(value)&$ff
	sta output
	lda input+1
	adc #(value>>8)&$ff
	sta output+1
}

.macro add16d(input,value,output){
	clc
	lda input 
	adc value
	sta output
	lda input+1
	adc value+1
	sta output+1
}
#endif

#if MATH24

.macro mov24i(value,output) {
	lda #(value)&$ff
	sta output+2
	lda #(value>>8)&$ff
	sta output+1
	lda #(value>>16)&$ff
	sta output
}

.macro mov24d(value,output) {
	lda value
	sta output
	lda value+1
	sta output+1
	lda value+2
	sta output+2
}

.macro add24i(input,value,output) {
	clc
	lda input 
	adc #(value)&$ff
	sta output
	lda input+1
	adc #(value>>8)&$ff
	sta output+1
	lda input+2
	adc #(value>>16)&$ff
	sta output+2
}

.macro add24d(input,value,output){
	clc
	lda input 
	adc value
	sta output
	lda input+1
	adc value+1
	sta output+1
	lda input+2
	adc value+2
	sta output+2
}

#endif






