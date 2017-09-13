# docker-kodi


xhost +local:root

`docker run -it --env "DISPLAY=:0" --name=kodi --hostname=kodi --user=root --volume="/docker/kodi:/home/$USER" --volume="/etc/group:/etc/group:ro" --device="/dev/dri/card0" --device="/dev/snd" --volume="/etc/passwd:/etc/passwd:ro" --volume="/etc/shadow:/etc/shadow:ro" --volume="/etc/sudoers.d:/etc/sudoers.d:ro" --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" kodi`
