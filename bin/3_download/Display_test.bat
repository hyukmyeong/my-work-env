adb wait-for-devices
adb root
adb wait-for-devices
adb push Display_test.sh /data/
adb shell "chmod 777 /data/Display_test.sh"
REM adb shell "sh /data/Display_test.sh &"