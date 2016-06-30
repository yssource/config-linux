#!/bin/bash

_TARGET_PRODUCT="android_x86"
_TARGET_BUILD_VARIANT="userdebug"
_NEED_CLEAN=""

echo $1
while ! [ -z $1 ]
do
	case $1 in
		"32" )
			_TARGET_PRODUCT="android_x86" 
			;;
		"64" )
			_TARGET_PRODUCT="android_x86_64" 
			;;
		"user" | "userdeug" | "eng" )
			_TARGET_BUILD_VARIANT="$1"
			;;
		"clean" )
			_NEED_CLEAN=clean
			;;
		* )
			;;
	esac

	shift
done

TARGET="$_TARGET_PRODUCT-$_TARGET_BUILD_VARIANT"
echo $TARGET

source ./build/envsetup.sh
lunch $TARGET

#make clean
[ -z $_NEED_CLEAN ] || make clean

# Timing
#TIME_START=`date +%s`
make iso_img -j12
#TIME_END=`date +%s`

#TIME_MIN=$(( ($TIME_END - $TIME_START) / 60 ))
#TIME_SEC=$(( ($TIME_END - $TIME_START) % 60))
#
#echo "Use time: "$TIME_MIN"m "$TIME_SEC"s"