FROM dorowu/ubuntu-desktop-lxde-vnc:bionic

RUN useradd -U -d /home/ardupilot ardupilot && \
    usermod -G users ardupilot

RUN apt-get update && apt-get install -y \
        software-properties-common \
        wget curl git cmake cmake-curses-gui \
        libboost-all-dev \
        libflann-dev \
	libgsl0-dev \
        libgoogle-perftools-dev \
        libeigen3-dev \
	openssl

# Intall ROS
RUN apt-get update && apt-get install -q -y \
    dirmngr \
    gnupg2 \
    lsb-release \
    apt-utils

RUN apt-get update && apt-get upgrade -y \
    && wget https://raw.githubusercontent.com/ROBOTIS-GIT/robotis_tools/master/install_ros_melodic.sh && chmod 755 ./install_ros_melodic.sh && bash ./install_ros_melodic.sh

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
RUN apt-get update
RUN apt-get upgrade -y

# ardupilot_gazebo
RUN cd /root/ \
	&& git clone https://github.com/khancyr/ardupilot_gazebo \
	&& cd ardupilot_gazebo \
	&& mkdir build && cd build \
	&& cmake .. \
	&& make -j4 \
	&& sudo make install

# download ardupilot
ENV USER=ardupilot
RUN cd /home \
    && git clone https://github.com/ArduPilot/ardupilot \
    && cd ardupilot && git submodule update --init --recursive

RUN echo "ardupilot ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/ardupilot
RUN chmod 0440 /etc/sudoers.d/ardupilot

RUN chown -R ardupilot:ardupilot /home/ardupilot

USER ardupilot
RUN /home/ardupilot/Tools/environment_install/install-prereqs-ubuntu.sh -y


# Create start shell on root Desktop

RUN mkdir /root/Desktop
#RUN echo "#!/bin/bash" >> /root/Desktop/simulator.sh \
#    && echo "" >> /root/Desktop/simulator.sh \
#    && echo "source /opt/ros/kinetic/setup.bash" >> /root/Desktop/simulator.sh \
#    && echo "source /root/catkin_ws/devel/setup.bash" >> /root/Desktop/simulator.sh \
#    && echo "export TURTLEBOT3_MODEL=burger" >> /root/Desktop/simulator.sh \
#    && echo "roslaunch turtlebot3_gazebo FPT_C.launch" >> /root/Desktop/simulator.sh

RUN echo "source /opt/ros/melodic/setup.bash" >> /root/.bashrc
#RUN echo "source /root/catkin_ws/devel/setup.bash" >> /root/.bashrc
#RUN echo "export TURTLEBOT3_MODEL=burger" >> /root/.bashrc
