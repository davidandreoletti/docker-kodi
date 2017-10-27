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


`xhost +local:`docker inspect --format='{{ .Config.Hostname }}' kodi``

`docker run -d --env DISPLAY=:0 --name=kodi --hostname=kodi  --privileged -v kodi:/home/htpc/.kodi --net host lukasmrtvy/docker-kodi`
