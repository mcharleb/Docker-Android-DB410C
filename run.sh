#!/bin/bash


[ "$1" = "" ] && echo "Usage $0 BSPDIR" && exit 1

if [ ! -d $1 ]; then
	echo "$1 does not exist"
	echo "Usage $0 BSPDIR"
	exit 1
fi
ANDROID_BSP=`readlink -f $1`
docker run -it -e LOCAL_USER_NAME="`id --user --name`" -e LOCAL_USER_ID="`id --user`" -v ${ANDROID_BSP}:/opt/android android-6-builder /bin/bash
