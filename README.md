# docker-kodi

## Branches:
- Ubuntu (main)
- Debian stretch-slim. Compiled from Source.

## Usage:
More info about X11 and Docker: http://wiki.ros.org/docker/Tutorials/GUI

```
cat /etc/systemd/system/x11.service 
[Unit]
Description=Autologin to X
After=systemd-user-sessions.service

[Service]
ExecStart=/usr/bin/X :0

[Install]
WantedBy=multi-user.target
```

## Allow X11 host
```
xhost +local:`docker inspect --format='{{ .Config.Hostname }}' kodi
```

## Run
```
docker pull lukasmrtvy/dockerkodi:master ; 
docker rm -f kodi ; 
docker run -d --restart always --env DISPLAY=:0 -p 9090:9090 -p 8080:8080 --device /dev/snd --device /dev/dri --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw"  --name=kodi -v kodi:/home/htpc/.kodi  lukasmrtvy/dockerkodi:master
```
## Monitor powersettings
https://wiki.archlinux.org/index.php/Display_Power_Management_Signaling

To query the current settings:
```
export DISPLAY=:0
xset q
```
Disable:
```
echo "@reboot root sh -c 'DISPLAY=:0 ; xset s off -dpms' > /dev/null 2>&1" >> /etc/crontab
```
or in:
`/usr/share/X11/xorg.conf.d/`

## TODO
```
#https://kodi.wiki/view/Web_interface
#sed -i -e /home/${USER}/.kodi/userdata/guisettings.xml
#sed -i -e /home/${USER}/.kodi/userdata/advancedsettings.xml 
#ln -s /dev/stdout /home/${USER}/.kodi/temp/kodi.log && \
```
