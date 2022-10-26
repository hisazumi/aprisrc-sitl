# How to build your own UE4 world

0. Install Visual Studio 2022
1. Install Unreal Engine and build AirSim accoding to following instruction.

https://microsoft.github.io/AirSim/build_windows/

After cloning AirSim, download mavlink_sha256.h from this repository and replace AirSim\MavLinkCom\mavlink\mavlink_sha256.h to avoid compile error while building.

2. Setup Blocks Environment for AirSim

https://microsoft.github.io/AirSim/unreal_blocks/

3. Edit Blocks using Unreal Editor and enjoy it 


## Import existing materials

1. Select good resources and download them from the epic games store. I tried Gokhan Karadayi's "Landscape Backgrounds." 
2. Select the location of the "Blocks" environment in the AirSim source codes that you created during the "Setup Blocks Environment for AirSim" step by clicking the "Add To Project" button. 
3. Select the preferred map you imported in "Editor Startup Map" and "Game Default Map" under "Default Maps" in "Project Settings." 
4. In the World Setting window, find "Game Mode" and select "AirSimGamdeMode." 
5. Place the "Player Start" actor in the proper place. The actor is used to designate where our quadcopter should start. The default position may occasionally be underground. Be sure to set it down on the ground.
