#!/bin/bash

# Clone Hive repo
git clone https://github.com/yupferris/Hive.git
cd Hive
git submodule init
git submodule update
cd ..

# Install mono and Rx libraries
apt-get -y install mono-runtime
apt-get -y install libmono-system-reactive-*

# Set performance scaling governors for all cpu's on reboot
apt-get -y install cpufrequtils
sed -i 's/^GOVERNOR=.*/GOVERNOR="performance"/' /etc/init.d/cpufrequtils

# Start Hive on reboot
sed -i -e '$i \/home/pi/Hive/HiveServer/deploy/start-pi.sh /home/pi/Hive\n' /etc/rc.local

# Speed up boot time and remove rpi logo
printf '#yolo\nforce_turbo=1\n' >> /boot/config.txt
sed -i '1 s/$/ loglevel=0 logo.nologo/' /boot/cmdline.txt

# Reboot to test
reboot
