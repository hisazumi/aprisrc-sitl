# How to run

1. Launch the container in your host side
```
docker run -p 8080:80 hisazumi/aprisrc-stil:latest
```

2. Access http://localhost:8080 from your Web broswer

3. Double click 'simulator.sh' on the desktop to launch Gazebo simulator. Wait a minute. 

4. Open LXTerminal and execute ./Desktop/sitl.sh to launch the Software-in-the-Loop env of ArduPilot. Wait a minute.

5. Input follwing commands into SITL temrinal launched at 4.:
```
mode guided
arm throttle
takeoff 1
```

# References
- Base container https://hub.docker.com/r/dorowu/ubuntu-desktop-lxde-vnc/ 
- ArduPilot https://ardupilot.org/dev/docs/sitl-simulator-software-in-the-loop.html

