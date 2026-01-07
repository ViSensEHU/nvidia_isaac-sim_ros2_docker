
# nvidia_isaac-sim_5.1.0_ros2_docker (DISTRIBUTED)

<!-- Arrancar
./runapp.sh --enable omni.isaac.ros2_bridge -->

**Isaac Sim runs with warnings (``check warning.md``, for instance, to add a RTX Lidar you may need to add some configuration files. At the moment, this issue has not been resolved, and the .md file is only available in Spanish)**


Run NVIDIA Isaac Sim (NIS) 5.1.0 in a Docker container with ROS2 bridge already set up and communicating with another Docker container running the ROS2 Humble application.
Please, first af all check NIS_5-1-0 requiremente here: https://docs.isaacsim.omniverse.nvidia.com/5.1.0/installation/requirements.html. 

In this case, since official original images are used, no Dockerfile is provided. However, whenever your ROS2 Docker container needs additional packages, it is recommended to create a Dockerfile for that image. You can see Dockerfile examples in other branches. However, in the future, a link to my Docker Hub will be published as a backup for both images—you never know what third parties might do with their repositories ;)

If you meet all the requirements, you can jump directly to [Download and run with bash scripts](#download-and-run-with-bash-scripts) to start developing!

NOTE: NIS 5.1.0 officially works with ROS2 Humble, but since the bridge is used to communicate topics, services, and actions, it will work in almost all cases with ROS2 Jazzy. The steps presented in this file correspond to ROS2 Humble, but the scripts correspond to Jazzy, so modify them according to your needs or preferences.
<br>

# Specifications
This repository has been run with the following host specifications:

OS: ``Ubuntu 24.04.X LTS``<br>
RAM: ``32 GB``<br>
Processor: ``13th Gen Intel® Core™ i7-13650HX × 20``<br>
Graphics card: ``NVIDIA Quadro RTX 5000``<br>
Graphics card memory: ``16 GB``<br>
NVIDIA-SMI dirvers version: ``580.95.05``<br>
CUDA version: ``13.0``<br>
Needed disk space: ``30 GB`` (rounded up)<br>

*It should work in previous releases as 20.04 and 22.04.
<br>

# Prerequisites
- NVIDIA Drivers installation: https://ubuntu.com/server/docs/nvidia-drivers-installation<br>
GPU drivers version must be 580.65.06 or later, check it with:
```bash
nvidia-smi
```

- NVIDIA Isaac Sim Requirements: https://docs.isaacsim.omniverse.nvidia.com/5.1.0/installation/requirements.html
Please ensure you meet the minimum requirements for NIS 5.1.0 before proceeding.

- Docker installation and executing without sudo:
```bash
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
```
```bash
# Post-install steps for Docker
sudo groupadd docker # Create group
sudo usermod -aG docker $USER # Add current user to docker group
newgrp docker # Log in docker group
```
```bash
#Verify Docker installation
docker run hello-world
```

- NVIDIA Container Toolkit installation:
```bash
# Configure the repository
curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg \
  && curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list | \
    sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
    sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list \
  && \
    sudo apt-get update

# Install the NVIDIA Container Toolkit packages
sudo apt-get install -y nvidia-container-toolkit
sudo systemctl restart docker

# Configure the container runtime
sudo nvidia-ctk runtime configure --runtime=docker
sudo systemctl restart docker

# Verify NVIDIA Container Toolkit
docker run --rm --runtime=nvidia --gpus all ubuntu nvidia-smi
```

- Generate NGC API Key: https://docs.nvidia.com/ngc/ngc-overview/index.html#generating-api-key
- Log in to NGC:
```bash
docker login nvcr.io
```
```bash
Username: $oauthtoken
Password: <Your NGC API Key>
WARNING! Your password will be stored unencrypted in /home/username/.docker/config.json.
Configure a credential helper to remove this warning. See
credentials-store
Login Succeeded
```

- Activate NVIDIA GPU X Server (host running GUI with NVIDIA GPU instead of Intel/AMD one):
```bash
sudo prime-select nvidia
sudo reboot
```
This step is needed as Docker inherits X Server (GUI) from the host, any of the following will
fail in order to run NIS with NVIDIA GPU in Docker:
```bash
sudo prime-select intel
sudo prime-select on-demand
```
<br>

# Isaac Sim version
``5.1.0``
<br>

# ROS2 version
``ROS2 Humble Desktop``
<br>

# Docker version
``Client: Docker Engine - Community``<br>
``Version:           27.3.1``<br>
``API version:       1.47``<br>
``Go version:        go1.22.7``<br>
``Git commit:        ce12230``<br>
``Built:             Fri Sep 20 11:40:59 2024``<br>
``OS/Arch:           linux/amd64``<br>
``Context:           default``<br>

``Server: Docker Engine - Community``<br>
`Engine:`<br>
` Version:          27.3.1`<br>
` API version:      1.47 (minimum version 1.24)`<br>
`Go version:       go1.22.7`<br>
`Git commit:       41ca978`<br>
`Built:            Fri Sep 20 11:40:59 2024`<br>
`  OS/Arch:          linux/amd64`<br>
`  Experimental:     false`<br>
` containerd:`<br>
`  Version:          1.7.22`<br>
`  GitCommit:        7f7fdf5fed64eb6a7caf99b3e12efcf9d60e311c`<br>
` runc:`<br>
`  Version:          1.1.14`<br>
 ` GitCommit:        v1.1.14-0-g2c9f560`<br>
 `docker-init:`<br>
  `Version:          0.19.0`<br>
 ` GitCommit:        de40ad0`<br>
<br>

# Download images image
```bash
docker pull osrf/ros:humble-desktop-full
docker pull nvcr.io/nvidia/isaac-sim:5.1.0
```
<br>

# Run containers
Allow running graphic interfaces in the container:
```bash
xhost +local:docker
```
Run the NIS container with the needed configuration:
```bash
xhost +local:docker
docker run --name nis-5.1.0-bare \
           --entrypoint bash \
           -it \
           --runtime=nvidia \
           --gpus all \
           -e RMW_IMPLEMENTATION=rmw_fastrtps_cpp \
           -e LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/isaac-sim/exts/isaacsim.ros2.bridge/jazzy/lib \
           -e NVIDIA_VISIBLE_DEVICES=all \
           -e NVIDIA_DRIVER_CAPABILITIES=graphics,utility,compute \
           -e "ACCEPT_EULA=Y" \
           --rm \
           --network=host \
           -e "PRIVACY_CONSENT=Y" \
           -e DISPLAY=$DISPLAY \
           -v /tmp/.X11-unix/:/tmp/.X11-unix/ \
           -v ~/docker/isaac-sim/cache/kit:/isaac-sim/kit/cache:rw \
           -v ~/docker/isaac-sim/cache/ov:/root/.cache/ov:rw \
           -v ~/docker/isaac-sim/cache/pip:/root/.cache/pip:rw \
           -v ~/docker/isaac-sim/cache/glcache:/root/.cache/nvidia/GLCache:rw \
           -v ~/docker/isaac-sim/cache/computecache:/root/.nv/ComputeCache:rw \
           -v ~/docker/isaac-sim/logs:/root/.nvidia-omniverse/logs:rw \
           -v ~/docker/isaac-sim/data:/root/.local/share/ov/data:rw \
           -v ~/docker/isaac-sim/documents:/root/Documents:rw \
           nvcr.io/nvidia/isaac-sim:5.1.0
```
The volume ```-v ~/docker/isaac-sim/documents:/root/Documents:rw``` is intended to be the working directory for NIS files.

Run the ROS2 container with the needed configuration:
```bash
xhost +local:docker
docker run -e DISPLAY=$DISPLAY \
           -e USER=$USER \
           -e NVIDIA_VISIBLE_DEVICES=all \
           -e NVIDIA_DRIVER_CAPABILITIES=graphics,utility,compute \
           --runtime=nvidia \
           -v /tmp/.X11-unix/:/tmp/.X11-unix/ \
           --device /dev/dri:/dev/dri \
           -it \
           --rm \
           --network=host \
           --gpus all \
           --name ros2_humble \
           osrf/ros:humble-desktop-full
```

REMEMBER: if you want to share a folder between the host and the container, mount it adding the next flag to the previous command:
```bash
-v HOST_PATH:PATH_IN_CONTAINER
```
```bash
-v ~/Documents/isaac_sim/PROJECT_ID:~/PROJECT_ID
```
<br>

# Run Isaac Sim inside the container
If this command is included when running the container, ROS2 bridge will fail. That's because the container with ROS2 packages must be started first, and then Isaac Sim.
Once the container is running, type next line in the container:
```bash
./runapp.sh
```
Wait until Isaac Sim is completely loaded. Ignore "not responding" messages, it will take some time, so be patient ;).

If GUI fails to open, ensure that host's ```$DISPLAY``` variable is set to ``:0`` (and then rerun the NIS Docker image):
```bash
echo $DISPLAY 
```
<br>

# Download and run with bash scripts 

You can automatically execute the above process using the ```download_images.sh```, ```run_nis.sh```, ```run_ros2.sh``` and ```run.sh``` scripts.

Add execution permissions:
```bash
chmod u+x download_images.sh run_nis.sh run_ros2.sh run.sh
```

Download images:
```bash
./download_images.sh
```

Run NIS 5.1.0:
```bash
./run_nis.sh
```

Run ROS2:
```bash
./run_ros2.sh
```

If you are using Tilix to manage multiple terminals on the same screen, open a Tilix terminal and run the following command. The NIS container will automatically open on the left and the ROS2 container on the right.
```bash
./run.sh
```
You can install Tilix easily:
```bash
sudo apt update && sudo apt install tilix -y
```
<br>

# Check ROS2 Bridge along both containers
On NIS, ``Create > ROS2 Assets > Nova Carter`` and click ``Play``:
![Create Nova Carter on NIS](img/nova_carter.png)
![Nova Carter Play on NIS](img/nova_carter_play.png)
![Nova Carter Play2 on NIS](img/nova_carter_play2.png)


On ROS2 container, run:
```bash
ros2 topic list
```
You will see the topics used by NIS. If you stop the simulation or exit the NIS container and run `ros2 topic list`, you will not see as many topics as before.

![No topics on simulation stopped](img/no_topics.png)
![Topics on simulation started](img/topics.png)
<br>

# Bibliography (still outdated... needs to be checked in future commits)
https://docs.omniverse.nvidia.com/isaacsim/latest/installation/install_container.html

https://omniverse-content-production.s3-us-west-2.amazonaws.com/Assets/Isaac/Documentation/Isaac-Sim-Docs_2022.2.1/isaacsim/latest/install_ros.html

https://catalog.ngc.nvidia.com/orgs/nvidia/containers/isaac-sim

https://github.com/NVIDIA-Omniverse/IsaacSim-dockerfiles
