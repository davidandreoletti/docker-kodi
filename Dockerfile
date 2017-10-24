FROM ubuntu:17.04

RUN apt-get update && apt-get install -y  --no-install-recommends software-properties-common \
 &&  add-apt-repository -y ppa:team-xbmc/ppa \
 && apt-get update && apt-get install -y  --no-install-recommends kodi kodi-pvr-iptvsimple \
 && apt-get autoremove && apt-get clean && rm -rf /var/lib/apt/lists/* 

ENTRYPOINT [ "/usr/bin/kodi" ]
