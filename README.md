# docker-kodi


`xhost +local:root`

`docker run -d --env DISPLAY=:0 --name=kodi --hostname=kodi  --privileged --net host lukasmrtvy/docker-kodi`
