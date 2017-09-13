FROM debian:stretch-slim


ARG DEBIAN_FRONTEND=noninteractive


RUN echo "deb-src http://deb.debian.org/debian/ stable main contrib non-free" >> /etc/apt/sources.list && cat /etc/apt/sources.list && mkdir -p /usr/share/man/man1 && apt update && apt install -y git-core libssl-dev xorg curl wget apt-transport-https dirmngr openjdk-8-jre-headless \

&& apt-get build-dep -y kodi

RUN mkdir -p /opt/kodi && curl -sL https://github.com/xbmc/xbmc/archive/17.4-Krypton.tar.gz | tar xz -C /opt/kodi --strip-components=1

RUN cd /opt/kodi && ./bootstrap && ./configure && make -j4 && make install -j4

CMD kodi

