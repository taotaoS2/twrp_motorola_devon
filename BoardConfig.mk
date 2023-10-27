# Platform
TARGET_BOARD_PLATFORM := bengal

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := $(PRODUCT_DEVICE)

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_VARIANT := generic

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv8-a
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := generic

# A/B device flags
TARGET_NO_RECOVERY := true
BOARD_USES_RECOVERY_AS_BOOT := true
AB_OTA_UPDATER := true
AB_OTA_PARTITIONS += system system_ext product vbmeta_system

# Kernel
BOARD_BOOTIMG_HEADER_VERSION := 3
BOARD_KERNEL_CMDLINE := console=ttyMSM0,115200n8 earlycon=msm_geni_serial,0x4a90000 androidboot.hardware=qcom androidboot.console=ttyMSM0 androidboot.memcg=1 lpm_levels.sleep_disabled=1 video=vfb:640x400,bpp=32,memsize=3072000 msm_rtb.filter=0x237 service_locator.enable=1 swiotlb=2048 loop.max_part=7 androidboot.hab.csv=12 androidboot.hab.product=devon androidboot.hab.cid=50 buildvariant=user
BOARD_KERNEL_PAGESIZE := 4096
BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOTIMG_HEADER_VERSION)
BOARD_KERNEL_IMAGE_NAME := Image
#BOARD_INCLUDE_DTB_IN_BOOTIMG := true
BOARD_KERNEL_SEPARATED_DTBO := true
TARGET_KERNEL_CONFIG := devon_defconfig

TARGET_PREBUILT_KERNEL := $(DEVICE_PATH)/prebuilts/kernel
TARGET_PREBUILT_DTB := $(DEVICE_PATH)/prebuilts/dtb.img
BOARD_MKBOOTIMG_ARGS += --dtb $(TARGET_PREBUILT_DTB)
BOARD_PREBUILT_DTBOIMAGE := $(DEVICE_PATH)/prebuilts/dtbo.img

# Partitions
BOARD_FLASH_BLOCK_SIZE := 262144 # (BOARD_KERNEL_PAGESIZE * 64)
BOARD_BOOTIMAGE_PARTITION_SIZE := 100663296
BOARD_DTBOIMG_PARTITION_SIZE := 25165824
BOARD_VENDOR_BOOTIMAGE_PARTITION_SIZE := 100663296
BOARD_SUPER_PARTITION_SIZE := 9126805504 # TODO: Fix hardcoded value
BOARD_SUPER_PARTITION_GROUPS := qti_dynamic_partitions
BOARD_QTI_DYNAMIC_PARTITIONS_PARTITION_LIST := system system_ext vendor product
BOARD_QTI_DYNAMIC_PARTITIONS_SIZE := 9122611200

# includes make_f2fs to support userdata partition in f2fs
TARGET_USERIMAGES_USE_F2FS := true

# Creates metadata partition mount point under root for
# the devices with metadata partition
BOARD_USES_METADATA_PARTITION := true

# Workaround for error copying vendor files to recovery ramdisk
TARGET_COPY_OUT_VENDOR := vendor

# Adjusted flags for decryption
PLATFORM_SECURITY_PATCH := 2099-12-31
VENDOR_SECURITY_PATCH := 2099-12-31
PLATFORM_VERSION := 99.87.36
PLATFORM_VERSION_LAST_STABLE := $(PLATFORM_VERSION)

# Recovery
TARGET_RECOVERY_PIXEL_FORMAT := RGBX_8888

# Fix for copying *.ko
BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES := true


##### TWRP Flags #####
TW_THEME := portrait_hdpi

# Include more languages than English
TW_EXTRA_LANGUAGES := true

# Brightness
TW_BRIGHTNESS_PATH := /sys/class/backlight/panel0-backlight/brightness
TW_DEFAULT_BRIGHTNESS := 1800

# Add support of able to wake with touch after sleep
TW_NO_SCREEN_BLANK := true

# Remove vibration support
TW_NO_HAPTICS := true

# Time
TARGET_RECOVERY_QCOM_RTC_FIX := true

# Statusbar icons flags
TW_STATUS_ICONS_ALIGN := center
TW_CUSTOM_CLOCK_POS := 50
TW_CUSTOM_CPU_POS := 280
TW_CUSTOM_BATTERY_POS := 790

# Use our own USB config
TW_EXCLUDE_DEFAULT_USB_INIT := true

# For mounting NTFS
TW_INCLUDE_NTFS_3G := true

# Use mke2fs for formatting ext4 partitions
TARGET_USES_MKE2FS := true

# Include magiskboot for repacking bootimg
TW_INCLUDE_REPACKTOOLS := true

# Kernel module loading for touch, battery etc
TW_LOAD_VENDOR_MODULES := "adapter_class.ko cw2217b_fg_mmi.ko mmi_annotate.ko mmi_charger.ko mmi_discrete_charger_class.ko mmi_discrete_charger.ko mmi_info.ko qpnp_adaptive_charge.ko rt_pd_manager.ko sgm4154x_charger.ko tcpc_class.ko tcpc_sgm7220.ko"

# Include decryption support
TW_INCLUDE_CRYPTO := true
RECOVERY_SDCARD_ON_DATA := true
# include below when enabling decryption
# without these it may stuck on TWRP splash
TARGET_RECOVERY_DEVICE_MODULES += libion
RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libion.so

# Verified Boot
BOARD_AVB_ENABLE := true
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --flags 3

# Don't mount apex files (no need for now)
TW_EXCLUDE_APEX := true

# Debuging flags
TWRP_INCLUDE_LOGCAT := true
TARGET_USES_LOGD := true
TW_INCLUDE_RESETPROP := true
