sudo apt-get update \
    && sudo apt-get install -q -y \
        software-properties-common \
        wget curl git cmake cmake-curses-gui \
        libboost-all-dev \
        libflann-dev \
    	libgsl0-dev \
        libgoogle-perftools-dev \
        libeigen3-dev \
    	openssl \
        dirmngr \
        gnupg2 \
        lsb-release \
        apt-utils \
        rsync \
	    openjdk-11-jre

# Intall ROS

echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/ros-latest.list \
    && curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add - \
    && sudo apt-get update -y \
    && sudo apt-get upgrade -y \
    && sudo apt-get install -y \
        ros-noetic-ros-base \
        ros-noetic-mavros ros-noetic-mavros-extras ros-noetic-mavlink \
        python3-osrf-pycommon python3-catkin-tools \
        python3-rosdep python3-rosinstall python3-rosinstall-generator python3-wstool build-essential \
    && rosdep init && rosdep update

wget https://raw.githubusercontent.com/mavlink/mavros/master/mavros/scripts/install_geographiclib_datasets.sh
sudo bash install_geographiclib_datasets.sh


# create catkin workspace and clone iq_sim, iq_gnc
cd $HOME \
    && mkdir catkin_ws && cd catkin_ws \
    && catkin init \
    && mkdir src && cd src \
    && git clone https://github.com/Intelligent-Quads/iq_sim \
    && git clone https://github.com/Intelligent-Quads/iq_gnc

# download ardupilot
cd $HOME \
    && git clone https://github.com/ArduPilot/ardupilot \
    && cd ardupilot && git submodule update --init --recursive

SKIP_AP_EXT_ENV=1 SKIP_AP_GRAPHIC_ENV=1 SKIP_AP_COV_ENV=1 SKIP_AP_GIT_CHECK=1 $HOME/ardupilot/Tools/environment_install/install-prereqs-ubuntu.sh -y 

# cleanup
rm -f install_geographiclib_datasets.sh

# setup .bashrc
echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc
echo "source  ~/catkin_ws/devel/setup.bash" >> ~/.bashrc


