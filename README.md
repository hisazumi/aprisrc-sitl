# Setup APRISRC environments with AirSim

## Prerequisites

* Windows 11 or 10
* Windows Subsystem for Linux 1 (WSL1)
* Ubuntu 20.04 on WSL1

## Installation

1. Download AirSim prebuild binary

I am using AirSimNH but you can choose according to your preference.
https://github.com/Microsoft/AirSim/releases

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
