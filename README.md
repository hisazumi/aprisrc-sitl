# Setup APRISRC environments with AirSim

## Prerequisites

* Windows 11 or 10
* Windows Subsystem for Linux 1 (WSL1)
* Ubuntu 20.04 on WSL1

## Installation

### Overview

1. Install AirSim
2. Install Ubuntu 20.04 on WSL1
3. Install Ardupilot and BridgePoint using a installation script

### 1. Install AirSim

1. Install Visual Studio Community 2022

Make sure to select Desktop Development with C++ and Windows 10 SDK 10.0.19041 (should be selected by default) and select the latest .NET Framework SDK under the 'Individual Components' tab while installing VS 2022.

2. Download AirSim prebuild binary

I am using AirSimNH but you can choose a binary according to your preference. If your PC is low on memory or not equipped with a descrete GPU, you may find it more comfortable to choose a world with a smaller binary size.

https://github.com/Microsoft/AirSim/releases

3. Install Microsoft DirectX End-User Runtime if needed

Install Microsoft DirectX End-User Runtime if you met an error message like "The following componet(s) are required to run this program: DirectX Runtime" while launching AirSim.

Download the runtime, and install it.

https://www.microsoft.com/en-us/download/details.aspx?id=35



### 2. Install Ubuntu 20.04 on WSL1

2. Confirm WSL version in Command Prompt or PowerShell

```
> wsl --status
既定の配布: docker-desktop
既定のバージョン: 1

Linux 用 Windows サブシステムの最終更新日: 2022/06/23
WSL の自動更新が有効になっています。

カーネル バージョン: 5.10.102.1
```

If default version of your env is 2, change the default version as follows:
```
> wsl --set-default-version 1
````

3. Install Ubuntu 20.04 

Install Ubuntu 20.04.XX from Microsoft Store. 

4. Install the development environment to execute scripts

download install-to-ubuntu20-02.sh from this repository, and execute it on the wsl you installed in previous step.

5. Install VcXsrv for using BridgePoint (or other X Window apps)

https://sourceforge.net/projects/vcxsrv/

6. Enjoy it!

## How to launch Airsim and ArduCopter

1. Make settings.json for AirSim
Make new file (Windows Home Directory)/Documents/AirSim/settings.json and write as follows:
```
{
  "Vehicles": {
    "Copter": {
      "VehicleType": "ArduCopter",
      "UseSerial": false,
      "LocalHostIp": "0.0.0.0",
      "UdpIp": "127.0.0.1",
      "UdpPort": 9003,
      "ControlPort": 9002
    }
  }
}
```
2. Launch AirSim 
3. Build codes
```
(cd catkin_ws/src && catkin build)
```
4. execute ArduCopter SITL on WSL env as follows:
```
> sim_vehicle.py -v ArduCopter -f airsim-copter 
```
5. Put "arm throttle" command into SITL console
```
STABILIZE> arm throttle
```
6. Change mode to "guided"
```
STABILIZE> mode guided
```
7. Takeoff
```
GUIDED> takeoff 10
```
8. run program
Open a new terminal and execute a command as follows:
```
> roslaunch iq_sim apm.launch
```
Also, open a new terminal tab or window and execute:
```
> rosrun iq_gnc square
```
9. Use BridgePoint
Launch BrigePoint as follows:
```
~/BridgePoint/bridgepoint
```
Clone a template repository and import it.
https://github.com/hisazumi/gnc/
