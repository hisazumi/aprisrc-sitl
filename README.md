# How to connect this container

1. Launch the container in your host side
```
docker run -p 8080:80 hisazumi/aprisrc-sitl:latest
```

2. Access http://localhost:8080 from your Web broswer

# Control a quad-copter in the simulator manually

1. Execute the Gazebo simulator. Double click 'simulator.sh' on the desktop to launch Gazebo simulator. Wait a minute. 

2. Open LXTerminal and execute ./Desktop/sitl.sh to launch the Software-in-the-Loop env of ArduPilot. Wait a minute.

3. Input follwing commands into SITL temrinal launched at 2.:
```
mode guided
arm throttle
takeoff 1
```

# Control a quad-copter from a C++ program

1. Build sample source codes. Open LXTerminal and execute commands as follows:

```
cd catkin
catkin build
```

and relaunch LXTerminal (or just execute bash) to reload ~/.bashrc

2. Edit catkin_ws/src/iq_gnc/CMakefile.txt to enable to build gnc_tutorial.cpp. Remove '#' the head of the lines as follows:

```
206: add_executable(gnc_example src/gnc_tutorial.cpp)
207: target_link_libraries(gnc_example ${catkin_LIBRARIES})
```

3. Execute the Gazebo simulator. Double click 'simulator.sh' on the desktop to launch Gazebo simulator. Wait a minute. 

4. Execute ./Desktop/sitl.sh in new tab in terminal to launch the Software-in-the-Loop env of ArduPilot. Wait a minute.

5. Launch apm in new tab in terminal:

```
roslaunch iq_sim apm.launch
```

6. Launch sample code in new tab:

```
rosrun iq_gnc gnc_example
```

7. Finally change mode to guided in sitl.sh terminal

```
mode guided
````

# References
- Base container https://hub.docker.com/r/dorowu/ubuntu-desktop-lxde-vnc/ 
- ArduPilot https://ardupilot.org/dev/docs/sitl-simulator-software-in-the-loop.html

