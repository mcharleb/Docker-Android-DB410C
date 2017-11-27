#!/bin/bash
pushd `dirname $0`
pushd linux_android_board_support_package_vla.br.1.2.7-01010-8x16.0-4/APQ8016_410C_LA.BR.1.2.7-01010-8x16.0_6.0.1_Marsh_Mallo_P2/out/target/product/msm8916_64
fastboot flash boot boot.img
fastboot flash system system.img
fastboot flash userdata userdata.img
fastboot flash recovery recovery.img
fastboot flash persist persist.img
fastboot flash cache cache.img
fastboot reboot
popd
popd
