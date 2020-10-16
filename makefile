# assumes the path of kickass.jar to be inside the BIN folder 

AS = java -jar bin\kickass.jar 
EXO = bin\exomizer  

all: TestTaskOS.prg

# build test for TaskOS 

TestTaskOS.prg:	TestTaskOS.asm TaskOS.asm SystemType.asm Debug_PrintHex.asm APUltra.asm 
	$(AS) TestTaskOS.asm -vicesymbols -symbolfile -showmem

TestAPUltra.prg:	TestAPUltra.asm APUltra.asm 
	$(AS) TestTaskOS.asm -vicesymbols -symbolfile -showmem

clean:
	rm TestTaskOS.prg 

