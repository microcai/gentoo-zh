#!/usr/bin/env sh
if [ "${GDK_BACKEND}" = "wayland" ]; then
    export GDK_BACKEND=x11
    /opt/baidunetdisk/baidunetdisk --no-sandbox "$@"
else
    /opt/baidunetdisk/baidunetdisk --no-sandbox "$@"
fi
