#!/bin/sh
__CRASH=~/crash

__REQUIRED_FILES="EBICS0.BIN EBI1CS1.BIN vmlinux"
# MUST start from ~/bin
__REQUIRED_LINKS="arm-linux-androideabi-readelf gen_vmcore"

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

function doNothing()
{
	echo "" > /dev/null
}

function unlinkRequiredLinks()
{
        for link in $__REQUIRED_LINKS
        do
                if [ -f $link ] ; then
			echo "> unlink $link"
                        rm $link
                fi
        done
}

function clearAll()
{
        unlinkRequiredLinks

        if [ -f vmcore ] ; then
		echo "> rm vmcore"
                rm vmcore
        fi
}

# parse command line option
__preClearFunc=doNothing
__postClearFunc=doNothing
for arg in $@
do
	if [ $arg = "-clear" ] ;then
		clearAll
		exit 0
	elif [ $arg = "-prec" ] ; then
		__preClearFunc=unlinkRequiredLinks
        elif [ $arg = "-postc" ] ; then
                __postClearFunc=unlinkRequiredLinks
	elif [ $arg = "-precall" ] ; then
		__preClearFunc=clearAll
        elif [ $arg = "-postcall" ] ; then
                __postClearFunc=clearAll
        elif [ $arg = "-help" ] ; then
                usage
                exit 0
        else
                echo "unkonwn command $arg"
        fi
done

# call pre clear function
$__preClearFunc

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
        	ln -s ~/bin/$link $link
	fi
done

# call gen_vmcore
if [ ! -f vmcore ] ; then
	if [ -f gen_vmcore ] ; then
		echo ""
		echo "#############################"
		echo "> Build vmcore"
		echo "#############################"
		echo ""
		gen_vmcore -p 0x80200000 -z 0x80000000 -e EBICS0.BIN@0x80000000@0x40000000 -e EBI1CS1.BIN@0xC0000000@0x40000000 -n 2
		echo ""
		echo "#############################"
		echo "> Building vmcore completed!!!"
		echo "#############################"
		echo ""
	fi
fi

# run crash
if [ -f vmcore ] ; then
	$__CRASH --no_elf_notes --no_panic --smp -m phys_base=0x80200000 -p 4096 vmcore vmlinux
fi

# call clear function
$__postClearFunc
