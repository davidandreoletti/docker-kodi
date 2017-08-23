FROM ubuntu:17.04

RUN apt-get update && apt-get install -y software-properties-common
RUN add-apt-repository -y ppa:team-xbmc/ppa
RUN apt-get update && apt-get install -y kodi kodi-pvr-iptvsimple

ENTRYPOINT [ "/usr/bin/kodi" ]
