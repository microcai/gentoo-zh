# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v3
# $Header: $

EAPI="4"

inherit fdo-mime versionator eutils gnome2-utils
MY_VER="$(get_version_component_range 1-2)+$(get_version_component_range 3)~fa225d345b"
SRC_URI="http://packages.linuxdeepin.com/deepin/pool/main/d/${PN}/${PN}_${MY_VER}.tar.gz"

DESCRIPTION="Deepin Music Player."
HOMEPAGE="https://github.com/linuxdeepin/deepin-music-player"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+hotkey"

RDEPEND=">=x11-libs/deepin-ui-1.0.201209101328
	dev-python/gst-python:0.10
	media-plugins/gst-plugins-meta:0.10[mp3,flac,ffmpeg]
	>=media-libs/mutagen-1.8
	dev-python/chardet
	dev-python/cddb-py
	dev-python/dbus-python
	dev-python/pycurl
	dev-python/pyquery
	dev-libs/keybinder:0[python]
	hotkey? ( || ( media-plugins/python-mmkeys media-sound/sonata ) )"
DEPEND="${RDEPEND}
	      dev-python/deepin-gettext-tools"

S=${WORKDIR}/${PN}-$MY_VER
src_prepare() {

	# fix python version
	find -iname "*.py" | xargs sed -i 's=\(^#! */usr/bin.*\)python *$=\1python2='

	# remove sudo in generate_mo.py
	sed -e 's/sudo cp/cp/'  -i tools/generate_mo.py || die "sed failed"
	
	langs=`echo $LINGUAS  | sed s/\ /\"\,\"/ | sed 's/.*/\[\"&/' | sed 's/$/\"\]&/'`
	sed -i /^langs=/clangs=${langs}  tools/locale_config.ini

}

src_compile(){
	deepin-generate-mo tools/locale_config.ini
}

src_install() {
	
	echo $LINGUAS > ${S}/langs.tmp
	for lang in `cat ${S}/langs.tmp`
	do
	  insinto "/usr/share/locale"
	  doins -r ${S}/locale/mo/${lang}
	done

	insinto "/usr/share/${PN}"
	doins -r  ${S}/src ${S}/app_theme ${S}/skin ${S}/wizard ${S}/image ${S}/plugins
	fperms 0755 -R /usr/share/${PN}/src/

	#dosym /usr/share/${PN}/src/main.py /usr/bin/${PN}
	echo "#!/bin/sh" > ${PN}
	echo "python2 /usr/share/${PN}/src/main.py" >> ${PN}
	dobin ${PN}

	insinto "/usr/share/icons/"
	doins -r ${S}/image/hicolor
	
	insinto "/usr/share/applications/"
	doins ${S}/${PN}.desktop

}
pkg_postinst() {
	fdo-mime_desktop_database_update
	gnome2_icon_cache_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	gnome2_icon_cache_update
}
