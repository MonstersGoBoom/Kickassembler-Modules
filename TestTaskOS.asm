//-------------------------------------------------------------
// Simple example of a tasking system
//-------------------------------------------------------------

//	we only write CODE and DATA
.file [name="TestTaskOS.prg", segments="CODE,DATA"]

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
	//	Initialize the TaskOS
	jsr TaskOS.Init 

	//	add some sample tasks
	TaskOS_RegisterFunction(Sample_Ticker,5)		//	add Sample_Ticker and call it every 5 frames
	TaskOS_RegisterFunction(Sample_Object.Init,0)		//	add Sample_Object and call it right away 
	TaskOS_RegisterFunction(Sample_Object.Init,240)	//	same but wait 240 frames first

//	basic test
//	wait for raster in middle of screen 
vbl:	lda $d012 
			cmp #$80
			bne vbl 
			//	step the TaskOS				
			inc $d020
			jsr TaskOS.Step
			dec $d020 
			jmp vbl 
}

//-------------------------------------------------------------
//	just the bare example
//	change first visible char on screen 
//-------------------------------------------------------------
Sample_Ticker:
	inc $0400 
	rts

//-------------------------------------------------------------
//	more namespacey example
//-------------------------------------------------------------
Sample_Object:
{
.segment ZP
		temp_var:					.byte 0
	//	we can put our INIT function here 
	//	
.segment CODE 
	//	init gets called when the task is first called
	Init:
	{
		//	X is already this value 
		//	though if you trash X 
		//	you can get it back like this

		ldx TaskOS.Step.CurrentTask
		//	we put an I on the screen 
		lda #'i'
		sta $0400,x
		//	X is the current running task index
		//	so we use it to make a new value for delay
		txa
		asl 
		asl 
		asl 
		asl 
		//	set our time and reset time to this value
		sta TaskOS.ResetTime,x 
		sta TaskOS.Timer,x 
		//	Change the function pointer 
		//	to Update
		TaskOS_SwitchFunction(Update)
		rts
	}
   //  we could skip the RTS above here and fall through to 
   //  Init and Update in one shot, but we don't here for clarity

	//	the next "tick" after Init
	Update:
	{
		//	show we're update loop with U on screen
		lda #'u'
		sta $0400,x
		//	update the char underneath
		inc $0428,x
		rts
	}
}

	#import "TaskOS.asm"
