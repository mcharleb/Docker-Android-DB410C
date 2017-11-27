#!/bin/bash

# Verify BSP was downloaded
if [ ! -f linux_android_board_support_package_vla.br_.1.2.7-01010-8x16.0-4.zip ]; then
	echo "Download the linux_android_board_support_package_vla.br_.1.2.7-01010-8x16.0-4.zip BSP from developer.qualcomm.com"
	exit 1
fi

# Unzip the BSP
if [ ! -f linux_android_board_support_package_vla.br.1.2.7-01010-8x16.0-4/unzipped ]; then
	unzip linux_android_board_support_package_vla.br_.1.2.7-01010-8x16.0-4.zip && \
		touch linux_android_board_support_package_vla.br.1.2.7-01010-8x16.0-4/unzipped
fi

# Create a script to sync without build
chmod +x linux_android_board_support_package_vla.br.1.2.7-01010-8x16.0-4/DB410c_build.sh
if [ ! -f linux_android_board_support_package_vla.br.1.2.7-01010-8x16.0-4/DB410c_sync.sh ]; then
	cp linux_android_board_support_package_vla.br.1.2.7-01010-8x16.0-4/DB410c_build.sh \
		linux_android_board_support_package_vla.br.1.2.7-01010-8x16.0-4/DB410c_sync.sh
	patch -n -p1 < patches/sync.patch
fi

# Fetch the files - needs user input for git settings
pushd linux_android_board_support_package_vla.br.1.2.7-01010-8x16.0-4
./DB410c_sync.sh
popd
