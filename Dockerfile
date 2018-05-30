FROM ubuntu:18.04

ENV UID 1000
ENV GID 1000
ENV USER htpc
ENV GROUP htpc

ENV KODI_VERSION 	2:17.6+git20180430.1623-final-0bionic

RUN groupadd -r -g ${GID} ${GROUP} && adduser --disabled-password --uid ${UID} --ingroup ${GROUP} --gecos '' ${USER} \
 && apt-get update && apt-get install -y  --no-install-recommends software-properties-common tzdata \
 && add-apt-repository -y ppa:team-xbmc/ppa \
 && apt-get update && apt-get install -y  --no-install-recommends kodi=${KODI_VERSION} kodi-pvr-iptvsimple  tzdata i965-va-driver  \
 && mkdir -p /home/${USER}/.kodi/ &&  chown -R ${USER}:${GROUP} /home/${USER}/.kodi/ \
 && usermod -a -G audio,video ${USER} \
 && apt-get autoremove && apt-get clean && rm -rf /var/lib/apt/lists/* 

USER ${USER}

VOLUME /home/${USER}/.kodi

LABEL version=${KODI_VERSION}
LABEL url=https://github.com/xbmc/xbmc/

CMD /usr/bin/kodi --standalone
