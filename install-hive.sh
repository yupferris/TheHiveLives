#!/bin/bash

# Install mono
apt-get install mono-complete

# Clone Hive repo and checkout server branch
git clone https://github.com/yupferris/Hive.git
cd Hive
git submodule init
git submodule update
git checkout feature-HiveServer
cd ..

# Start Hive on reboot
sed -i -e '$i \/home/pi/Hive/HiveServer/deploy/start-pi.sh /home/pi/Hive\n' /etc/rc.local

# Speed up boot time and remove rpi logo
printf '#yolo\nforce_turbo=1\n' >> /boot/config.txt
printf 'loglevel=0 logo.nologo' >> /boot/cmdline.txt

# Reboot to test
reboot
