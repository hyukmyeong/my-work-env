adb wait-for-device
adb root 
adb wait-for-device
adb shell setenforce 0 
adb wait-for-device
adb remount

adb shell "REV_FPS=0; NUM=0; while true; do CUR_FPS=`cat /sys/devices/bus/7f000000.MTKFB/graphics/fb0/vfps | sed -n 4p | tr "fps_cnt=" "0"`; FPS=`expr $CUR_FPS - $PREV_FPS`; for NUM in 'cpu0' 'cpu1' 'cpu2' 'cpu3' 'cpu4' 'cpu5' 'cpu6' 'cpu7'; do echo -n $NUM=; if [ -e /sys/devices/system/cpu/$NUM/cpufreq/cpuinfo_cur_freq ]; then cat /sys/devices/system/cpu/$NUM/cpufreq/cpuinfo_cur_freq; echo -n $NUM; echo -n "max="; cat /sys/devices/system/cpu/$NUM/cpufreq/cpuinfo_max_freq; else echo; fi; done; echo -n 'FPS='; echo $FPS; echo; PREV_FPS=$CUR_FPS; sleep 0.95; done"
