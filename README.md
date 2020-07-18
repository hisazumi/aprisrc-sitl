# How to run

1. Launch the container in your host side
```
docker run -p 8080:80 hisazumi/aprisrc-stil:latest
```

2. Access http://localhost:8080 from your Web broswer

3. Double click 'simulator.sh' on the desktop to launch Gazebo simulator. Wait a minute. 

4. Double click 'sitl.sh' on the desktop and select 'Execute in Terminal' to launch the Software-in-the-Loop env of ArduPilot. Wait a minute.

5. Input SITL temrinal as follows:
```
mode guided
arm throttle
takeoff 1
```

