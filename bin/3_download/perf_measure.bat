adb wait-for-device
adb root 
adb wait-for-device
adb shell setenforce 0 
adb wait-for-device
adb remount

adb shell "export PATH=/data/busybox:$PATH; PREV_FPS=0; NUM=0; while true; do CUR_FPS=`cat /d/mdp/stat | grep intf2 | awk '{ print $3 }'`; FPS=`expr $CUR_FPS - $PREV_FPS`; for NUM in 'cpu0' 'cpu1' 'cpu2' 'cpu3' 'cpu4' 'cpu5' 'cpu6' 'cpu7'; do echo -n $NUM=; if [ -e /sys/devices/system/cpu/$NUM/cpufreq/cpuinfo_cur_freq ]; then cat /sys/devices/system/cpu/$NUM/cpufreq/cpuinfo_cur_freq; echo -n $NUM; echo -n "max="; cat /sys/devices/system/cpu/$NUM/cpufreq/cpuinfo_max_freq; else echo; fi; done; echo -n 'bimc_clk='; cat /sys/kernel/debug/clk/gcc_bimc_clk/measure; echo -n 'gpu_thermal_level='; cat /sys/class/kgsl/kgsl-3d0/thermal_pwrlevel; echo -n 'gpu_clk='; cat /sys/class/kgsl/kgsl-3d0/gpuclk; echo -n 'gfx3d_clk='; cat /d/clk/oxili_gfx3d_clk/measure;  echo -n 'xo_therm='; cat /sys/class/hwmon/hwmon0/device/xo_therm; echo -n 'battery_therm='; cat /sys/class/hwmon/hwmon0/device/batt_therm; echo -n 'dynamic_fps='; cat /sys/class/graphics/fb0/dynamic_fps; echo -n 'FPS='; echo $FPS; echo; PREV_FPS=$CUR_FPS; sleep 0.95; done"
