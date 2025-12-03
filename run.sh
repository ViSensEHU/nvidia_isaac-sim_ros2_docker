xhost +local:docker
docker run --name isaac-sim \
           -it --rm \
           --network=host \
           --gpus all \
           --entrypoint bash \
           --runtime=nvidia \
           -e USER=$USER \
           -e DISPLAY=$DISPLAY \
           -e NVIDIA_VISIBLE_DEVICES=all \
           -e NVIDIA_DRIVER_CAPABILITIES=graphics,utility,compute \
           -e ACCEPT_EULA=Y \
           -e PRIVACY_CONSENT=Y \
           -e __GLX_VENDOR_LIBRARY_NAME=nvidia \
           -v $HOME/.Xauthority:/root/.Xauthority \
           -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
           -v ~/docker/isaac-sim/cache/kit:/isaac-sim/kit/cache:rw \
           -v ~/docker/isaac-sim/cache/ov:/root/.cache/ov:rw \
           -v ~/docker/isaac-sim/cache/pip:/root/.cache/pip:rw \
           -v ~/docker/isaac-sim/cache/glcache:/root/.cache/nvidia/GLCache:rw \
           -v ~/docker/isaac-sim/cache/computecache:/root/.nv/ComputeCache:rw \
           -v ~/docker/isaac-sim/logs:/root/.nvidia-omniverse/logs:rw \
           -v ~/docker/isaac-sim/data:/root/.local/share/ov/data:rw \
           -v ~/docker/isaac-sim/documents:/root/Documents:rw \
           -v ~/docker/isaac-sim/pkg:/root/.local/share/ov/pkg:rw \
           nis_ros2:4.5.0-Humble 

# Si configuramos OmniHub en la red local o en el host, añadir lo siguiente
# -e OMNI_SERVER=http://<host-ip>:3009 \
# -e OMNI_USER=tu_usuario \
# -e OMNI_PASS=tu_password \
# -v ~/omniverse/nucleus:/root/omniverse/nucleus:rw \


