FROM ubuntu:17.04

ENV UID 1000
ENV GID 1000
ENV USER htpc
ENV GROUP htpc

ENV KODI_VERSION  2:17.4+git20170822.1009-final-0zesty

RUN groupadd -r -g ${GID} ${GROUP} && adduser --disabled-password --uid ${UID} --ingroup ${GROUP} --gecos '' ${USER} \
 && apt-get update && apt-get install -y  --no-install-recommends software-properties-common \
 && add-apt-repository -y ppa:team-xbmc/ppa \
 && apt-get update && apt-get install -y  --no-install-recommends kodi=${KODI_VERSION} kodi-pvr-iptvsimple \
 && mkdir -p /home/${USER}/.kodi/ &&  chown -R ${USER}:${GROUP} /home/${USER}/.kodi/ \
 && apt-get autoremove && apt-get clean && rm -rf /var/lib/apt/lists/* 

USER ${USER}

VOLUME /home/${USER}/.kodi

LABEL version=${KODI_VERSION}
LABEL url=https://api.github.com/repos/xbmc/xbmc/releases/latest

ENTRYPOINT [ "/usr/bin/kodi-standalone" ]
