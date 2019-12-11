#!/system/bin/sh
i=0
sleep 2
while [ $i -lt 100000 ]
do
	i=`echo $(($i+1))`

	echo "--------------------------------------------"
	echo "Display On/Off Test ... $i times done"
	input keyevent POWER
	sleep 2
done
