#!/bin/bash

function command_exists() {
	local command="$1"
	command -v "${command}" >/dev/null 2>&1
}

function show_error_dialog() {
    title="linuxqq-nt-bwrap"
    if command_exists kdialog; then
        kdialog --error "$1" --title "$title" --icon qq
    elif command_exists zenity; then
        zenity --error --title "$title" --icon-name qq --text "$1"
    else
        all_off="$(tput sgr0)"
        bold="${all_off}$(tput bold)"
        blue="${bold}$(tput setaf 4)"
        yellow="${bold}$(tput setaf 3)"
        printf "${blue}==>${yellow} ${bold} $1${all_off}\n"
    fi
}

if [ ! -e "/etc/localtime" ]; then
    show_error_dialog "/etc/localtime 未找到。\n请先设置系统时区。"
    exit 1
fi

USER_RUN_DIR="/run/user/$(id -u)"
XAUTHORITY="${XAUTHORITY:-$HOME/.Xauthority}"
XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
FONTCONFIG_HOME="${XDG_CONFIG_HOME}/fontconfig"
QQ_APP_DIR="${XDG_CONFIG_HOME}/QQ"
if [ -z "${QQ_DOWNLOAD_DIR}" ]; then
    if [ -z "${XDG_DOWNLOAD_DIR}" ]; then
        XDG_DOWNLOAD_DIR="$(xdg-user-dir DOWNLOAD)"
    fi
    QQ_DOWNLOAD_DIR="${XDG_DOWNLOAD_DIR:-$HOME/Downloads}"
fi

# 从 flags 文件中加载参数

set -euo pipefail
flags_file="${XDG_CONFIG_HOME}/qq-flags.conf"
declare -a flags

if [[ -f "${flags_file}" ]]; then
    mapfile -t < "${flags_file}"
fi

for line in "${MAPFILE[@]}"; do
    if [[ ! "${line}" =~ ^[[:space:]]*#.* ]]; then
        flags+=("${line}")
    fi
done

QQ_HOTUPDATE_DIR="${QQ_APP_DIR}/versions"
QQ_HOTUPDATE_VERSION="3.2.0-16449"
QQ_PREVIOUS_VERSIONS=("2.0.1-429" "2.0.1-453" "2.0.2-510" "2.0.3-543" "3.0.0-565" "3.0.0-571" "3.1.0-9332" "3.1.0-9572" "3.1.1-11223" "3.1.2-12912" "3.1.2-13107")


if [ "${QQ_DOWNLOAD_DIR%*/}" == "${HOME}" ]; then
    QQ_DOWNLOAD_DIR="${HOME}/Downloads"
    # if [ ! -d "${QQ_DOWNLOAD_DIR}" ]; then mkdir -p "${QQ_DOWNLOAD_DIR}"; fi
    # 还是不自动建立为好
fi

if [ ! -d "${QQ_APP_DIR}" ]; then mkdir -p "${QQ_APP_DIR}"; fi
if [ ! -d "${QQ_HOTUPDATE_DIR}" ]; then mkdir -p "${QQ_HOTUPDATE_DIR}"; fi
if [ ! -L "${QQ_HOTUPDATE_DIR}/${QQ_HOTUPDATE_VERSION}" ]; then
    # 删除 QQ 自动下载的热更新包，因为其中可能包含 libvips 等有问题的库
    rm -rf "${QQ_HOTUPDATE_DIR}/${QQ_HOTUPDATE_VERSION}"
fi
if [ ! -d "${QQ_HOTUPDATE_DIR}/${QQ_HOTUPDATE_VERSION}" ]; then
    # 将本包内的 app 链接到热更新文件夹下
    ln -sfd "/opt/QQ/resources/app" "${QQ_HOTUPDATE_DIR}/${QQ_HOTUPDATE_VERSION}"
fi
rm -rf "${QQ_HOTUPDATE_DIR}/"**".zip"

# 处理 config.json
if [ ! -f "${QQ_HOTUPDATE_DIR}/config.json" ]; then
    cp "/opt/QQ/workarounds/config.json" "${QQ_HOTUPDATE_DIR}/config.json"
else
    for VERSION in ${QQ_PREVIOUS_VERSIONS[@]}; do
        if [ -e "${QQ_HOTUPDATE_DIR}/${VERSION}" ]; then
            rm -rf "${QQ_HOTUPDATE_DIR}/${VERSION}"
        fi
        if [ ! -z "$(grep -Rn "${VERSION}" "${QQ_HOTUPDATE_DIR}/config.json")" ]; then
            cp "/opt/QQ/workarounds/config.json" "${QQ_HOTUPDATE_DIR}/config.json"
            break
        fi
    done
fi

bwrap --new-session --cap-drop ALL --unshare-user-try --unshare-pid --unshare-cgroup-try \
    --ro-bind /lib /lib \
    --ro-bind /lib64 /lib64 \
    --ro-bind /bin /bin \
    --ro-bind /usr /usr \
    --ro-bind /opt /opt \
    --ro-bind /opt/QQ/workarounds/xdg-open.sh /usr/bin/xdg-open \
    --ro-bind /usr/lib/snapd-xdg-open/xdg-open /snapd-xdg-open \
    --ro-bind /usr/lib/flatpak-xdg-utils/xdg-open /flatpak-xdg-open \
    --ro-bind /etc/machine-id /etc/machine-id \
    --ro-bind /etc/ld.so.cache /etc/ld.so.cache \
    --dev-bind /dev /dev \
    --ro-bind /sys /sys \
    --ro-bind /etc/passwd /etc/passwd \
    --ro-bind /etc/nsswitch.conf /etc/nsswitch.conf \
    --ro-bind-try /run/systemd/userdb /run/systemd/userdb \
    --ro-bind /etc/resolv.conf /etc/resolv.conf \
    --ro-bind /etc/localtime /etc/localtime \
    --proc /proc \
    --dev-bind /run/dbus /run/dbus \
    --bind "${USER_RUN_DIR}" "${USER_RUN_DIR}" \
    --ro-bind-try /etc/fonts /etc/fonts \
    --dev-bind /tmp /tmp \
    --bind-try "${HOME}/.pki" "${HOME}/.pki" \
    --ro-bind-try "${XAUTHORITY}" "${XAUTHORITY}" \
    --bind-try "${QQ_DOWNLOAD_DIR}" "${QQ_DOWNLOAD_DIR}" \
    --bind "${QQ_APP_DIR}" "${QQ_APP_DIR}" \
    --ro-bind-try "${FONTCONFIG_HOME}" "${FONTCONFIG_HOME}" \
    --ro-bind-try "${HOME}/.icons" "${HOME}/.icons" \
    --ro-bind-try "${HOME}/.local/share/.icons" "${HOME}/.local/share/.icons" \
    --ro-bind-try "${XDG_CONFIG_HOME}/gtk-3.0" "${XDG_CONFIG_HOME}/gtk-3.0" \
    --ro-bind /etc/nsswitch.conf /etc/nsswitch.conf \
    --ro-bind /run/systemd/userdb/ /run/systemd/userdb/ \
    --setenv IBUS_USE_PORTAL 1 \
    --setenv QQNTIM_HOME "${QQ_APP_DIR}/QQNTim" \
    --setenv LITELOADERQQNT_PROFILE "${QQ_APP_DIR}/LiteLoaderQQNT" \
    /opt/QQ/qq "${flags[@]}" "$@"

# 移除无用崩溃报告和日志
# 如果需要向腾讯反馈 bug，请注释掉如下几行
if [ -d "${QQ_APP_DIR}/crash_files" ]; then
    rm -rf "${QQ_APP_DIR}/crash_files"
fi
if [ -d "${QQ_APP_DIR}/log" ]; then
    rm -rf "${QQ_APP_DIR}/log"
fi
for nt_qq_userdata in "${QQ_APP_DIR}/nt_qq_"*; do
    if [ -d "${nt_qq_userdata}/log" ]; then
        rm -rf "${nt_qq_userdata}/log"
    fi
    if [ -d "${nt_qq_userdata}/log-cache" ]; then
        rm -rf "${nt_qq_userdata}/log-cache"
    fi
done
if [ -d "${QQ_APP_DIR}/Crashpad" ]; then
    rm -rf "${QQ_APP_DIR}/Crashpad"
fi
