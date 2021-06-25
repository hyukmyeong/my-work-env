#directory /home/mk/ARM/
#set solib-absolute-prefix /home001/hyuk.myeong/src/apq8084_recent/android/out-tiger6_lgu_kr/target/product/tiger6/symbols/lib/
#set solib-search-path /home001/hyuk.myeong/src/apq8084_recent/android/out-tiger6_lgu_kr/target/product/tiger6/symbols/system/lib/: /home001/hyuk.myeong/src/apq8084_recent/android/out-tiger6_lgu_kr/target/product/tiger6/symbols/system/lib/hw/: /home001/hyuk.myeong/src/apq8084_recent/android/out-tiger6_lgu_kr/target/product/tiger6//symbols/system/lib/egl/

define print_vector
    if $argc == 2
        set $elem = $arg0.size()
        if $arg1 >= $arg0.size()
            printf "Error, %s.size() = %d, printing last element:\n", "$arg0", $arg0.size()
            set $elem = $arg1 -1
        end
        print *($arg0._M_impl._M_start + $elem)@1
    else
        print *($arg0._M_impl._M_start)@$arg0.size()
    end
end

document print_vector
Display vector contents
Usage: print_vector VECTOR_NAME INDEX
VECTOR_NAME is the name of the vector
INDEX is an optional argument specifying the element to display
end

alias pv = print_vector

define add-symbol-file-auto
  # Parse .text address to temp file
  shell echo set \$text_address=$(readelf -WS $arg0 | grep .text | awk '{ print "0x"$5 }') >/tmp/temp_gdb_text_address.txt
  # Source .text address
  source /tmp/temp_gdb_text_address.txt
  #  Clean tempfile
  shell rm -f /tmp/temp_gdb_text_address.txt
  # Load symbol table
  add-symbol-file $arg0 $text_address
end

#python
## Note: Replace "readelf" with path to binary if it is not in your PATH.
#READELF_BINARY = 'readelf'

#class AddSymbolFileAuto (gdb.Command):
    #"""Load symbols from FILE, assuming FILE has been dynamically loaded (auto-address).
#Usage: add-symbol-file-auto FILE [-readnow | -readnever]
#The necessary starting address of the file's text is resolved by 'readelf'."""
    #def __init__(self):
        #super(AddSymbolFileAuto, self).__init__("add-symbol-file-auto", gdb.COMMAND_FILES)

    #def invoke(self, solibpath, from_tty):
        #from os import path
        #self.dont_repeat()
        #if os.path.exists(solibpath) == False:
            #print ("{0}: No such file or directory." .format(solibpath))
            #return
        #offset = self.get_text_offset(solibpath)
        #gdb_cmd = "add-symbol-file %s %s" % (solibpath, offset)
        #gdb.execute(gdb_cmd, from_tty)

    #def get_text_offset(self, solibpath):
        #import subprocess
        #elfres = subprocess.check_output([READELF_BINARY, "-WS", solibpath])
        #for line in elfres.splitlines():
            #if "] .text " in line:
                #return "0x" + line.split()[4]
        #return ""  # TODO: Raise error when offset is not found?

    #def complete(self, text, word):
        #return gdb.COMPLETE_FILENAME

#AddSymbolFileAuto()
#end
