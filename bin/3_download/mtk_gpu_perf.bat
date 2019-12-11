adb wait-for-device
adb root
adb wait-for-device

adb shell "echo 0 > /proc/gpufreq/gpufreq_state"
adb shell "echo 448500 > /proc/gpufreq/gpufreq_opp_freq"

adb shell "echo 0 > /proc/mali/dvfs_enable"
adb shell "echo 0 > /sys/module/ged/parameters/gpu_dvfs_enable"
adb shell "echo 448500 > /sys/module/ged/parameters/gpu_bottom_freq"

REM adb shell "echo \"2 448500\" > /d/ged/hal/current_freqency"
REM adb shell "cat /d/ged/hal/current_freqency

adb shell "cat /proc/gpufreq/gpufreq_state"
adb shell "cat /proc/gpufreq/gpufreq_opp_freq"

adb shell "cat /proc/mali/dvfs_enable"
adb shell "cat /sys/module/ged/parameters/gpu_dvfs_enable"
adb shell "cat /sys/module/ged/parameters/gpu_bottom_freq"