#!/usr/bin/env bash
set -x 

export GST_DEBUG=nvarguscamerasrc:7,gst_nv_argus_camera_src_debug=7

# single camera, mp4 recording
gst-launch-1.0 -e \
nvarguscamerasrc bufapi-version=1 sensor-id=0 silent=false ! \
"video/x-raw(memory:NVMM),format=(string)NV12,width=(int)1920,height=(int)1080,framerate=(fraction)30/1" ! \
nvv4l2h264enc bitrate=8000000 ! h264parse ! qtmux ! filesink location="test.mp4" sync=false async=false \

# dual cameras, mp4 recording 
gst-launch-1.0 -e nvstreammux batch-size=2 width=1920 height=1080  live-source=1 name=m ! \
"video/x-raw(memory:NVMM),format=(string)NV12,width=(int)1920,height=(int)1080,framerate=(fraction)30/1" ! \
nvmultistreamtiler width=3840 height=1080 rows=1 columns=2 ! \
nvvideoconvert ! 'video/x-raw(memory:NVMM), format=(string)I420' ! \
nvv4l2h264enc bitrate=8000000 ! h264parse ! qtmux ! filesink location="test.mp4" sync=false async=false \
nvarguscamerasrc bufapi-version=1 sensor-id=0 silent=false ! \
'video/x-raw(memory:NVMM), format=(string)NV12, width=(int)1920, height=(int)1080, framerate=(fraction)30/1' ! m.sink_0 \
nvarguscamerasrc bufapi-version=1 sensor-id=1 silent=false ! \
'video/x-raw(memory:NVMM), format=(string)NV12, width=(int)1920, height=(int)1080, framerate=(fraction)30/1' ! m.sink_1 

# dual cameras, rtp/udp sreaming 
gst-launch-1.0 -e nvstreammux batch-size=2 width=1920 height=1080  live-source=1 name=m ! \
"video/x-raw(memory:NVMM),format=(string)NV12,width=(int)1920,height=(int)1080,framerate=(fraction)30/1" ! \
nvmultistreamtiler width=3840 height=1080 rows=1 columns=2 ! \
nvvideoconvert ! 'video/x-raw(memory:NVMM), format=(string)I420' ! \
nvv4l2h264enc bitrate=8000000 insert-sps-pps=true ! rtph264pay mtu=1400 ! udpsink host=127.0.0.1 port=5000 sync=false async=false \
nvarguscamerasrc bufapi-version=1 sensor-id=0 silent=false ! \
'video/x-raw(memory:NVMM), format=(string)NV12, width=(int)1920, height=(int)1080, framerate=(fraction)30/1' ! m.sink_0 \
nvarguscamerasrc bufapi-version=1 sensor-id=1 silent=false ! \
'video/x-raw(memory:NVMM), format=(string)NV12, width=(int)1920, height=(int)1080, framerate=(fraction)30/1' ! m.sink_1 

# dual cameras, screen display 
gst-launch-1.0 -e nvstreammux batch-size=2 width=1920 height=1080  live-source=1 name=m ! \
"video/x-raw(memory:NVMM),format=(string)NV12,width=(int)1920,height=(int)1080,framerate=(fraction)30/1" ! \
nvmultistreamtiler width=3840 height=1080 rows=1 columns=2 ! \
nvegltransform ! nveglglessink \
nvarguscamerasrc bufapi-version=1 sensor-id=0 silent=false ! \
'video/x-raw(memory:NVMM), format=(string)NV12, width=(int)1920, height=(int)1080, framerate=(fraction)30/1' ! m.sink_0 \
nvarguscamerasrc bufapi-version=1 sensor-id=1 silent=false ! \
'video/x-raw(memory:NVMM), format=(string)NV12, width=(int)1920, height=(int)1080, framerate=(fraction)30/1' ! m.sink_1 

set +x
