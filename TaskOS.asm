
//-------------------------------------------------------------
//	Simple Task OS type system 
//-------------------------------------------------------------

//	Tasks use a countdown timer before being triggered. 
//	this type of system is useful if you want to delay actions or not run code every frame 
//	E.G. you want enemy movement to be every 3 frames
//	also this system easily lets us change logic and delay on an object 
//	E.G. walk left for a second, change state to attack for 3 seconds, then walk right 
//
//	use TaskOS_SwitchFunction(new_state)
//	
//	setting the Timer to 0 will run the task every time TaskOS.Tick is called 

//	*EDIT* marks places for you to edit to fit your own schemes 

//	*EDIT* where this goes 
.segment TASKOS_VTABLE [startAfter="DATA",virtual,align=256]	// 	NOTE: doesn't get written to the prg

//-------------------------------------------------------------
//	Macros to help out 
//-------------------------------------------------------------
//	add's a new function to the OS
.macro TaskOS_RegisterFunction(func,Timer) {

	ldx #Timer
	lda #<func
	ldy #>func
	jsr	TaskOS.RegisterFunction
}
//	sets the current function index (X)
//	to new function 
.macro TaskOS_SwitchFunction(func) {
	lda #<func 
	ldy #>func
	jsr TaskOS.SwitchFunction
}

//	Tasking Module
TaskOS:
{
//	*EDIT* how many tasks you want to manage 
	.label MAX_TASKS     = 16

	//	we use virtual segment here 
	//	we don't need to store this data inside the prg

	.segment TASKOS_VTABLE

		Timer:				.fill MAX_TASKS,0 
		ResetTime:		.fill MAX_TASKS,0
		UpdateLSB:		.fill MAX_TASKS,0
		UpdateMSB:		.fill MAX_TASKS,0
		TaskIndex:		.fill 1,0

	//	the code

	.segment CODE 

	Init:
	{
		ldx #MAX_TASKS-1
		stx TaskIndex
	!:
		lda #$00
		sta Timer,x 
		sta ResetTime,x 
		lda #$00
		sta UpdateMSB,x 
		sta UpdateLSB,x 
		dex
		bpl !-
		rts
	}

	//	assumes X is set to current task index
	SwitchFunction: {
		sta UpdateLSB,x 
		tya
		sta UpdateMSB,x 
		rts
	}
	//	Add a new function 
	//	ay is function 
	//	x is Timer countdown 
	RegisterFunction: {
		stx mod_time
		sta mod_func_lsb 
		ldx TaskIndex

	taskSearch:		
		lda UpdateMSB,x 
		bne notFree 
.label mod_func_lsb = *+1
		lda #$ff 
		sta UpdateLSB,x 
		tya 
		sta UpdateMSB,x
.label mod_time = *+1			
		lda #$00
		sta Timer,x 
		sta ResetTime,x
		stx TaskIndex 
		rts

	notFree:
		dex 
		bpl taskSearch		
		//	fail this time but we start again next time
		ldx #MAX_TASKS-1 
		stx TaskIndex
		rts
	}

	Step:
	{
		ldx #MAX_TASKS-1
	!:
		//	Check we have a function to call.
		//	limitation is we can't have code in the zero page. 
		lda UpdateMSB,x 
		beq SkipTask 
		//	store value in our selfmod section 
		sta TaskFunction+2
		lda UpdateLSB,x 
		sta TaskFunction+1
		//	if ResetTime == 0 then ALWAYS run this task 
		lda ResetTime,x 
		beq StepTask

		//	count down 
		//	if not zero then go to next task
		dec Timer,x 
		bne SkipTask
	StepTask:
		//	store X for safekeeping
		stx CurrentTask
		
		//	this value is written over by the above code
		//	selfmod
	TaskFunction:
		jsr $dead
		//	more selfmod
		//	this is the X value of the current task
	.label CurrentTask = *+1
		ldx #$00
		lda ResetTime,x 
		sta Timer,x 

	SkipTask:
		dex
		bpl !-
		rts
	}
}

