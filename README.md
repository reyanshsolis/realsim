# Real-Sim 

## 1. Introduction

Real-Sim is a Navigation Localisation and Mapping pipeline for Autonomous UAVs. 
It is based on PX4-Firmware, Mavlink and MavROS. It can be used for integrating your algorithms on a Gazebo Simulation UAV [like IRIS], and directly implement the same on Hardware without any modification to the code. 

## Status
    Work under progress…
## 2. How to Setup
1. Open the terminal and clone the repository:
     git clone https://github.com/reyanshsolis/realsim.git
2. Select the script you want to use:
        Installation Groups: 
        A. Git | terminator | openssh | exFAT utils | tmux | Unzip | Sublime
        B. ROS Melodic - Full
        C. Required Dependencies
        D. Ceres-solver
        E. librealsense
        F. ROS Packages for - realsense | VINS - Mono and Fusion | MAVROS | Octomap | Geographiclib
        G. QGroundControl
        H. OpenCV
        I. PCL
        J. PX4-Firmware

a. ubuntu_freshinstallation_melodic.sh

        This will install groups A. to I. 

b. px4-firmware.sh

        This is install and configure PX4/Firmware
    

**Fresh Installation on Ubuntu 18.04:**
**How to use the scripts**
To use the scripts:

1. Make the user a member of the group "dialout" (this only has to be done once):
    1. Open a terminal and enter the following command:
    sudo usermod -a -G dialout $USER
    1. Logout and login again (the change is only made after a new login).
2. make sure you are in the package root directory
3. Run the script in a bash shell (e.g. to run **ubuntu_sim.sh**):
    source ubuntu_sim.sh
1. Acknowledge any prompts as the scripts progress.
## **Permission Setup**
> Never ever fix permission problems by using `sudo`. It will create more permission problems in the process and require a system re-installation to fix them.

The user needs to be part of the group "dialout":

    sudo usermod -a -G dialout $USER

Then logout and login again (the change is only made after a new login).


## 3. Launch in Simulation


## 4. Configure Joy_Node


## 5. Localisation

**5.1 Configure VINS-Fusion** 


## 6. Mapping

**6.1 Octomap**


## 7. Navigation


## 8. Running on Hardware 

