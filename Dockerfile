FROM osrf/ros:jazzy-desktop-full

# Crear el directorio de configuración de ROS 2
RUN mkdir -p /root/.ros

# Copiar el archivo de configuración Fast DDS
COPY fastdds.xml /root/.ros/fastdds.xml

# Definir la variable de entorno para que Fast DDS use este archivo
ENV FASTRTPS_DEFAULT_PROFILES_FILE=/root/.ros/fastdds.xml
