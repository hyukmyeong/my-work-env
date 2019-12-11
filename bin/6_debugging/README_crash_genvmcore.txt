gen_vmcore options : 
	-p : kernel physical start address, 0xC0000000와 mapping되는 physical address 
	-z : ramdump image중 sdram-dump image의 전체 size 
	-e : ramdump image중 sdram-dump image file_name@memory_address@size 
		file_name : sdram-dump image file name 
		memory_address : sdram-dump image의 physical address 
		size : sdram-dump image file size 
	-n : cpu 개수
	ex) ./gen_vmcore -p 0x80200000 -z 0x80000000 -e EBICS0.BIN@0x80000000@0x40000000 -e EBI1CS1.BIN@0xC0000000@0x40000000 -n 4 
	
	physical offset address : 0x80200000 
	Ram size : 0x80000000 
	cpu count : 4 
	start - print all vmcore memory data 
	index : 0 file name : EBICS0.BIN start addr : 0x80000000 size : 0x40000000 (= 1073741824) 
	index : 1 file name : EBI1CS1.BIN start addr : 0xc0000000 size : 0x40000000 (= 1073741824) 
	end - print all vmcore memory data 
	start - print all memory section ... skip ... seek : 0x0 
	 
  
  ./gen_vmcore_8974 -p 0x0 -z 0x80000000 -e DDRCS0.BIN@0x00000000@0x40000000 -e DDRCS1.BIN@0x40000000@0x40000000 -n 4

// crash 실행
8974-crash --no_elf_notes --no_panic --smp -m phys_base=0x0 -p 4096 vmcore vmlinux
