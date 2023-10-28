# Inherit from common AOSP config
$(call inherit-product, $(SRC_TARGET_DIR)/product/base.mk)
# Inherit some common TWRP stuff.
$(call inherit-product, vendor/twrp/config/common.mk)

PRODUCT_DEVICE := devon
PRODUCT_NAME := twrp_devon
PRODUCT_BRAND := motorola
PRODUCT_MODEL := moto g32
PRODUCT_MANUFACTURER := motorola

PRODUCT_GMS_CLIENTID_BASE := android-motorola

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRIVATE_BUILD_DESC="devon_g-user 11 S2SNS32.34-72-31-1 3841be release-keys"

BUILD_FINGERPRINT := motorola/devon_g/devon:11/S2SNS32.34-72-31-1/3841be:user/release-keys

# Default device path for tree
DEVICE_PATH := device/$(PRODUCT_BRAND)/$(PRODUCT_DEVICE)

# Inherit from device
$(call inherit-product, $(DEVICE_PATH)/device.mk)
