#!/bin/sh
__CRASH=~/bin/6_debugging/crash

__REQUIRED_FILES="DDRCS0.BIN DDRCS1.BIN vmlinux"
# MUST start from ~/bin
__REQUIRED_LINKS="arm-linux-androideabi-readelf gen_vmcore_8974"

# internal functions
function usage()
{
	echo "OPTION:"
	echo " -help    : show this usage message"
	echo " -clear   : remove links and vmcore"
	echo " -prec    : remove links before execution"
	echo " -postc   : remove links after execution"
	echo " -precall : -prec + remove vmcore becore execution"
	echo " -pstcall : -postc + remove vmcore after execution"
}

#function doNothing
#__postClearFunc=doNothing
#for arg in $@
#do
#       if [ $arg = "-clear" ] ;then
#		clearAll
#		exit 0
#       elif [ $arg = "-prec" ] ; then
#		__preClearFunc=unlinkRequiredLinks
#       elif [ $arg = "-postc" ] ; then
#                __postClearFunc=unlinkRequiredLinks
#       elif [ $arg = "-precall" ] ; then
#		__preClearFunc=clearAll
#       elif [ $arg = "-postcall" ] ; then
#                __postClearFunc=clearAll
#       elif [ $arg = "-help" ] ; then
#              usage
#              exit 0
#       else
#              echo "unkonwn command $arg"
#       fi
#done

# call pre clear function
#$__preClearFunc

# check required files
__missed=""
for file in $__REQUIRED_FILES
do
	if [ ! -f $file ] ; then
		__missed=$__missed" "$file
	fi
done

if ! test -z "$__missed"
then
	echo "REQUIRED FILES =$__missed"
	exit 0
fi

# add required link
for link in $__REQUIRED_LINKS
do
	if [ ! -f "$link" ] ; then
        	ln -s ~/bin/6_debugging/$link $link
	fi
done

# call gen_vmcore
if [ ! -f vmcore ] ; then
	if [ -f gen_vmcore_8974 ] ; then
		echo ""
		echo "#############################"
		echo "> Build vmcore"
		echo "#############################"
		echo ""
		./gen_vmcore_8974 -p 0x0 -z 0x80000000 -e DDRCS0.BIN@0x00000000@0x40000000 -e DDRCS1.BIN@0x40000000@0x40000000 -n 4
		echo ""
		echo "#############################"
		echo "> Building vmcore completed!!!"
		echo "#############################"
		echo ""
	fi
fi

# run crash
if [ -f vmcore ] ; then
	$__CRASH --no_elf_notes --no_panic --smp -m phys_base=0x00000000 -p 4096 vmcore vmlinux
fi

# call clear function
#$__postClearFunc