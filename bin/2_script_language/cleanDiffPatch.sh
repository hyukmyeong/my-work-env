#!/bin/bash

############################################################################
# == Name    : Meaningful source code extractor (git diff)                 # 
# == Date    : 2012.3.3 SAT                                                # 
# == Composer: Hyuk Myeong                                                 #
# == Email   : hyuk.myeong@lge.com                                         #
# == Phone   : 82-10-2247-0942                                             #
# == Company : P7Sil. SW2Team 1Part MC Company, LGE corporation            #
# == Location: Seoul, Korea                                                #
############################################################################

############################################################################
# Global Variable                                                          #
############################################################################
declare -i nI
declare -i nJ
declare -i COUNT=0
declare -a DATA=( " " " " " " " " )

declare TEMP
declare MODE_BODY="UNVALID"
declare MODE_ENTRANCE="UNVALID"
declare TEMP_FILE="temporary.txt"
declare OUTPUT_FILE="result.txt" # file which you want to save the result 


############################################################################
# General Functions                                                        #
############################################################################
function DATA_SORT()
{
	for nI in `seq 3`
	do
		let "nJ = nI - 1"
		DATA[$nJ]=${DATA[$nI]} 
	done
	
	DATA[3]=$TEMP
}

function DATA_WRITE()
{
	if [ "$MODE_ENTRANCE" == "VALID" ] && [ "$MODE_BODY" == "VALID" ]
	then
		MODE_ENTRANCE="UNVALID"
		
		echo "${DATA[0]}" >>$OUTPUT_FILE
		echo "${DATA[1]}" >>$OUTPUT_FILE
		echo "${DATA[2]}" >>$OUTPUT_FILE
		echo "${DATA[3]}" >>$OUTPUT_FILE

	elif [ "$MODE_ENTRANCE" == "UNVALID" ] && [ "$MODE_BODY" == "VALID" ]
	then
		if [ "`cat $TEMP_FILE`" == "diff" ]
		then
			MODE_BODY="UNVALID"
		else
			echo $TEMP >>$OUTPUT_FILE
		fi			
	fi
}


############################################################################
# Basic Functions                                                          #
############################################################################
function CONSTRUCTOR()
{
 	touch "$OUTPUT_FILE" 
	chmod 777 "$OUTPUT_FILE"

	if [ -e "$OUTPUT_FILE" ]
	then
		echo -n "result\.txt is already exists, do you want to remove it? "
		read -p "(Y/N) : " input
	
		if [ "$input" == "Y" ] || [ "$input" == "y" ]
		then
			echo "You entered Y, Proceed" 
			rm "$OUTPUT_FILE" 
		elif [ "$input" == "N" ] || [ "$input" == "n" ]
		then
			echo "You entered N, Bye" 
			exit 0
		else
			echo "Input error"	
			exit 1
		fi
	fi
}

function DESTRUCTOR()
{
	rm "$TEMP_FILE" 
	exit 0
}

function MAIN()
{
	while read TEMP 
	do
		echo $TEMP | awk -F' ' '{ print $1 }' >$TEMP_FILE

		if [ "`cat $TEMP_FILE`" == "index" ]
		then
			MODE_ENTRANCE="VALID"
			MODE_BODY="VALID"				
		fi

	
		if [ "$COUNT" -lt 4 ] 
		then
			DATA_SORT[$COUNT]=$TEMP
		else
			DATA_SORT		
		fi 

		DATA_WRITE
	
  	let "COUNT = COUNT + 1"
	done<$1
}


############################################################################
# Main                                                                     #
############################################################################
CONSTRUCTOR
MAIN $1
DESTRUCTOR
