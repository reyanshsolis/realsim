#!/bin/bash
echo " Requirement: Ubuntu 18.04 | x86"
echo "This script will install - "
echo "1. Git | terminator | openssh | exFAT utils | tmux | Unzip | Sublime"
echo "2. ROS Melodic"
echo "3. Dependencies"
echo "4. OpenCV"
echo "5. ceres-solver"
echo "6. PCL"
echo "7. librealsense"
echo "8. ROS Packages for - realsense | VINS - Mono and Fusion | MAVROS | Octomap | Geographiclib"
echo "9. QGroundControl"
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
sudo apt-get install git terminator openssh-server exfat-fuse exfat-utils tmux redshift -y
sudo apt-get install -y zip unzip

# Sublime-Text
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt-get update
sudo apt-get install sublime-text -y


################ ROS melodic INSTALLATION ###################

#ros-melodic-installation 
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'

## Comment the following line if behind a proxy server
sudo apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654

# If behind a proxy server uncomment the line below and comment the line above
#curl -sSL 'http://keyserver.ubuntu.com/pks/lookup?op=get&search=0xC1CF6E31E6BADE8868B172B4F42ED6FBAB17C654' | sudo apt-key add -

sudo apt-get update
sudo apt-get install -y ros-melodic-desktop-full

echo "source /opt/ros/melodic/setup.bash" >> ~/.bashrc
source ~/.bashrc

sudo apt install -y python-catkin-tools python-rosdep python-rosinstall python-rosinstall-generator python-wstool build-essential

sudo rosdep init
rosdep update
############################################################


################ Basic Dependencies ########################
sudo apt-get install -y build-essential cmake libgoogle-glog-dev libatlas-base-dev libeigen3-dev libsuitesparse-dev

sudo apt-get install gcc g++
sudo apt-get install -y python-dev python-numpy python3-dev python3-numpy python3-pip
sudo apt-get install -y libavcodec-dev libavformat-dev libswscale-dev
sudo apt-get install -y libgstreamer-plugins-base1.0-dev libgstreamer1.0-dev
sudo apt-get install -y libgtk2.0-dev
# sudo apt-get install libgtk-3-dev
sudo apt-get install -y libpng-dev libjpeg-dev libopenexr-dev libtiff-dev libwebp-dev

sudo apt-get install -y git libssl-dev libusb-1.0-0-dev pkg-config libgtk-3-dev
sudo apt-get install -y libglfw3-dev libgl1-mesa-dev libglu1-mesa-dev


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
cd $HOME

############ CERES INSTALLTION #############################
cp -R $BASE/include/ceres-solver-1.14.0.tar.gz $HOME/packages
cd $HOME/packages
tar zxf ceres-solver-1.14.0.tar.gz
mkdir ceres-bin
cd ceres-bin
cmake ../ceres-solver-1.14.0
make -j3
make install
cd $HOME

############ PCL INSTALLATION ###############################

#cp -R $BASE/include/pcl-pcl-1.10.1 $HOME/packages
#cd $HOME/packages/pcl-pcl-1.10.1
#mkdir build
#cd build
#cmake ../ -DCMAKE_BUILD_TYPE=Release
#make -j4
#sudo make install
#cd $HOME

########## librealsense ####################################

#cp -R $BASE/include/*** $HOME/packages
cd $HOME/packages
wget -P "https://github.com/IntelRealSense/librealsense/archive/master.zip"
unzip librealsense-master.zip
cd librealsense
mkdir build && cd build
cmake ../ -DCMAKE_BUILD_TYPE=Release
sudo make uninstall && make clean && make && sudo make install
cd $HOME

#############################################################


# Some ROS Packages
sudo apt install ros-melodic-rgbd-launch -y
sudo apt-get install ros-melodic-mavros ros-melodic-mavros-extras -y
sudo apt install -y libpcl1 ros-melodic-octomap-* ros-melodic-yaml-*

sudo -H apt-get install -y ros-melodic-joy
sudo -H apt-get install -y ros-melodic-octomap-ros


# MAVROS Geographiclib Setup 
wget https://raw.githubusercontent.com/mavlink/mavros/master/mavros/scripts/install_geographiclib_datasets.sh
chmod +x install_geographiclib_datasets.sh
sudo ./install_geographiclib_datasets.sh

# QGroundControl
cp -R $BASE/include/UAV_tools/QGroundControl.AppImage $HOME
sudo chmod +x $HOME/QGroundControl.AppImage

####### DOUBTFULL PACKAGES #################################
sudo add-apt-repository ppa:bzindovic/suitesparse-bugfix-1319687
sudo apt-get -y update
sudo apt-get -y install libsuitesparse-dev


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
##############################################################

# finishing touch
sudo usermod -a -G dialout $USER
sudo reboot

