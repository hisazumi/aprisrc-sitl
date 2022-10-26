# How to build your own UE4 world

0. Install Visual Studio 2022
1. Install Unreal Engine and build AirSim accoding to following instruction.

https://microsoft.github.io/AirSim/build_windows/

After cloning AirSim, download mavlink_sha256.h from this repository and replace AirSim\MavLinkCom\mavlink\mavlink_sha256.h to avoid compile error while building.

2. Setup Blocks Environment for AirSim

https://microsoft.github.io/AirSim/unreal_blocks/

3. Edit Blocks using Unreal Editor and enjoy it 


## Import existing materials

1. Find good materials from marketplace of the epic games and download it. I tried "Landscape Backgrounds" by Gokhan Karadayi.
2. Click "Add To Project" button and select the location of Blcoks environment in AirSim source codes that you built in the phase of "Setup Blcoks Environment for AirSim"
3. Open "Project Settings", find "Default Maps", and select prefered map you imported in "Editor Startup Map" and "Game Default Map".
4. Select "AirSimGamdeMode" in "Game Mode" in World Setting view.
5. Move "Player Start" actor to appropriate location. The actor is for specifying the start location of our quadcpter. Sometimes the default location is under the ground. Make sure to place it on the ground.

