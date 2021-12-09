xhost +local:root
docker run --rm -it --name fastlio --env="DISPLAY" --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" -v /home/mrqianjinsi/ros:/root/data fastlio:latest 
