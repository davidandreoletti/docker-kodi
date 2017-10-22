FROM debian:stretch-slim

ENV UID 1000
ENV GID 1000
ENV USER htpc
ENV GROUP htpc


ENV KODI_VERSION 17.4-Krypton

ARG DEBIAN_FRONTEND="noninteractive"

ARG BUILD_DEPENDENCIES="\
  ant \
  git-core \
  build-essential \
  autoconf \
  automake \
  cmake \
  pkg-config \
  autopoint \
  libtool \
  swig \
  doxygen \
  openjdk-7-jre-headless \
  default-jdk \
  libbz2-dev \
  liblzo2-dev \
  libtinyxml-dev \
  libmysqlclient-dev \
  libcurl4-openssl-dev \
  libssl-dev \
  libyajl-dev \
  libxml2-dev \
  libxslt-dev \
  libsqlite3-dev \
  libnfs-dev \
  libpcre3-dev \
  libtag1-dev \
  libsmbclient-dev \
  libmicrohttpd-dev \
  libgnutls28-dev \
  libass-dev \
  libxrandr-dev \
  libegl1-mesa-dev \
  libglu1-mesa-dev \
  gawk \
  gperf \
  curl \
  m4 \
  python-dev \
  uuid-dev \
  yasm \
  unzip \
  libiso9660-dev \
  zip \
  "

ARG RUNTIME_DEPENDENCIES="\
  libcurl3 \
  libegl1-mesa \
  libglu1-mesa \
  libfreetype6 \
  libfribidi0 \
  libglew1.10 \
  liblzo2-2 \
  libmicrohttpd10 \
  libmysqlclient18 \
  libnfs4 \
  libpcrecpp0 \
  libpython2.7 \
  libsmbclient \
  libtag1c2a \
  libtinyxml2.6.2 \
  libxml2 \
  libxrandr2 \
  libxslt1.1 \
  libyajl2 \
  "
 
 
RUN groupadd -r -g ${GID} ${GROUP} && adduser --disabled-password --uid ${UID} --ingroup ${GROUP} --gecos '' ${USER} && \
    echo "deb-src http://deb.debian.org/debian/ stable main contrib non-free" >> /etc/apt/sources.list && \
    mkdir -p /usr/share/man/man1 && \
    apt update && \
   #  apt install -y libssl-dev  devscripts && \
   apt-get install --no-install-recommends -y $BUILD_DEPENDENCIES && \
   #  mk-build-deps -ir -t "apt-get -qq --no-install-recommends" kodi && \
    apt install tar -y && mkdir -p /tmp/kodi && curl -L https://github.com/xbmc/xbmc/archive/${KODI_VERSION}.tar.gz | tar xz -C /tmp/kodi --strip-components=1 && \
    cd /tmp/kodi && ./bootstrap && ./configure && make -j $(getconf _NPROCESSORS_ONLN) && make install -j $(getconf _NPROCESSORS_ONLN) && \
 #   apt-get purge -y --auto-remove kodi-build-deps && \
    apt-get purge --auto-remove -y $BUILD_DEPENDENCIES && \
  #   apt-get autoremove -y && \
    apt-get clean -y && \
    rm -rf /tmp/* /var/tmp/* /var/cache/apt/archives/* /var/lib/apt/lists/*



LABEL url=https://api.github.com/repos/xbmc/xbmc/releases/latest
LABEL version=${KODI_VERSION}

RUN  apt-get install --no-install-recommends -y $RUNTIME_DEPENDENCIES && \
  apt-get clean && \
  rm -rf /tmp/kodi* && \

#RUN apt update && apt install -y	libavahi-client-dev libmicrohttpd-dev 	libglu1-mesa libtinyxml2.6.2v5 \
#libcrossguid0 	libyajl-dev 	libxslt1-dev 	libpcrecpp0v5  	libfreetype6 	libtag1v5-vanilla libcdio13 libasound2 	libpulse0

#RUN ls -lha /usr/local/lib/ && ldd /usr/local/lib/kodi

#CMD /opt/kodi/usr/local/bin/kodi-standalone

USER ${USER}

CMD kodi
