#
# Docker image to build Qualcomm Android BSP for Dragonboard 410C
#

FROM ubuntu:trusty
MAINTAINER Mark Charlebois <charlebm@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

RUN dpkg --add-architecture i386
RUN apt-get update \
	&& DEBIAN_FRONTEND=noninteractive apt-get -y --quiet --no-install-recommends install \
		bzip2 \
		ca-certificates \
		openjdk-7-jdk-headless \
		sudo \
		unzip \
		vim-common \
		wget \
		xsltproc \
		git \
		ccache \
		automake \
		lzop \
		bison \
		gperf \
		build-essential \
		zip \
		curl \
		zlib1g-dev \
		zlib1g-dev:i386 \
		g++-multilib \
		python-networkx \
		libxml2-utils \
		bzip2 \
		libbz2-dev \
		libbz2-1.0 \
		patch \
		genisoimage \
		rsync \
		bc \
	&& apt-get -y autoremove \
	&& apt-get clean autoclean

# Add gosu
RUN gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4
RUN curl -o /usr/local/bin/gosu -SL "https://github.com/tianon/gosu/releases/download/1.4/gosu-$(dpkg --print-architecture)" \
    && curl -o /usr/local/bin/gosu.asc -SL "https://github.com/tianon/gosu/releases/download/1.4/gosu-$(dpkg --print-architecture).asc" \
    && gpg --verify /usr/local/bin/gosu.asc \
    && rm /usr/local/bin/gosu.asc \
    && chmod +x /usr/local/bin/gosu

# Android build seems to want bash as default shell
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# Install repo tool
RUN curl https://storage.googleapis.com/git-repo-downloads/repo \
      -o /usr/local/bin/repo && \
    chmod +x /usr/local/bin/repo

ENV CCACHE_CPP2=1
ENV CCACHE_MAXSIZE=1G
ENV DISPLAY :0
ENV PATH "/usr/lib/ccache:$PATH"
ENV TERM=xterm

# create and start as LOCAL_USER_ID
COPY scripts/entrypoint.sh /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

CMD ["/bin/bash"]
