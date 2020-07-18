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
        apt-utils

# Intall ROS
RUN wget https://raw.githubusercontent.com/ROBOTIS-GIT/robotis_tools/master/install_ros_melodic.sh \
    && chmod 755 ./install_ros_melodic.sh \
    && bash ./install_ros_melodic.sh

#RUN apt-get update && apt-get install -q -y \
#    ros-kinetic-joy ros-kinetic-teleop-twist-joy ros-kinetic-teleop-twist-keyboard ros-kinetic-laser-proc ros-kinetic-rgbd-launch ros-kinetic-depthimage-to-laserscan ros-kinetic-rosserial-arduino ros-kinetic-rosserial-python ros-kinetic-rosserial-server ros-kinetic-rosserial-client ros-kinetic-rosserial-msgs ros-kinetic-amcl ros-kinetic-map-server ros-kinetic-move-base ros-kinetic-urdf ros-kinetic-xacro ros-kinetic-compressed-image-transport ros-kinetic-rqt-image-view ros-kinetic-gmapping ros-kinetic-navigation ros-kinetic-interactive-markers

# install other ros packages
RUN apt-get update && apt-get install -y \
    python-rosdep python-rosinstall python-rosinstall-generator python-wstool build-essential \
    && rm -rf /var/lib/apt/lists/*

# RUN echo "source /opt/ros/kinetic/setup.bash" >> ~/.bashrc

# Gazebo upgrade
RUN echo "deb http://packages.osrfoundation.org/gazebo/ubuntu-stable `lsb_release -cs` main" >> /etc/apt/sources.list.d/gazebo-stable.list
RUN su -c "bash -c 'wget http://packages.osrfoundation.org/gazebo.key -O - |  apt-key add - '" $USERNAME
RUN apt-get update \
    && apt-get upgrade -y

# ardupilot_gazebo
RUN cd $HOME \
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
    && echo "gazebo --verbose worlds/iris_arducopter_runway.world" >> $HOME/Desktop/simulator.sh

# SITL Launcher
RUN echo "#!/bin/bash" >> $HOME/Desktop/sitl.sh \
    && echo "" >> $HOME/Desktop/sitl.sh \
    && echo "cd $HOME/ardupilot/ArduCopter && ../Tools/autotest/sim_vehicle.py -f gazebo-iris --console --map" >> $HOME/Desktop/simulator.sh

RUN echo "source /opt/ros/melodic/setup.bash" >> $HOME/.bashrc
RUN echo "source /root/catkin_ws/devel/setup.bash" >> $HOME/.bashrc
