# Docker-Android-DB410C

Files to create a Docker image for building Android for Dragonboard 410C.
This is an Android Marshmallow based build and requires Ubuntu 14.04 to build it.

```
git clone https://github.com/mcharleb/Docker-Android-DB410C.git
cd Docker-Android-DB410C
```

## Prerequisites

Download the BSP zip file
```
linux_android_board_support_package_vla.br_.1.2.7-01010-8x16.0-4.zip
```
from Qualcomm Developer Network.

Fetch the files to build Android
```
./fetch.sh
```
This will need you to confirm your git config settings when it performs the "repo init".

You may need to run this multiple times untill all the repos are successfully downloaded.

## Building the Docker Image

Run
```
./build-docker-image.sh
```

## Entering the Docker image

The fetched and patched Android BSP will be mapped to /opt/android in the docker image

```
./run.sh ./linux_android_board_support_package_vla.br.1.2.7-01010-8x16.0-4
```
Now you are in the docker image.

## Add Optional Packages

```
pushd /opt/android/APQ8016_410C_LA.BR.1.2.7-01010-8x16.0_6.0.1_Marsh_Mallo_P2/packages/apps
git clone https://github.com/mcharleb/OnBootTestApp.git
popd
patch -n -p1 < patches/msm8916_64.patch
```

## Build Android

Go to /opt/android and start the build:
```
cd /opt/android
source DB410C_env
make -j10
```

## Rebuilding apps

You can now iteratively work on an application and recompile it:
```
cd packages/apps/OnBootTestApp
mm
```
## Using a Ubuuntu 14.04 VM

If you are using a Ubuntu 14.04 on Windows or Mac, you don't need the Docker image.
Use the following instructions:

- Make sure all the packages in Dockerfile are installed in your vm
```
sudo dpkg --add-architecture i386
sudo apt install \
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
		bc
```
- Clone this repo as above and follow the prerequisites step
- No need to build or enter the docker image
- Create a soft link to /opt/android
```
sudo ln -s `pwd` /opt/android
cd /opt/android
```
- Follow the instructions above to add additional packages and build
