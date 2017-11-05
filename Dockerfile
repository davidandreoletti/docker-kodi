FROM ubuntu:17.10

ENV UID 1000
ENV GID 1000
ENV USER htpc
ENV GROUP htpc

ENV KODI_VERSION 2:17.5+git20171027.2324-final-0artful

RUN groupadd -r -g ${GID} ${GROUP} && adduser --disabled-password --uid ${UID} --ingroup ${GROUP} --gecos '' ${USER} \
 && apt-get update && apt-get install -y  --no-install-recommends software-properties-common \
 && add-apt-repository -y ppa:team-xbmc/ppa \
 && apt-get update && apt-get install -y  --no-install-recommends kodi=${KODI_VERSION} kodi-pvr-iptvsimple  tzdata  \
 && mkdir -p /home/${USER}/.kodi/ &&  chown -R ${USER}:${GROUP} /home/${USER}/.kodi/ \
 && usermod -a -G audio ${USER} \
 && apt-get autoremove && apt-get clean && rm -rf /var/lib/apt/lists/* 

USER ${USER}

VOLUME /home/${USER}/.kodi

LABEL version=${KODI_VERSION}
LABEL url=https://api.github.com/repos/xbmc/xbmc/releases/latest

CMD /usr/bin/kodi-standalone
