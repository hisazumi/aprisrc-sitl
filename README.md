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

2. Execute the Gazebo simulator. Double click 'simulator.sh' on the desktop to launch Gazebo simulator. Wait a minute. 

3. Open LXTerminal and execute ./Desktop/sitl.sh to launch the Software-in-the-Loop env of ArduPilot. Wait a minute.


3. Open a new tab (or window) in LXTerminal and execute a command as follows:
```
roslaunch iq_sim runway.launch
# New Terminal
roslaunch iq_sim apm.launch
# New Terminal 
rosrun iq_gnc square
```


# References
- Base container https://hub.docker.com/r/dorowu/ubuntu-desktop-lxde-vnc/ 
- ArduPilot https://ardupilot.org/dev/docs/sitl-simulator-software-in-the-loop.html

