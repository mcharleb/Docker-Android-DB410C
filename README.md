# Docker-Android-DB410C

Files to create a Docker image for building Android for Dragonboard 410C.
This is an Android Marshmallow based build and requires Ubuntu 14.04 to build it.

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
cd /opt/android/APQ8016_410C_LA.BR.1.2.7-01010-8x16.0_6.0.1_Marsh_Mallo_P2/packages/apps
git clone https://github.com/mcharleb/OnBootTestApp.git
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
