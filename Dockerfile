FROM dorowu/ubuntu-desktop-lxde-vnc:bionic

WORKDIR /ardupilot

# add user 'ardupilot'
RUN useradd -U -d /ardupilot ardupilot && \
    usermod -G users ardupilot

RUN echo "ardupilot ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/ardupilot
RUN chmod 0440 /etc/sudoers.d/ardupilot

# update basic packages
RUN apt-get update \
    && apt-get upgrade -y \
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
        rsync

# Intall ROS

RUN echo "deb http://packages.ros.org/ros/ubuntu bionic main" > /etc/apt/sources.list.d/ros-latest.list \
    && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654 \
    && apt-get update -y \
    && apt-get upgrade -y \ 
    && apt-get install -y \
        ros-melodic-ros-base \
        gazebo9 libgazebo9-dev \
        python-rosdep python-rosinstall python-rosinstall-generator python-wstool build-essential \
    && rm -rf /var/lib/apt/lists/*

# ardupilot_gazebo
RUN mkdir $HOME \
    && cd $HOME \
	&& git clone https://github.com/khancyr/ardupilot_gazebo \
	&& cd ardupilot_gazebo \
	&& mkdir build && cd build \
	&& cmake .. \
	&& make -j4 \
	&& sudo make install

# download ardupilot
#ENV USER=ardupilot
RUN cd $HOME \
    && git clone https://github.com/ArduPilot/ardupilot \
    && cd ardupilot && git submodule update --init --recursive

# change user to install ArduPilot env
RUN chown -R ardupilot:ardupilot $HOME
USER ardupilot
ENV USER=ardupilot
# install ardupilot
ENV SKIP_AP_EXT_ENV=1 SKIP_AP_GRAPHIC_ENV=1 SKIP_AP_COV_ENV=1 SKIP_AP_GIT_CHECK=1
RUN $HOME/ardupilot/Tools/environment_install/install-prereqs-ubuntu.sh -y
ENV USER=ubuntu

# Create start shell on root Desktop
USER root
RUN mkdir $HOME/Desktop

# Gazebo Launcher
RUN echo "#!/bin/bash" >> $HOME/Desktop/simulator.sh \
    && echo "" >> $HOME/Desktop/simulator.sh \
    && echo "gazebo --verbose worlds/iris_arducopter_runway.world" >> $HOME/Desktop/simulator.sh \
    && chmod +x $HOME/Desktop/simulator.sh

# SITL Launcher
RUN echo "#!/bin/bash" >> $HOME/Desktop/sitl.sh \
    && echo "" >> $HOME/Desktop/sitl.sh \
    && echo 'cd $HOME/ardupilot/ArduCopter' >> $HOME/Desktop/sitl.sh \
    && echo '../Tools/autotest/sim_vehicle.py -f gazebo-iris --console --map' >> $HOME/Desktop/sitl.sh \
    && chmod +x $HOME/Desktop/sitl.sh

RUN echo "source /opt/ros/melodic/setup.bash" >> $HOME/.bashrc \
    && echo "source $HOME/catkin_ws/devel/setup.bash" >> $HOME/.bashrc \
    && echo 'export PATH=$HOME/.local/bin:$PATH' >> $HOME/.bashrc 
