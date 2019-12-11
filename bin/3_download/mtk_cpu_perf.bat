adb wait-for-device
adb root
adb wait-for-device

adb shell "echo 0 > /proc/hps/enabled"

adb shell "echo 1 > /sys/devices/system/cpu/cpu0/online"
adb shell "echo 1 > /sys/devices/system/cpu/cpu1/online"
adb shell "echo 1 > /sys/devices/system/cpu/cpu2/online"
adb shell "echo 1 > /sys/devices/system/cpu/cpu3/online"
adb shell "echo 1 > /sys/devices/system/cpu/cpu4/online"
adb shell "echo 1 > /sys/devices/system/cpu/cpu5/online"
adb shell "echo 1 > /sys/devices/system/cpu/cpu6/online"
adb shell "echo 1 > /sys/devices/system/cpu/cpu7/online"
adb shell "echo 1300000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq"
adb shell "echo 1300000 > /sys/devices/system/cpu/cpu1/cpufreq/scaling_min_freq"
adb shell "echo 1300000 > /sys/devices/system/cpu/cpu2/cpufreq/scaling_min_freq"
adb shell "echo 1300000 > /sys/devices/system/cpu/cpu3/cpufreq/scaling_min_freq"
adb shell "echo 1300000 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq"
adb shell "echo 1300000 > /sys/devices/system/cpu/cpu5/cpufreq/scaling_min_freq"
adb shell "echo 1300000 > /sys/devices/system/cpu/cpu6/cpufreq/scaling_min_freq"
adb shell "echo 1300000 > /sys/devices/system/cpu/cpu7/cpufreq/scaling_min_freq"