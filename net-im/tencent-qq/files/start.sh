#!/bin/bash
# From https://aur.archlinux.org/packages/linuxqq-nt-bwrap

USER_RUN_DIR="/run/user/$(id -u)"
CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}"
FONTCONFIG_DIR="$CONFIG_DIR/fontconfig"
QQ_APP_DIR="${CONFIG_DIR}/QQ"
DOWNLOAD_DIR="$(xdg-user-dir DOWNLOAD)"
if [ "$DOWNLOAD_DIR" == "$HOME" ]; then DOWNLOAD_DIR="$HOME/Downloads"; fi

cd /opt/QQ || die

bwrap --new-session --die-with-parent --cap-drop ALL --unshare-user-try --unshare-pid --unshare-cgroup-try \
	--symlink usr/lib /lib \
	--symlink usr/lib64 /lib64 \
	--symlink usr/bin /bin \
	--ro-bind /usr /usr \
	--ro-bind /opt/QQ /opt/QQ \
	--ro-bind /etc/ld.so.cache /etc/ld.so.cache \
	--dev-bind /dev /dev \
	--ro-bind /sys /sys \
	--ro-bind /etc/resolv.conf /etc/resolv.conf \
	--ro-bind /etc/localtime /etc/localtime \
	--proc /proc \
	--dev-bind /run/dbus /run/dbus \
	--bind "$USER_RUN_DIR" "$USER_RUN_DIR" \
	--ro-bind-try /etc/fonts /etc/fonts \
	--ro-bind-try "$FONTCONFIG_DIR" "$FONTCONFIG_DIR" \
	--bind /tmp /tmp \
	--bind "$HOME/.pki" "$HOME/.pki" \
	--ro-bind "$HOME/.Xauthority" "$HOME/.Xauthority" \
	--bind "${DOWNLOAD_DIR}" "${DOWNLOAD_DIR}" \
	--bind "$QQ_APP_DIR" "$QQ_APP_DIR" \
	--setenv IBUS_USE_PORTAL 1 \
	/opt/QQ/qq "$@"

# 移除无用崩溃报告和日志
# 如果需要向腾讯反馈 bug，请注释掉如下两行
rm -rf "$QQ_APP_DIR/crash_files"
rm -rf "$QQ_APP_DIR/nt_qq_"**"/nt_data/log/"*
