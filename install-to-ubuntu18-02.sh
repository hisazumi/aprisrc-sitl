HOME=/home/ubuntu

# update basic packages
sudo apt-get update \
    && sudo apt-get upgrade -y \
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
    	openjdk-8-jre \
        git

git config --global url."https://".insteadOf git://

# Intall ROS

echo "deb http://packages.ros.org/ros/ubuntu bionic main" | sudo tee /etc/apt/sources.list.d/ros-latest.list \
    && sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654 \
    && sudo apt-get update -y \
    && sudo apt-get upgrade -y \
    && sudo apt-get install -y ros-melodic-desktop-full python-catkin-tools

# create catkin workspace and clone iq_sim, iq_gnc
cd $HOME \
    && mkdir catkin_ws && cd catkin_ws \
    && catkin init \
    && mkdir src && cd src \
    && git clone https://github.com/Intelligent-Quads/iq_sim \
    && git clone https://github.com/Intelligent-Quads/iq_gnc

# ardupilot_gazebo and install geographiclib dataset
cd $HOME \
	&& git clone https://github.com/khancyr/ardupilot_gazebo \
	&& cd ardupilot_gazebo \
	&& mkdir build && cd build \
	&& cmake .. \
	&& make -j4 \
	&& sudo make install \
	&& cd $HOME \
	&& wget https://raw.githubusercontent.com/mavlink/mavros/master/mavros/scripts/install_geographiclib_datasets.sh \
	&& chmod +x ./install_geographiclib_datasets.sh \
	&& ./install_geographiclib_datasets.sh

# download ardupilot
cd $HOME \
    && git clone https://github.com/ArduPilot/ardupilot \
    && cd ardupilot && git submodule update --init --recursive

# change user to install ArduPilot env
SKIP_AP_EXT_ENV=1 SKIP_AP_GRAPHIC_ENV=1 SKIP_AP_COV_ENV=1 SKIP_AP_GIT_CHECK=1  $HOME/ardupilot/Tools/environment_install/install-prereqs-ubuntu.sh -y

# install BridgePoint
#USER root
#ENV FID=1pKfnoVFFEykcXuDG26_isCIbAfSxYMXD
#RUN cd /opt \
#  	&& CONFIRM=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate "https://docs.google.com/uc?export=download&id=$FID" -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p') \#
#	&& echo $CONFIRM \
#	&& wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$CONFIRM&id=$FID" -O bp.zip \
#	&& rm -rf /tmp/cookies.txt \
#	&& unzip bp.zip \
#	&& rm bp.zip

# Create start shell on root Desktop
#mkdir -f $HOME/Desktop

# Gazebo Launcher
echo "#!/bin/bash" >> $HOME/Desktop/simulator.sh \
    && echo "" >> $HOME/Desktop/simulator.sh \
    && echo "gazebo --verbose worlds/iris_arducopter_runway.world" >> $HOME/Desktop/simulator.sh \
    && chmod +x $HOME/Desktop/simulator.sh

# SITL Launcher
echo "#!/bin/bash" >> $HOME/Desktop/sitl.sh \
    && echo "" >> $HOME/Desktop/sitl.sh \
    && echo 'source $HOME/.bashrc' >> $HOME/Desktop/sitl.sh \
    && echo 'cd $HOME/ardupilot/ArduCopter' >> $HOME/Desktop/sitl.sh \
    && echo '../Tools/autotest/sim_vehicle.py -f gazebo-iris --console --map' >> $HOME/Desktop/sitl.sh \
    && chmod +x $HOME/Desktop/sitl.sh

# BridgePoint Launcher
# ln -s /opt/BridgePoint/bridgepoint ~/Desktop/

# setup
echo "source /opt/ros/melodic/setup.bash" >> $HOME/.bashrc \
    && echo 'source /usr/share/gazebo/setup.sh' >> ~/.bashrc \
    && echo 'source $HOME/catkin_ws/devel/setup.bash' >> $HOME/.bashrc \
    && echo 'export PATH=$HOME/.local/bin:/opt/BridgePoint:$PATH' >> $HOME/.bashrc
