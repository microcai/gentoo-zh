# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop xdg-utils unpacker

DESCRIPTION="Wemeet - Tencent Video Conferencing"
HOMEPAGE="https://wemeet.qq.com"
SRC_URI="https://updatecdn.meeting.qq.com/cos/196cdf1a3336d5dca56142398818545f/TencentMeeting_0300000000_${PV}_x86_64.publish.deb -> ${P}_x86_64.deb"

LICENSE="wemeet_license"
SLOT="0"
KEYWORDS="~amd64"

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
	# Fix RPATHs to ensure the libraries can be found
	local f
	for f in $(find opt/${PN}/bin opt/${PN}/plugins) ; do
		[[ -f ${f} && $(od -t x1 -N 4 "${f}") == *"7f 45 4c 46"* ]] || continue
		patchelf --set-rpath "/opt/${PN}/lib" ${f} || die "patchelf failed on ${f}"
	done
	for f in $(find opt/${PN}/lib) ; do
		[[ -f ${f} && $(od -t x1 -N 4 "${f}") == *"7f 45 4c 46"* ]] || continue
		patchelf --set-rpath '$ORIGIN' ${f} || die "patchelf failed on ${f}"
	done

	# Force to use xcb
	# If wayland is used, wemeet will do nothing and exit (checked in v2.8.0.1)
	cat > opt/${PN}/wemeetapp.sh <<- EOF || die
#! /bin/bash
export XDG_SESSION_TYPE=x11
export QT_QPA_PLATFORM=xcb
unset WAYLAND_DISPLAY
exec /opt/wemeet/bin/wemeetapp $*
	EOF

	insinto "/opt/${PN}"
	exeinto "/opt/${PN}"
	doins -r "opt/${PN}/bin" "opt/${PN}/icons" "opt/${PN}/lib" "opt/${PN}/plugins"
	doexe "opt/${PN}/wemeetapp.sh"
	fperms +x "/opt/${PN}/bin/wemeetapp"
	fperms +x "/opt/${PN}/bin/crashpad_handler"

	domenu "usr/share/applications/wemeetapp.desktop"
	newicon "opt/${PN}/splash_logo3x.png" "${PN}app.png"
	for i in 16 32 64 128 256; do
		png_file="opt/${PN}/icons/hicolor/${i}x${i}/mimetypes/wemeetapp.png"
		if [ -e "${png_file}" ]; then
			newicon -s "${i}" "${png_file}" wemeetapp
		fi
	done
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}
