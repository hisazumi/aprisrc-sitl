# Setup APRISRC environments

## Prerequisites

* Windows 11 or 10
* Windows Subsystem for Linux 1 (WSL1)
* Ubuntu 20.04 on WSL1

## Installation

1. Confirm WSL version in Command Prompt or PowerShell

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

2. Install Ubuntu 20.04 

Install Ubuntu 20.04.XX from Microsoft Store. 

3. Install the development environment to execute scripts

download install-to-ubuntu20-02.sh from this repository, and execute it on the wsl you installed in previous step.

4. Install VcXsrv for using BridgePoint (or other X Window apps)

https://sourceforge.net/projects/vcxsrv/

5. Enjoy it!
