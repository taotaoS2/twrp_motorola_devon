#
#	This file is part of the OrangeFox Recovery Project
# 	Copyright (C) 2021-2022 The OrangeFox Recovery Project
#
#	OrangeFox is free software: you can redistribute it and/or modify
#	it under the terms of the GNU General Public License as published by
#	the Free Software Foundation, either version 3 of the License, or
#	any later version.
#
#	OrangeFox is distributed in the hope that it will be useful,
#	but WITHOUT ANY WARRANTY; without even the implied warranty of
#	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#	GNU General Public License for more details.
#
# 	This software is released under GPL version 3 or any later version.
#	See <http://www.gnu.org/licenses/>.
#
# 	Please maintain this if you use this script or any part of it
#
FDEVICE="devon"
fox_get_target_device() {
local chkdev=$(echo "$BASH_SOURCE" | grep -w $FDEVICE)
   if [ -n "$chkdev" ]; then
      FOX_BUILD_DEVICE="$FDEVICE"
   else
      chkdev=$(set | grep BASH_ARGV | grep -w $FDEVICE)
      [ -n "$chkdev" ] && FOX_BUILD_DEVICE="$FDEVICE"
   fi
}

if [ -z "$1" -a -z "$FOX_BUILD_DEVICE" ]; then
   fox_get_target_device
fi

if [ "$1" = "$FDEVICE" -o "$FOX_BUILD_DEVICE" = "$FDEVICE" ]; then

 # Fox-specific flags
 export FOX_ENABLE_APP_MANAGER=0
 export FOX_DELETE_AROMAFM=1
 export FOX_DELETE_INITD_ADDON=1 # !- Causes bootloops sometimes -!
 export FOX_BUGGED_AOSP_ARB_WORKAROUND="1616300800"; # Sun 21 Mar 04:26:40 GMT 2021
 export OF_QUICK_BACKUP_LIST="/boot;/data;"
 export OF_USE_MAGISKBOOT_FOR_ALL_PATCHES=1
 export OF_DONT_PATCH_ENCRYPTED_DEVICE=1
 export OF_NO_TREBLE_COMPATIBILITY_CHECK=1

 # Binaries & Tools
 export FOX_USE_BASH_SHELL=1
 export FOX_ASH_IS_BASH=1
 export FOX_USE_NANO_EDITOR=1
 export FOX_USE_TAR_BINARY=1
 export FOX_USE_SED_BINARY=1
 export FOX_USE_XZ_UTILS=1
 export OF_ENABLE_LPTOOLS=1

 # Version & Variant
 export FOX_VERSION="R11.1"
 export FOX_VARIANT="A12.1"

 # MIUI & Custom ROMs
 export OF_VIRTUAL_AB_DEVICE=1
 export OF_NO_MIUI_PATCH_WARNING=1
 export OF_PATCH_AVB20=1

 # Disable Flashlight & Green LED
 export OF_FLASHLIGHT_ENABLE=0
 export OF_USE_GREEN_LED=0

 # Use magisk 25.2 for the magisk addon
 export FOX_USE_SPECIFIC_MAGISK_ZIP="$PWD/device/motorola/devon/addon/Magisk-v25.2.zip"

 # Security (Disables MTP&ADB during password prompt)
 export FOX_ADVANCED_SECURITY=1

 # Screen settings
 export OF_SCREEN_H=2400
 export OF_STATUS_H=-70
 export OF_STATUS_INDENT_LEFT=48
 export OF_STATUS_INDENT_RIGHT=48
 export OF_ALLOW_DISABLE_NAVBAR=0
 export OF_HIDE_NOTCH=1
 export OF_CLOCK_POS=1 # Left & Right

 # Maximum permissible splash image size (in kilobytes); do *NOT* increase!
 export OF_SPLASH_MAX_SIZE=130

 # CCACHE
 export USE_CCACHE=1
 export CCACHE_EXEC=/usr/bin/ccache

 CCACHE_DIR="/media/${USERNAME}/ccache"

 if [ -d ${CCACHE_DIR} ];
  then
   export CCACHE_DIR=${CCACHE_DIR}
  else
   echo "CCACHE Directory/Partition is not mounted at \"${CCACHE_DIR}\""
   echo "Please edit the CCACHE_DIR build variable or mount the directory."
 fi

 # Debugging
 ## export FOX_RESET_SETTINGS=0
 ## export FOX_INSTALLER_DEBUG_MODE=1

 # Other..
 export TW_DEFAULT_LANGUAGE="en"
 export LC_ALL="C"

 # Let's see what are our build VARs
 if [ -n "$FOX_BUILD_LOG_FILE" -a -f "$FOX_BUILD_LOG_FILE" ]; then
  export | grep "FOX" >> $FOX_BUILD_LOG_FILE
  export | grep "OF_" >> $FOX_BUILD_LOG_FILE
  export | grep "TARGET_" >> $FOX_BUILD_LOG_FILE
  export | grep "TW_" >> $FOX_BUILD_LOG_FILE
 fi
fi
#
