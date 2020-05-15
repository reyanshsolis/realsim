#!/bin/bash

echo "This script will install - "
echo "1. ROS Melodic"
echo "2. librealsense"
echo "3. ceres-solver"
echo "4. ROS Packages for - bluefox | xsens-imu | realsense | VINS - Mono and Fusion | MAVROS | Octomap"
echo "5. Utilities - Sublime Text | Terminator | openssh | exFAT utils | tmux"
echo "6. MatrixVision Impact Driver for MonoCam"
echo -e '\n'
read -p "Press enter to continue...."

# paths and variables
BASE=$(pwd)

sudo apt-get update
sudo apt-get upgrade

# Ubuntu Config
echo "Removing modemmanager"
sudo apt-get remove modemmanager -y

# install some ubuntu basic utilities
sudo apt-get install git terminator openssh-server exfat-fuse exfat-utils tmux -y
# Sublime-Text
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt-get update
sudo apt-get install sublime-text -y


################ ROS KINETIC INSTALLATION ###################

#ros-kinetic-installation 
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'

## Comment the following line if behind a proxy server
sudo apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654

# If behind a proxy server uncomment the line below and comment the line above
#curl -sSL 'http://keyserver.ubuntu.com/pks/lookup?op=get&search=0xC1CF6E31E6BADE8868B172B4F42ED6FBAB17C654' | sudo apt-key add -

sudo apt-get update
sudo apt-get install ros-kinetic-desktop-full

echo "source /opt/ros/kinetic/setup.bash" >> ~/.bashrc
source ~/.bashrc

sudo apt install python-catkin-tools python-rosdep python-rosinstall python-rosinstall-generator python-wstool build-essential

sudo rosdep init
rosdep update
############################################################


################ Basic Dependencies ########################
sudo apt-get install build-essential
sudo apt-get install cmake
sudo apt-get install libgoogle-glog-dev
sudo apt-get install libatlas-base-dev
sudo apt-get install libeigen3-dev
sudo apt-get install libsuitesparse-dev

sudo apt-get install gcc g++
sudo apt-get install python-dev python-numpy
sudo apt-get install python3-dev python3-numpy python3-pip
sudo apt-get install libavcodec-dev libavformat-dev libswscale-dev
sudo apt-get install libgstreamer-plugins-base1.0-dev libgstreamer1.0-dev
sudo apt-get install libgtk2.0-dev
# sudo apt-get install libgtk-3-dev
sudo apt-get install libpng-dev
sudo apt-get install libjpeg-dev
sudo apt-get install libopenexr-dev
sudo apt-get install libtiff-dev
sudo apt-get install libwebp-dev

sudo apt-get install git libssl-dev libusb-1.0-0-dev pkg-config libgtk-3-dev


sudo add-apt-repository ppa:bzindovic/suitesparse-bugfix-1319687
sudo apt-get update
sudo apt-get install libsuitesparse-dev


pip install --upgrade pip
pip3 install --user toml
pip3 install --user pyyaml
pip3 install --user packaging


# Required python packages
sudo apt-get install python-argparse python-empy python-toml python-numpy python-dev python-pip -y
sudo -H pip install --upgrade pip
sudo -H pip install pandas jinja2 pyserial pyyaml
# optional python tools
sudo -H pip install pyulog

##########################################################

######### PACKAGES INSTALLTION ###########################


mkdir -p $HOME/packages

########### OPENCV SOURCE INSTALLATION ####################
cd $HOME
git clone https://github.com/opencv/opencv.git
cd opencv
mkdir build
cd build
cmake ../
make
sudo make install


############ CERES INSTALLTION #############################
cp -R $BASE/include/ceres-solver-1.14.0.tar.gz $HOME/packages
cd $HOME/packages
tar zxf ceres-solver-1.14.0.tar.gz
mkdir ceres-bin
cd ceres-bin
cmake ../ceres-solver-1.14.0
make -j3
make install

############ PCL INSTALLATION ###############################

cp -R $BASE/include/pcl-pcl-1.10.1 $HOME/packages
cd $HOME/packages/pcl-pcl-1.10.1
mkdir build
cd build
cmake ../
make -j4
sudo make install

#############################################################


# Some ROS Packages
sudo apt install ros-kinetic-rgbd-launch -y
sudo apt-get install ros-kinetic-mavros ros-kinetic-mavros-extras -y
sudo apt install libpcl1 ros-kinetic-octomap-* ros-kinetic-yaml-*


# MAVROS Geographiclib Setup 
wget https://raw.githubusercontent.com/mavlink/mavros/master/mavros/scripts/install_geographiclib_datasets.sh
chmod +x install_geographiclib_datasets.sh
sudo ./install_geographiclib_datasets.sh

# QGroundControl
cp -R $BASE/include/UAV_tools/QGroundControl.AppImage $HOME
sudo chmod +x $HOME/QGroundControl.AppImage


# finishing touch
sudo usermod -a -G dialout $USER
sudo reboot

