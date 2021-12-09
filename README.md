# fast-lio-slam-docker
dockerize [FAST_LIO_SLAM](https://github.com/gisbi-kim/FAST_LIO_SLAM)

# Usage
1. build docker image: `bash build.sh`
2. launch [FAST-LIO2](https://github.com/hku-mars/FAST_LIO) for odometry 
    1. launch container: `bash run.sh`, update docker volume mapping according to your condition
    2. launch fast-lio in container: `roslaunch fast_lio mapping_ouster64_mulran.launch`
3. launch [SC-PGO](https://github.com/gisbi-kim/SC-A-LOAM) for loop detection and pose-graph optimization
    1. login container: `bash login.sh`
    2. launch sc-pgo in container: `roslaunch aloam_velodyne fastlio_ouster64.launch`
4. replay [MulRun](https://github.com/irapkaist/file_player_mulran) dataset, you should download the [dataset](https://sites.google.com/view/mulran-pr/home) first
    1. login container: `bash login.sh`
    2. replay data: `roslaunch file_player file_player.launch`
   
