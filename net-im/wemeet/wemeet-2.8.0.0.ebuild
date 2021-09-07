# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop xdg-utils unpacker

DESCRIPTION="Wemeet - Tencent Video Conferencing"
HOMEPAGE="https://wemeet.qq.com"
SRC_URI="https://updatecdn.meeting.qq.com/ad878a99-76c4-4058-ae83-22ee948cce98/TencentMeeting_0300000000_${PV}_x86_64.publish.deb -> ${P}_x86_64.deb"

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
BDEPEND=""

S="${WORKDIR}"
QA_PREBUILT="opt/${PN}/*"

src_install() {
	insinto "/opt/${PN}"
	exeinto "/opt/${PN}"
	doins -r "opt/${PN}/bin" "opt/${PN}/icons" "opt/${PN}/lib" "opt/${PN}/plugins"
	doexe "opt/${PN}/wemeetapp.sh"
	fperms +x "/opt/wemeet/bin/wemeetapp"
	fperms +x "/opt/wemeet/bin/crashpad_handler"

	domenu "usr/share/applications/wemeetapp.desktop"
	newicon "opt/${PN}/splash_logo3x.png" "${PN}app.png"
	for i in 16 32 64 128 256; do
		png_file="opt/wemeet/icons/hicolor/${i}x${i}/mimetypes/wemeetapp.png"
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
