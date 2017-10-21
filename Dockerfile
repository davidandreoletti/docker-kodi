FROM debian:stretch-slim

ENV UID 1000
ENV GID 1000
ENV USER htpc
ENV GROUP htpc

ENV DEBIAN_FRONTEND noninteractive

ENV KODI_VERSION 17.4-Krypton
 
 
RUN groupadd -r -g ${GID} ${GROUP} && adduser --disabled-password --uid ${UID} --ingroup ${GROUP} --gecos '' ${USER} && \
    echo "deb-src http://deb.debian.org/debian/ stable main contrib non-free" >> /etc/apt/sources.list && \
    mkdir -p /usr/share/man/man1 && \
    apt update && \
    apt install -y libssl-dev  devscripts && \
    mk-build-deps -ir -t "apt-get -qq --no-install-recommends" kodi && \
    apt install tar -y && mkdir -p /tmp/kodi && curl -L https://github.com/xbmc/xbmc/archive/${KODI_VERSION}.tar.gz | tar xz -C /tmp/kodi --strip-components=1 && \
    cd /tmp/kodi && ./bootstrap && ./configure && make -j4 && make install DESTDIR=/opt/kodi -j4 && \
    apt-get purge -y --auto-remove kodi-build-deps && \
    apt-get autoremove -y && \
    apt-get clean -y && \
    rm -rf /tmp/* /var/tmp/* /var/cache/apt/archives/* /var/lib/apt/lists/*

USER ${USER}

LABEL url=https://api.github.com/repos/xbmc/xbmc/releases/latest
LABEL version=${KODI_VERSION}

RUN ls -lha /opt/kodi/usr/local/ && ls -lha  /opt/kodi/usr/local/bin/ && ls -lha  /opt/kodi/usr/local/lib/




CMD /opt/kodi//usr/local/bin/kodi-standalone

