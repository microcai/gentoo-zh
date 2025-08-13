#!/bin/sh
export XDG_SESSION_TYPE=x11
export QT_QPA_PLATFORM=xcb
export QT_AUTO_SCREEN_SCALE_FACTOR=1
export QT_STYLE_OVERRIDE=fusion # 解决使用自带qt情况下，字体颜色全白看不到的问题
export IBUS_USE_PORTAL=1 # fix ibus
FONTCONFIG_DIR=$HOME/.config/fontconfig
unset WAYLAND_DISPLAY

# 解决非zh或en的语言设置闪退的问题
# if "^zh" is not detected in $LANG $LC_ALL $LANGUAGE, set language to en_GB, else zh_CN
if test "${LANG:0:2}" != "zh" -a "${LC_ALL:0:2}" != "zh" -a "${LANGUAGE:0:2}" != "zh"; then
	export LC_ALL="en_US.UTF-8"
else
	export LC_ALL="zh_CN.UTF-8"
fi

# if pipewire-pulse installed
if [ -f /usr/bin/pipewire-pulse ]; then
	# 解决Pipewire播放声音卡顿的问题
	export PULSE_LATENCY_MSEC=20
fi

if [ -e "/dev/nvidia0" ]; then
    # 解决 NVIDIA 显卡屏幕分享黑屏问题
    export __EGL_VENDOR_LIBRARY_FILENAMES="/usr/share/glvnd/egl_vendor.d/50_mesa.json"
fi

if [ -f "/usr/bin/bwrap" ];then
	mkdir -p $FONTCONFIG_DIR
	bwrap --dev-bind / / --tmpfs $HOME/.config --ro-bind $FONTCONFIG_DIR $FONTCONFIG_DIR /opt/wemeet/bin/wemeetapp $*
else
	exec /opt/wemeet/bin/wemeetapp $*
fi
