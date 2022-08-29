FROM dorowu/ubuntu-desktop-lxde-vnc:focal-arm64

# WORKDIR /home/ubuntu

# add user 'ardupilot'
RUN useradd -U -d /home/ubuntu ubuntu && \
   usermod -G users ubuntu

RUN echo "ubuntu ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/ubuntu
RUN chmod 0440 /etc/sudoers.d/ubuntu

# update basic packages
# rm /etc/apt/sources.list.d/google-chrome.list \
RUN apt-get update \
#     && apt-get upgrade -y \
    && apt-get install -q -y \
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
	    openjdk-8-jre

# Intall ROS

RUN echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list \
    && curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add - \
    && apt-get update -y \
    && apt-get upgrade -y \ 
    && apt-get install -y \
        ros-noetic-ros-base \
        ros-noetic-mavros ros-noetic-mavros-extras ros-noetic-mavlink \
        python3-osrf-pycommon python3-catkin-tools \
        python3-rosdep python3-rosinstall python3-rosinstall-generator python3-wstool build-essential \
    && rm -rf /var/lib/apt/lists/* \
    && rosdep init && rosdep update

# create catkin workspace and clone iq_sim, iq_gnc
RUN cd $HOME \
    && mkdir catkin_ws && cd catkin_ws \
    && catkin init \
    && mkdir src && cd src \
    && git clone https://github.com/Intelligent-Quads/iq_sim \
    && git clone https://github.com/Intelligent-Quads/iq_gnc

# ardupilot_gazebo and install geographiclib dataset
# RUN cd $HOME \
# 	&& git clone https://github.com/khancyr/ardupilot_gazebo \
# 	&& cd ardupilot_gazebo \
# 	&& mkdir build && cd build \
# 	&& cmake .. \
# 	&& make -j4 \
# 	&& sudo make install \
# 	&& cd $HOME \
# 	&& wget https://raw.githubusercontent.com/mavlink/mavros/master/mavros/scripts/install_geographiclib_datasets.sh \
# 	&& chmod +x ./install_geographiclib_datasets.sh \
# 	&& ./install_geographiclib_datasets.sh

# download ardupilot
#ENV USER=ardupilot
RUN cd $HOME \
    && git clone https://github.com/ArduPilot/ardupilot \
    && cd ardupilot && git submodule update --init --recursive

# change user to install ArduPilot env
RUN chown -R ubuntu $HOME
USER ubuntu
ENV USER=ubuntu
# install ardupilot
ENV SKIP_AP_EXT_ENV=1 SKIP_AP_GRAPHIC_ENV=1 SKIP_AP_COV_ENV=1 SKIP_AP_GIT_CHECK=1
RUN $HOME/ardupilot/Tools/environment_install/install-prereqs-ubuntu.sh -y 
#    && sudo apt-get clean \
#    && sudo rm -rf /var/lib/apt/lists/*
USER root

# install BridgePoint
#USER root
#ENV FID=1pKfnoVFFEykcXuDG26_isCIbAfSxYMXD
#RUN cd /opt \
#  	&& CONFIRM=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate "https://docs.google.com/uc?export=download&id=$FID" -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p') \
#	&& echo $CONFIRM \
#	&& wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$CONFIRM&id=$FID" -O bp.zip \
#	&& rm -rf /tmp/cookies.txt \
#	&& unzip bp.zip \
#	&& rm bp.zip

# Create start shell on root Desktop
# RUN mkdir $HOME/Desktop

# Gazebo Launcher
#RUN echo "#!/bin/bash" >> $HOME/Desktop/simulator.sh \
#    && echo "" >> $HOME/Desktop/simulator.sh \
#    && echo "gazebo --verbose worlds/iris_arducopter_runway.world" >> $HOME/Desktop/simulator.sh \
#    && chmod +x $HOME/Desktop/simulator.sh

# SITL Launcher
#RUN echo "#!/bin/bash" >> $HOME/Desktop/sitl.sh \
#    && echo "" >> $HOME/Desktop/sitl.sh \
#    && echo 'source $HOME/.bashrc' >> $HOME/Desktop/sitl.sh \
#    && echo 'cd $HOME/ardupilot/ArduCopter' >> $HOME/Desktop/sitl.sh \
#    && echo '../Tools/autotest/sim_vehicle.py -f gazebo-iris --console --map' >> $HOME/Desktop/sitl.sh \
#    && chmod +x $HOME/Desktop/sitl.sh

# BridgePoint Launcher
# RUN ln -s /opt/BridgePoint/bridgepoint ~/Desktop/

# setup
# RUN echo "source /opt/ros/melodic/setup.bash" >> $HOME/.bashrc \
#    && echo "export PATH=$PATH:$HOME/.local/bin" \
#    && echo 'source /usr/share/gazebo/setup.sh' >> ~/.bashrc \
#    && echo 'source $HOME/catkin_ws/devel/setup.bash' >> $HOME/.bashrc \
#    && echo 'export PATH=$HOME/.local/bin:/opt/BridgePoint:$PATH' >> $HOME/.bashrc
