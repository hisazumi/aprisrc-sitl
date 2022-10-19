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
4. Install VcXsrv for running BridgePoint (or other Ubuntu GUI apps)


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

1. Turn on Windows Subsystem for Linux

https://learn.microsoft.com/en-us/windows/wsl/install

1. Confirm WSL version in Command Prompt or PowerShell

```
C:\Users\guesten>wsl --status
Default Version: 2

Windows Subsystem for Linux was last updated on Fri
The Windows Subsystem for Linux kernel can be manually updated with 'wsl --update', but automatic updates cannot occur due to your system settings.
To receive automatic kernel updates, please enable the Windows Update setting: 'Receive updates for other Microsoft products when you update Windows'.
For more information please visit https://aka.ms/wsl2kernel.

Kernel version: 5.10.16
```

If default version of your env is 2, change the default version as follows:
```
> wsl --set-default-version 1
````

It is ok if you can see following message:

```
wsl --status
Default Version: 1

Windows Subsystem for Linux was last updated on Fri
The Windows Subsystem for Linux kernel can be manually updated with 'wsl --update', but automatic updates cannot occur due to your system settings.
To receive automatic kernel updates, please enable the Windows Update setting: 'Receive updates for other Microsoft products when you update Windows'.
For more information please visit https://aka.ms/wsl2kernel.

Kernel version: 5.10.16
```

2. Install Ubuntu 20.04 

Install Ubuntu 20.04.XX from Microsoft Store. 


## 3. Install Ardupilot and BridgePoint using a installation script

1. Open ubuntu terminal from your start menu

2. Download install-to-ubuntu20-02.sh from this repository as followings in the ubuntu terminal:
```sh
wget https://raw.githubusercontent.com/hisazumi/aprisrc-sitl/forairsim/install-to-ubuntu20-02.sh
```

3. Execute the installation script you downloaded as follows:
```sh
sh install-to-ubuntu20-02.sh
```

## 4. Install VcXsrv for running BridgePoint (or other Ubuntu GUI apps)

1. Install VcXsrv for using BridgePoint (or other X Window apps)

https://sourceforge.net/projects/vcxsrv/


## 5. Launch Airsim and ArduCopter

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
8. Use BridgePoint
Launch BrigePoint as follows:
```
~/BridgePoint/bridgepoint
```
Clone a template repository and import it.
https://github.com/hisazumi/gnc/
