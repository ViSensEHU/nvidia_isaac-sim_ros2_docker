
# nvidia_isaac-lab_2.3.2_ros2_docker (DISTRIBUTED)

# Isaac Lab version
``2.3.2``
<br>

# Isaac Sim version
``5.1.0``
<br>

<!-- # ROS2 version
``ROS2 Jazzy Desktop``
<br> -->

# Installation and execution
Follow the instructions in the “nis-5.1.0-distributed” branch.
Then, follow these steps:


## Download Isaac Lab image (includes installation of Isaac Sim 5.1.0 within the image)
```bash
sudo chmod u+x download_images.sh
./download_images.sh
```
<br>

# Run container
```bash
sudo chmod u+x run_nil.sh
./run_nil.sh
```

# Run Isaac Sim inside the container
```bash
cd _isaac_sim/
./runapp.sh
```
Wait until Isaac Sim is completely loaded. Ignore "not responding" messages, it will take some time, so be patient ;).
<br>

# Run Isaac Lab test inside the container
```bash
cd workspace/isaaclab/
./isaaclab.sh -p scripts/tutorials/00_sim/log_time.py --headless
```

This example only verifies that the Isaac Lab installation is working correctly:
- Isaac Sim starts in headless mode
- The simulation engine runs without errors
- Simulated time advances correctly
- You can run a Python script within the environment
- Communication between Isaac Lab ↔ Python is configured correctly

To do this, create an empty world, start the simulation, and print the simulated time at each step.

The simulation time is recorded in ``/workspace/isaaclab/logs/docker_tutorial/log.txt``. To verify that it is actually working:
```bash
cat /workspace/isaaclab/logs/docker_tutorial/log.txt
```
<br>

# Bibliography 
https://isaac-sim.github.io/IsaacLab/main/source/deployment/docker.html

https://catalog.ngc.nvidia.com/orgs/nvidia/containers/isaac-lab?version=2.3.2

https://docs.isaacsim.omniverse.nvidia.com/5.1.0/installation/index.html

https://docs.isaacsim.omniverse.nvidia.com/5.1.0/installation/install_ros.html

# Outdated bibliography
https://docs.omniverse.nvidia.com/isaacsim/latest/installation/install_container.html

https://omniverse-content-production.s3-us-west-2.amazonaws.com/Assets/Isaac/Documentation/Isaac-Sim-Docs_2022.2.1/isaacsim/latest/install_ros.html

https://catalog.ngc.nvidia.com/orgs/nvidia/containers/isaac-sim

https://github.com/NVIDIA-Omniverse/IsaacSim-dockerfiles
