# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v3
# $Header: $

EAPI="4"

inherit fdo-mime versionator eutils gnome2-utils
MY_VER="$(get_version_component_range 1)+git$(get_version_component_range 2)~7efe2488a6"
SRC_URI="http://packages.linuxdeepin.com/deepin/pool/main/d/${PN}/${PN}_${MY_VER}.tar.gz"

DESCRIPTION="Deepin Music Player."
HOMEPAGE="https://github.com/linuxdeepin/deepin-music-player"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+hotkey"

RDEPEND=">=x11-libs/deepin-ui-1.201209101328
	dev-python/gst-python
	media-libs/gst-plugins-bad
	media-libs/gst-plugins-ugly
	sci-libs/scipy
	media-plugins/gst-plugins-ffmpeg
	dev-python/python-xlib
	media-libs/mutagen
	dev-python/chardet
	dev-python/cddb-py
	dev-python/dbus-python
	dev-python/pycurl
	dev-python/pyquery
	dev-libs/keybinder:0[python]
	hotkey? ( media-plugins/python-mmkeys )"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${PN}-$MY_VER
src_prepare() {
	cd tools
	python2 generate_mo.py
	cd ..
	rm locale/*.po* 
}

src_install() {
	insinto "/usr/share/"
	doins -r ${S}/locale

	insinto "/usr/share/${PN}"
	doins -r  ${S}/src ${S}/app_theme ${S}/skin ${S}/wizard ${S}/image ${S}/plugins
	fperms 0755 -R /usr/share/${PN}/src/

	#dosym /usr/share/${PN}/src/main.py /usr/bin/${PN}
	echo "#!/bin/sh" > ${PN}
	echo "python2 /usr/share/${PN}/src/main.py" >> ${PN}
	dobin ${PN}

#	mkdir -p /usr/share/icons/hicolor/128x128/apps
	doicon -s 128 ${S}/debian/${PN}.png
	
	insinto "/usr/share/applications/"
	doins ${S}/debian/${PN}.desktop

}
pkg_postinst() {
	fdo-mime_desktop_database_update
	gnome2_icon_cache_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	gnome2_icon_cache_update
}
