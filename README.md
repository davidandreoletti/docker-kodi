# docker-kodi

## Info:
Based on: Ubuntu
Based on: Debian stretch-slim. Compiled from Source.

## Usage:
More info about X11 and Docker: http://wiki.ros.org/docker/Tutorials/GUI

`xhost +local:`docker inspect --format='{{ .Config.Hostname }}' kodi``
`docker run -d --env DISPLAY=:0 --name=kodi --hostname=kodi  --privileged --net host lukasmrtvy/docker-kodi`
