adb root 
adb wait-for-device
adb remount
adb wait-for-device
adb shell setenforce 0 

# DDR Performance
adb shell "echo 22 > /d/msm-bus-dbg/shell-client/mas"
adb shell "echo 512 > /d/msm-bus-dbg/shell-client/slv"
adb shell "echo 0 > /d/msm-bus-dbg/shell-client/ab"
adb shell "echo 6400000000 > /d/msm-bus-dbg/shell-client/ib"
adb shell "echo 1 > /d/msm-bus-dbg/shell-client/update_request"

# CPU performance
adb shell stop thermal-engine
adb shell stop thermald
adb shell "echo 1 > /sys/devices/system/cpu/cpu0/online" 
adb shell "echo 1 > /sys/devices/system/cpu/cpu1/online" 
adb shell "echo 1 > /sys/devices/system/cpu/cpu2/online" 
adb shell "echo 1 > /sys/devices/system/cpu/cpu3/online" 

adb shell "echo performance > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor"
adb shell "echo performance > /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor"
adb shell "echo performance > /sys/devices/system/cpu/cpu2/cpufreq/scaling_governor"
adb shell "echo performance > /sys/devices/system/cpu/cpu3/cpufreq/scaling_governor"

adb shell "echo 1209600 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq"
adb shell "echo 1209600 > /sys/devices/system/cpu/cpu1/cpufreq/scaling_min_freq"
adb shell "echo 1209600 > /sys/devices/system/cpu/cpu2/cpufreq/scaling_min_freq"
adb shell "echo 1209600 > /sys/devices/system/cpu/cpu3/cpufreq/scaling_min_freq"


sleep 1 
adb shell "echo performance > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor" 