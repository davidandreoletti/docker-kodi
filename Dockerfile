FROM debian:stretch-slim as builder

ENV DEBIAN_FRONTEND=noninteractive
ENV KODI_VERSION 17.4-Krypton

RUN  echo "deb-src http://deb.debian.org/debian/ stable main contrib non-free" >> /etc/apt/sources.list && \
     mkdir -p /usr/share/man/man1 && \
    apt update && \
    apt install -y libssl-dev  devscripts && \
    mk-build-deps -ir -t "apt-get -qq --no-install-recommends" kodi

RUN mkdir -p /tmp/kodi && mkdir -p /opt/kodi && curl -sL https://github.com/xbmc/xbmc/archive/${KODI_VERSION}.tar.gz | tar xz -C /tmp/kodi --strip-components=1
RUN cd /tmp/kodi && ./bootstrap && ./configure && make -j4 && make install DESTDIR=/opt/kodi -j4

RUN apt-get purge -y --auto-remove kodi-build-deps && \
    apt-get autoremove -y && \
    apt-get clean -y && \
    rm -rf /tmp/* /var/tmp/* /var/cache/apt/archives/* /var/lib/apt/lists/*


#FROM debian:stretch-slim

#COPY --from=builder   /opt/kodi/*  /

CMD kodi

