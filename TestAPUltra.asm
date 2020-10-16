
// https://github.com/emmanuel-marty/apultra
// use the compressor above to generate data 

//
// NOTE : this file won't build AS IS it will need data 
//

//	we only write CODE and DATA

.file [name="TestAPUltra.prg", segments="CODE,DATA"]

// NOTE: doesn't get written to the prg
.segment ZP [start=$02]																		
.segment CODE [start=$0801]
.segment DATA [startAfter="CODE"]

.segment CODE

//-------------------------------------------------------------
//	This creates a basic sys line that can start your program
//-------------------------------------------------------------
BasicUpstart2(Start)
//	Our code
Start:
{
	//	just to disable the kernal messing around
	sei 
	//	unpack to $4000 
	APUltraUnpack(sprite_data,$4000)
	rts 

}

	#import "APUltra.asm"

	.segment DATA
	sprite_data:	.import binary <datafile>


