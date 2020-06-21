#!/bin/bash

echo "This script will install - "
echo " PX4 Avoidance package and it's dependencies"
echo " If Gazebo launch successfully at end of this script, "
echo " Close it using Ctrl+C"
echo " If catkin build fails in between, follow the error! :("
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
cd ~/catkin_ws 
catkin init
catkin build
rsync -a $BASE/src/ ~/catkin_ws/src/
cd ~/catkin_ws
rosdep install --from-paths src --ignore-src -r -y
catkin build
echo "source ~/catkin_ws/devel/setup.bash" >> ~/.bashrc
source ~/.bashrc

rosdep install --from-paths src --ignore-src -r -y
catkin build 
source ~/.bashrc

cd ~
git clone -b v1.10.1 https://github.com/PX4/Firmware.git --recursive
cd ~/Firmware
./Tools/setup/ubuntu.sh --no-sim-tools --no-nuttx
sudo apt install gstreamer1.0-plugins-bad gstreamer1.0-plugins-base gstreamer1.0-plugins-good gstreamer1.0-plugins-ugly libgstreamer-plugins-base1.0-dev

export QT_X11_NO_MITSHM=1
make px4_sitl_default gazebo