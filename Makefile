export ARCHS = armv7 arm64

export THEOS_DEVICE_IP=localhost
export THEOS_DEVICE_PORT=2222

include theos/makefiles/common.mk

TWEAK_NAME = AppNoti
AppNoti_FILES = Tweak.xm
AppNoti_PRIVATE_FRAMEWORKS=BulletinBoard

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
SUBPROJECTS += appnoti
include $(THEOS_MAKE_PATH)/aggregate.mk
