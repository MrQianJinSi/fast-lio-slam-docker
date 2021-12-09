FROM osrf/ros:melodic-desktop-full


# nvidia-container-runtime
ENV NVIDIA_VISIBLE_DEVICES ${NVIDIA_VISIBLE_DEVICES:-all}
ENV NVIDIA_DRIVER_CAPABILITIES ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics

# install GLX-Gears
RUN apt-get update && apt-get install -y --no-install-recommends mesa-utils x11-apps libparmetis-dev && rm -rf /var/lib/apt/lists/*

# install dependencies - GTSAM
RUN apt-get update && apt-get install wget unzip && wget -O ~/gtsam.zip https://github.com/borglab/gtsam/archive/4.0.0-alpha2.zip && cd ~/ && unzip gtsam.zip
RUN cd ~/gtsam-4.0.0-alpha2/ && mkdir build && cd build && cmake .. && make install -j8

# install ceres
RUN apt-get update && apt-get install -y libceres-dev

# download FAST_LIO_SLAM
RUN mkdir -p ~/catkin_ws/src && cd ~/catkin_ws/src &&  git clone https://github.com/gisbi-kim/FAST_LIO_SLAM.git && cd FAST_LIO_SLAM/FAST-LIO && echo "\nadd_dependencies(fastlio_mapping fast_lio_generate_messages_cpp)" >> CMakeLists.txt && cat CMakeLists.txt
# download livox driver, depended by fast-lio
RUN cd ~/catkin_ws/src && git clone https://github.com/Livox-SDK/livox_ros_driver
# download dataset player
RUN cd ~/catkin_ws/src && git clone https://github.com/irapkaist/file_player_mulran.git

# compile
RUN /bin/sh -c '. /opt/ros/melodic/setup.sh; cd ~/catkin_ws ; catkin_make -j8'

# setup env
RUN echo "\n source /root/catkin_ws/devel/setup.bash" >> /root/.bashrc
