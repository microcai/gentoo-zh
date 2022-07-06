# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop unpacker xdg

DESCRIPTION="Wemeet - Tencent Video Conferencing"
HOMEPAGE="https://wemeet.qq.com"
# no arm64 for 3.8.0.2 release yet
SRC_URI="
	amd64? ( mirror+https://updatecdn.meeting.qq.com/MTZlNjg4ZjctOTAwMS00NDg2LWE3ZjMtMjNhZjBmODk3ZTIz/TencentMeeting_0300000000_${PV}_x86_64_default.publish.deb -> ${P}_amd64.deb )
"

LICENSE="wemeet_license"
SLOT="0"
KEYWORDS="-* ~amd64"

RESTRICT="bindist test"

DEPEND="
		dev-libs/nss
		dev-util/desktop-file-utils
		media-sound/pulseaudio
		x11-libs/libX11
"
RDEPEND="${DEPEND}"
BDEPEND="dev-util/patchelf"

S="${WORKDIR}"
QA_PREBUILT="opt/${PN}/*"

src_install() {
	# Fix duplicate files causing failures if FEATURES=splitdebug
	local f
	for f in libFcitxQt5DBusAddons.so libFcitxQt5WidgetsAddons.so; do
		rm "opt/${PN}/lib/${f}" "opt/${PN}/lib/${f}.1" || die
		ln -s "${f}.1.0" "opt/${PN}/lib/${f}.1" || die
		ln -s "${f}.1" "opt/${PN}/lib/${f}" || die
	done

	# Fix RPATHs to ensure the libraries can be found
	for f in $(find "opt/${PN}/bin" "opt/${PN}/plugins") ; do
		[[ -f ${f} && $(od -t x1 -N 4 "${f}") == *"7f 45 4c 46"* ]] || continue
		patchelf --set-rpath "/opt/${PN}/lib" ${f} || die "patchelf failed on ${f}"
	done
	for f in $(find "opt/${PN}/lib") ; do
		[[ -f ${f} && $(od -t x1 -N 4 "${f}") == *"7f 45 4c 46"* ]] || continue
		patchelf --set-rpath '$ORIGIN' ${f} || die "patchelf failed on ${f}"
	done

	# Force X11
	# If wayland is used, wemeet will just die:
	# /opt/wemeet/bin/wemeetapp: symbol lookup error: /usr/lib64/libwayland-cursor.so.0: undefined symbol: wl_proxy_marshal_flags
	# tested with 2.8.0.3 and dev-libs/wayland-1.20.0
	cat > "opt/${PN}/wemeetapp.sh" <<- EOF || die
#!/bin/sh
export XDG_SESSION_TYPE=x11
export QT_QPA_PLATFORM=xcb
export QT_AUTO_SCREEN_SCALE_FACTOR=1
export QT_STYLE_OVERRIDE=fusion # 解决使用自带qt情况下，字体颜色全白看不到的问题
export IBUS_USE_PORTAL=1 # fix ibus
FONTCONFIG_DIR=\$HOME/.config/fontconfig
unset WAYLAND_DISPLAY

# if pipewire-pulse installed
if [ -f /usr/bin/pipewire-pulse ]; then
    export PULSE_LATENCY_MSEC=20 # 解决Pipewire播放声音卡顿的问题
fi;

if [ -f "/usr/bin/bwrap" ];then
    mkdir -p \$FONTCONFIG_DIR
    bwrap --dev-bind / / --tmpfs \$HOME/.config --ro-bind \$FONTCONFIG_DIR \$FONTCONFIG_DIR /opt/wemeet/bin/wemeetapp \$*;
else
    exec /opt/wemeet/bin/wemeetapp \$*;
fi;
	EOF

	insinto "/opt/${PN}"
	exeinto "/opt/${PN}"
	doins -r "opt/${PN}/bin" "opt/${PN}/icons" "opt/${PN}/lib" "opt/${PN}/plugins"
	doexe "opt/${PN}/wemeetapp.sh"
	fperms +x "/opt/${PN}/bin/wemeetapp"
	fperms +x "/opt/${PN}/bin/crashpad_handler"

	# put launcher into PATH
	dosym "../../opt/${PN}/wemeetapp.sh" /usr/bin/wemeetapp

	sed -i "s/^Icon=.*/Icon=wemeetapp/g" "usr/share/applications/wemeetapp.desktop" || die
	sed -i "s/^Exec=.*/Exec=wemeetapp %u/g" "usr/share/applications/wemeetapp.desktop" || die
	domenu "usr/share/applications/wemeetapp.desktop"
	newicon -s scalable "opt/${PN}/wemeet.svg" "wemeetapp.svg"
	for i in 16 32 64 128 256; do
		png_file="opt/${PN}/icons/hicolor/${i}x${i}/mimetypes/wemeetapp.png"
		if [ -e "${png_file}" ]; then
			newicon -s "${i}" "${png_file}" wemeetapp
		fi
	done
}
