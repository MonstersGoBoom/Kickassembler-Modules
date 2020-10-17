
// cpu
.label cpu6510_ddr  = 0
.label cpu6510_port = 1

// vic-ii
.label vic_spr0_x     = $d000
.label vic_spr0_y     = $d001
.label vic_spr1_x     = $d002
.label vic_spr1_y     = $d003
.label vic_spr2_x     = $d004
.label vic_spr2_y     = $d005
.label vic_spr3_x     = $d006
.label vic_spr3_y     = $d007
.label vic_spr4_x     = $d008
.label vic_spr4_y     = $d009
.label vic_spr5_x     = $d00a
.label vic_spr5_y     = $d00b
.label vic_spr6_x     = $d00c
.label vic_spr6_y     = $d00d
.label vic_spr7_x     = $d00e
.label vic_spr7_y     = $d00f
.label vic_spr_hi_x   = $d010
.label vic_cr1        = $d011
.label vic_raster     = $d012
.label vic_lp_x       = $d013
.label vic_lp_y       = $d014
.label vic_spr_ena    = $d015
.label vic_cr2        = $d016
.label vic_spr_exp_y  = $d017
.label vic_mem        = $d018
.label vic_irq        = $d019
.label vic_irq_ena    = $d01a
.label vic_spr_dp     = $d01b
.label vic_spr_mcolor = $d01c
.label vic_spr_exp_x  = $d01d
.label vic_spr_ss_col = $d01e
.label vic_spr_sd_col = $d01f
.label vic_border     = $d020
.label vic_bg_color0  = $d021
.label vic_bg_color1  = $d022
.label vic_bg_color2  = $d023
.label vic_bg_color3  = $d024
.label vic_spr_color1 = $d025
.label vic_spr_color2 = $d026
.label vic_spr0_color = $d027
.label vic_spr1_color = $d028
.label vic_spr2_color = $d029
.label vic_spr3_color = $d02a
.label vic_spr4_color = $d02b
.label vic_spr5_color = $d02c
.label vic_spr6_color = $d02d
.label vic_spr7_color = $d02e

//  cia1
.label cia1_pra			= $dc00
.label cia1_prb       =$dc01
.label cia1_ddra      =$dc02
.label cia1_ddrb      =$dc03
.label cia2_pra       =$dd00
.label cia2_prb       =$dd01
.label cia2_ddra      =$dd02
.label cia2_ddrb      =$dd03

.label nmi_routine_addr   =$fffa
.label reset_routine_addr =$fffc
.label irq_routine_addr   =$fffe

.macro cia_disable_irq () { 
	lda #$7f
	sta $dc0d
	sta $dd0d
	lda $dc0d
	lda $dd0d
} 

.macro vic_bank_0000	() {
	lda #$3 
	sta cia2_ddra
	sta cia2_pra
} 

.macro vic_bank_4000 () {
	lda #$3 
	sta cia2_ddra
	lda #$2
	sta cia2_pra
}

.macro vic_bank_8000 () {
	lda #$3 
	sta cia2_ddra
	lda #$1
	sta cia2_pra
}

.macro vic_bank_c000 () {
	lda #$3 
	sta cia2_ddra
	lda #$0
	sta cia2_pra
}

.macro vic_enable_mc () { 
	lda vic_cr2 
	ora #$10 
	sta vic_cr2
}

.macro vic_disable_mc () { 
	lda vic_cr2
	and #$ef 
	sta vic_cr2
}

.macro vic_enable_bitmap	() { 
	lda vic_cr1 
	ora #$20 
	sta vic_cr1
}

.macro vic_disable_bitmap	() { 
	lda vic_cr1 
	and #$df 
	sta vic_cr1
} 

.macro vic_24_rows	() { 
	lda vic_cr1 
	and #$7f 
	sta vic_cr1
} 

.macro vic_25_rows () { 
	lda vic_cr1 
	ora #$8 
	sta vic_cr1 
} 

.macro vic_38_columns	() { 
	lda vic_cr2 
	and #$f7 
	sta vic_cr2 
} 

.macro vic_40_columns () { 
	lda vic_cr2 
	ora #$8 
	sta vic_cr2
} 

.macro vic_disable_irq () {
	lda #$00 
	sta vic_irq_ena
	inc vic_irq
} 

.macro vic_enable_irq () {
	lda #$01
	sta vic_irq_ena
	inc vic_irq
} 

.macro vic_charset_0000 () {
	lda vic_mem 
	and #$f1 
	sta vic_mem 
} 

.macro vic_charset_0800 () {
	lda vic_mem 
	and #$f1 
	ora #$2
	sta vic_mem 
} 

.macro vic_charset_1000 () {
	lda vic_mem 
	and #$f1 
	ora #$4
	sta vic_mem 
} 

.macro vic_charset_1800 () {
	lda vic_mem 
	and #$f1 
	ora #$6
	sta vic_mem 
} 

.macro vic_charset_2000 () {
	lda vic_mem 
	and #$f1 
	ora #$8
	sta vic_mem 
} 

.macro vic_charset_2800 () {
	lda vic_mem 
	and #$f1 
	ora #$a
	sta vic_mem 
} 

.macro vic_charset_3000 () {
	lda vic_mem 
	and #$f1 
	ora #$c
	sta vic_mem 
} 

.macro vic_charset_3800 () {
	lda vic_mem 
	and #$f1 
	ora #$e
	sta vic_mem 
} 

.macro vic_bitmap_0000 () { 
	lda vic_mem 
	and #$f7 
	sta vic_mem
} 

.macro vic_bitmap_2000 () { 
	lda vic_mem 
	ora #$8 
	sta vic_mem
} 

.macro set_bg_color	(color) { 
	lda #color
	sta vic_bg_color0
} 

.macro set_border_color	(color) { 
	lda #color
	sta vic_border
} 

.macro c64_ram_only	() {
	lda #$7 
	sta cpu6510_ddr
	lda #$00 
	sta cpu6510_port
}

.macro c64_ram_io	() {
	lda #$7 
	sta cpu6510_ddr
	lda #$05 
	sta cpu6510_port
}

.macro c64_ram_io_kernal	() {
	lda #$7 
	sta cpu6510_ddr
	lda #$06 
	sta cpu6510_port
}

.macro c64_ram_io_basic	() {
	lda #$7 
	sta cpu6510_ddr
	sta cpu6510_port
}

.macro c64_ram_charset	() {
	lda #$7 
	sta cpu6510_ddr
	lda #$1
	sta cpu6510_port
}

.macro c64_ram_charset_kernal	() {
	lda #$7 
	sta cpu6510_ddr
	lda #$2
	sta cpu6510_port
}

.macro c64_ram_charset_basic	() {
	lda #$7 
	sta cpu6510_ddr
	lda #$3
	sta cpu6510_port
}

//	lda # (((screenchars & $3fff) / $0400) << 4) + (((screenpixels & $3fff) / $0800) << 1)
//	sta $d018
//// base: divisible by $400, $0000-$3c00 allowed
////macro void vic_screen(word const base) () {
////    vic_mem = (vic_mem & $0f) | (base >> 6)
////}

.macro c64_screen (screen) { 
	lda vic_mem 
	and #$f 
	ora #((screen)>>6)
	sta vic_mem 
} 


