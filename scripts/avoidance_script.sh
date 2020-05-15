#!/bin/bash

echo "This script will install - "
echo " PX4 Avoidance package"
echo -e '\n'
read -p "Press enter to continue...."

# paths and variables
BASE=$(pwd)

sudo apt-get update
sudo apt-get upgrade

# Ubuntu Config
echo "Removing modemmanager"
sudo apt-get remove modemmanager -y


# Some ROS Packages
sudo apt install ros-kinetic-rgbd-launch -y
sudo apt-get install ros-kinetic-mavros ros-kinetic-mavros-extras -y
sudo apt install libpcl1 ros-kinetic-octomap-* ros-kinetic-yaml-*
sudo apt install ros-kinetic-stereo-image-proc ros-kinetic-image-view

sudo apt install gstreamer1.0-plugins-bad gstreamer1.0-plugins-base gstreamer1.0-plugins-good gstreamer1.0-plugins-ugly libgstreamer-plugins-base1.0-dev



rosdep init
rosdep update
sudo apt install python-catkin-tools
mkdir -p ~/catkin_ws/src
cd ~/catkin_ws/src
git clone -b stable https://github.com/PX4/avoidance.git
catkin build -w ~/catkin_ws --cmake-args -DCMAKE_BUILD_TYPE=Release
echo "source ~/catkin_ws/devel/setup.bash" >> ~/.bashrc
source ~/.bashrc
cd ~
git clone https://github.com/PX4/Firmware.git --recursive
cd ~/Firmware


# finishing touch
#sudo usermod -a -G dialout $USER
#sudo reboot

