# docker-kodi

## Info:
Based on: Ubuntu

Based on: Debian stretch-slim. Compiled from Source.

## Usage:
More info about X11 and Docker: http://wiki.ros.org/docker/Tutorials/GUI

```
cat /etc/systemd/system/xinit.service 
[Unit]
Description=Autologin to X
After=systemd-user-sessions.service

[Service]
ExecStart=/usr/bin/X :0
StandardOutput=syslog

[Install]
WantedBy=multi-user.target
```

## Allow X11 host
```
xhost +local:`docker inspect --format='{{ .Config.Hostname }}' kodi
```

## Run
```
sudo docker pull lukasmrtvy/docker-kodi ; 
sudo docker rm -f kodi ; 
sudo docker run -d --restart always --env DISPLAY=:0 -p 9090:9090 -p 8080:8080 --device /dev/snd --device /dev/dri --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw"  --name=kodi -v kodi:/home/htpc/.kodi  lukasmrtvy/docker-kodi
```
