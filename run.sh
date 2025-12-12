#!/bin/bash
tilix -a session-add-right -t "ROS2 Jazzy Docker Container" -x "bash -c './run_ros2_jazzy_docker.sh; exec bash'"
./run.sh