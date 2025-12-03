xhost +local:docker
docker run --name isaac-sim \
           --entrypoint bash \
           -it \
           --rm \
           --network=host \
           --gpus all \
           --runtime=nvidia \
           -e DISPLAY=$DISPLAY \
           -e NVIDIA_VISIBLE_DEVICES=all \
           -e NVIDIA_DRIVER_CAPABILITIES=graphics,utility,compute \
           -e "ACCEPT_EULA=Y" \
           -e "PRIVACY_CONSENT=Y" \
           -v $HOME/.Xauthority:/root/.Xauthority \
           -v ~/docker/isaac-sim/cache/kit:/isaac-sim/kit/cache:rw \
           -v ~/docker/isaac-sim/cache/ov:/root/.cache/ov:rw \
           -v ~/docker/isaac-sim/cache/pip:/root/.cache/pip:rw \
           -v ~/docker/isaac-sim/cache/glcache:/root/.cache/nvidia/GLCache:rw \
           -v ~/docker/isaac-sim/cache/computecache:/root/.nv/ComputeCache:rw \
           -v ~/docker/isaac-sim/logs:/root/.nvidia-omniverse/logs:rw \
           -v ~/docker/isaac-sim/data:/root/.local/share/ov/data:rw \
           -v ~/docker/isaac-sim/documents:/root/Documents:rw \
           isaac_sim_ros2:4.5.0-Humble
