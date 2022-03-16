#!/bin/bash
set -e
set -x 

export GST_DEBUG=nvarguscamerasrc:7

gst-launch-1.0 -e \
nvarguscamerasrc sensor-id=0 bufapi-version=1 silent=false ! \
"video/x-raw(memory:NVMM),format=(string)NV12,width=(int)1920,height=(int)1080,framerate=(fraction)30/1" ! \
queue ! nvvideoconvert ! 'video/x-raw(memory:NVMM), format=(string)RGBA' ! queue ! fakesink sync=0 async=0 

# gst-launch-1.0 -e \
# nvarguscamerasrc bufapi-version=1 sensor-id=0 silent=false ! \
# 'video/x-raw(memory:NVMM), format=(string)NV12, width=(int)1920, height=(int)1080, framerate=(fraction)30/1' ! m.sink_0 \
# nvarguscamerasrc bufapi-version=1 sensor-id=1 silent=false ! \
# 'video/x-raw(memory:NVMM), format=(string)NV12, width=(int)1920, height=(int)1080, framerate=(fraction)30/1' ! m.sink_1 \
# nvstreammux batch-size=2 width=1920 height=1080  live-source=1 name=m ! \
# "video/x-raw(memory:NVMM),format=(string)NV12,width=(int)1920,height=(int)1080,framerate=(fraction)30/1" ! \
# nvdspreprocess config-file= /opt/nvidia/deepstream/deepstream/sources/gst-plugins/gst-nvdspreprocess/config_preprocess.txt ! \
# nvmultistreamtiler width=4032 height=1080 rows=1 columns=2 ! \
# nvvideoconvert ! 'video/x-raw(memory:NVMM), format=(string)I420' ! \
# nvv4l2h264enc bitrate=8000000 ! h264parse ! qtmux ! filesink location="/home/camera/reeplayer/test.mp4" sync=0 async=0 


# gst-launch-1.0 -e \
# nvarguscamerasrc bufapi-version=1 sensor-id=0 silent=false ! \
# 'video/x-raw(memory:NVMM), format=(string)NV12, width=(int)1920, height=(int)1080, framerate=(fraction)30/1' ! m.sink_0 \
# nvarguscamerasrc bufapi-version=1 sensor-id=1 silent=false ! \
# 'video/x-raw(memory:NVMM), format=(string)NV12, width=(int)1920, height=(int)1080, framerate=(fraction)30/1' ! m.sink_1 \
# nvstreammux batch-size=2 width=1920 height=1080  live-source=1 name=m ! \
# nvvideoconvert ! 'video/x-raw(memory:NVMM), format=(string)RGBA' ! \
# videostitcher mode=0 input-width=1920 input-height=1080 ! \
# nvvideoconvert ! 'video/x-raw(memory:NVMM), format=(string)I420' ! \
# nvv4l2h264enc bitrate=8000000 ! h264parse ! qtmux ! filesink location="/home/camera/reeplayer/test.mp4" sync=0 async=0 
# gst-launch-1.0 -e \
# nvarguscamerasrc bufapi-version=1 sensor-id=0 silent=false ! \
# 'video/x-raw(memory:NVMM), format=(string)NV12, width=(int)1920, height=(int)1080, framerate=(fraction)30/1' ! m.sink_0 \
# nvarguscamerasrc bufapi-version=1 sensor-id=1 silent=false ! \
# 'video/x-raw(memory:NVMM), format=(string)NV12, width=(int)1920, height=(int)1080, framerate=(fraction)30/1' ! m.sink_1 \
# nvstreammux batch-size=2 width=1920 height=1080  live-source=1 name=m ! \
# nvdspreprocess config-file= /opt/nvidia/deepstream/deepstream/sources/gst-plugins/gst-nvdspreprocess/config_preprocess.txt ! \
# nvmultistreamtiler width=4032 height=1080 rows=1 columns=2 ! \
# nvvideoconvert ! 'video/x-raw(memory:NVMM), format=(string)I420' !\
# nvv4l2h264enc bitrate=8000000 ! h264parse ! qtmux ! filesink location="/home/camera/reeplayer/test.mp4" sync=0 async=0 

set +x 