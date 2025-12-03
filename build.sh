mkdir -p ~/docker/isaac-sim/cache/kit
mkdir -p ~/docker/isaac-sim/cache/ov
mkdir -p ~/docker/isaac-sim/cache/pip
mkdir -p ~/docker/isaac-sim/cache/glcache
mkdir -p ~/docker/isaac-sim/cache/computecache
mkdir -p ~/docker/isaac-sim/logs
mkdir -p ~/docker/isaac-sim/data
mkdir -p ~/docker/isaac-sim/documents
mkdir -p ~/docker/isaac-sim/pkg

docker build -t nis_ros2:4.5.0-Humble .
