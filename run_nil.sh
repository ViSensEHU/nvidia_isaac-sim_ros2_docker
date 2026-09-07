xhost +local:docker
docker run --name nil-2.3.2-nis-5.1.0 \
           --entrypoint bash \
           -it \
           --runtime=nvidia \
           --gpus all \
           -e DISPLAY=$DISPLAY \
           -e "ACCEPT_EULA=Y" \
           --rm \
           --network=host \
           -e "PRIVACY_CONSENT=Y" \
           -e RMW_IMPLEMENTATION=rmw_fastrtps_cpp \
           -e LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/isaac-sim/exts/isaacsim.ros2.bridge/jazzy/lib \
           -e NVIDIA_VISIBLE_DEVICES=all \
           -e NVIDIA_DRIVER_CAPABILITIES=graphics,utility,compute \
           -v /tmp/.X11-unix/:/tmp/.X11-unix/ \
           -v $HOME/.Xauthority:/root/.Xauthority \
           -v ~/docker/isaac-sim/cache/kit:/isaac-sim/kit/cache:rw \
           -v ~/docker/isaac-sim/cache/ov:/root/.cache/ov:rw \
           -v ~/docker/isaac-sim/cache/pip:/root/.cache/pip:rw \
           -v ~/docker/isaac-sim/cache/glcache:/root/.cache/nvidia/GLCache:rw \
           -v ~/docker/isaac-sim/cache/computecache:/root/.nv/ComputeCache:rw \
           -v ~/docker/isaac-sim/logs:/root/.nvidia-omniverse/logs:rw \
           -v ~/docker/isaac-sim/data:/root/.local/share/ov/data:rw \
           -v ~/docker/isaac-sim/documents:/root/Documents:rw \
           -v ./projects:/isaac-sim/projects:rw \
           -u 1234:1234 \
           nvcr.io/nvidia/isaac-lab:2.3.2

# -u 1234:1234 \
