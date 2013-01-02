# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v3
# $Header: $

EAPI="4"

inherit fdo-mime versionator eutils
MY_VER=$(get_version_component_range 1)+git$(get_version_component_range 2)
SRC_URI="http://packages.linuxdeepin.com/deepin/pool/main/d/${PN}/${PN}_${MY_VER}.tar.gz"

DESCRIPTION="Deepin Music Player."
HOMEPAGE="https://github.com/linuxdeepin/deepin-music-player"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=x11-libs/deepin-ui-1.201209101028
	dev-python/gst-python
	media-libs/gst-plugins-bad
	media-libs/gst-plugins-ugly
	sci-libs/scipy
	media-plugins/gst-plugins-ffmpeg
	dev-python/python-xlib
	media-libs/mutagen
	dev-python/chardet
	dev-python/dbus-python
	dev-python/pyquery"
DEPEND="${RDEPEND}"
#S=${WORKDIR}/${PN}-$(get_version_component_range \
#	1)+git$(get_version_component_range 2)
S=${WORKDIR}/${PN}-$MY_VER
src_prepare() {
	rm -rf debian || die
	rm locale/*.po* 
}

src_install() {
	dodoc AUTHORS ChangeLog 

	insinto "/usr/share/"
	doins -r ${S}/locale

	insinto "/usr/share/${PN}"
	doins -r  ${S}/src ${S}/app_theme ${S}/skin ${S}/wizard
	fperms 0755 -R /usr/share/${PN}/src/

	dosym /usr/share/${PN}/src/main.py /usr/bin/${PN}

#	mkdir -p /usr/share/icons/hicolor/128x128/apps
	doicon -s 128 ${FILESDIR}/${PN}.png
	
	insinto "/usr/share/applications/"
	doins ${FILESDIR}/${PN}.desktop

}
pkg_postinst() {
	fdo-mime_desktop_database_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
}
