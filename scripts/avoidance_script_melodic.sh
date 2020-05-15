#!/bin/bash

echo "This script will install - "
echo " PX4 Avoidance package and it's dependencies"
echo -e '\n'
read -p "Press enter to continue...."

# paths and variables
BASE=$(pwd)

sudo apt-get update -y
sudo apt-get upgrade -t

# Ubuntu Config
echo "Removing modemmanager"
sudo apt-get remove modemmanager -y


# Some ROS Packages
sudo apt install ros-melodic-rgbd-launch -y
sudo apt-get install ros-melodic-mavros ros-melodic-mavros-extras -y
sudo apt install libpcl1 ros-melodic-octomap-* -y
sudo apt install ros-melodic-octomap -y

sudo apt install -y ros-melodic-stereo-image-proc ros-melodic-image-view

sudo apt install gstreamer1.0-plugins-bad gstreamer1.0-plugins-base gstreamer1.0-plugins-good gstreamer1.0-plugins-ugly libgstreamer-plugins-base1.0-dev

rosdep init
rosdep update
sudo apt install python-catkin-tools -y
mkdir -p ~/catkin_ws/src
cd ~/catkin_ws/src
git clone -b stable https://github.com/PX4/avoidance.git
rosdep install --from-paths src --ignore-src -r -y
catkin build -w ~/catkin_ws --cmake-args -DCMAKE_BUILD_TYPE=Release
echo "source ~/catkin_ws/devel/setup.bash" >> ~/.bashrc
source ~/.bashrc

rosdep install --from-paths src --ignore-src -r -y
catkin build -w ~/catkin_ws --cmake-args -DCMAKE_BUILD_TYPE=Release
source ~/.bashrc

cd ~
git clone https://github.com/PX4/Firmware.git --recursive
cd ~/Firmware

./Tools/setup/ubuntu.sh

sudo apt install gstreamer1.0-plugins-bad gstreamer1.0-plugins-base gstreamer1.0-plugins-good gstreamer1.0-plugins-ugly libgstreamer-plugins-base1.0-dev

# finishing touch
#sudo usermod -a -G dialout $USER
#sudo reboot

