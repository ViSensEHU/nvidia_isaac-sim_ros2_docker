#!/bin/bash

#tilix --session -a session-add-left -t "Isaac Sim 4.5.0 Docker Container" -x "bash -c './run.sh; exec bash'"
tilix -a session-add-right -t "ROS2 Jazzy Docker Container" -x "bash -c './run_ros2_jazzy_docker.sh; exec bash'"
./run.sh