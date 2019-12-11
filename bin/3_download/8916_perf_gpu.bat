adb root 
adb wait-for-device
adb remount
adb wait-for-device
adb shell setenforce 0 

# GPU Performance
adb shell "echo 1 > /sys/class/kgsl/kgsl-3d0/force_rail_on" 
adb shell "echo 1 > /sys/class/kgsl/kgsl-3d0/force_clk_on" 
adb shell "echo 1 > /sys/class/kgsl/kgsl-3d0/force_bus_on" 
adb shell "echo 10000000 > /sys/class/kgsl/kgsl-3d0/idle_timer" 
adb shell "echo performance > /sys/class/kgsl/kgsl-3d0/devfreq/governor" 

 채규태[주임연구원] 님의 말 :  
아 있나보네
 명혁[주임연구원] 님의 말 :  
adb shell "while true; do input swipe 50 200 50 1800 5000; input swipe 50 1800 50 200 5000; done;"
 채규태[주임연구원] 님의 말 :  
adb shell input swipe 500 1700 500 1200 200