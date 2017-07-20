# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="4"

inherit fdo-mime eutils gnome2-utils
SRC_URI="https://github.com/linuxdeepin/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
DESCRIPTION="Deepin Music Player."
HOMEPAGE="https://github.com/linuxdeepin/deepin-music-player"

LICENSE="GPL-3"
SLOT="2"
KEYWORDS="~amd64 ~x86"
IUSE="+hotkey"

RDEPEND=">=x11-libs/deepin-ui-1.0.201209101328
	dev-python/gst-python:0.10
	media-plugins/gst-plugins-meta:0.10[mp3,flac]
	>=media-libs/mutagen-1.8
	dev-python/chardet
	dev-python/cddb-py
	dev-python/dbus-python
	dev-python/pycurl
	dev-python/pyquery
	dev-libs/keybinder:0[python]
	hotkey? ( || ( media-plugins/python-mmkeys media-sound/sonata ) )"
DEPEND="${RDEPEND}
	    dde-extra/deepin-gettext-tools"

src_prepare() {

	# fix python version
	find -iname "*.py" | xargs sed -i 's=\(^#! */usr/bin.*\)python *$=\1python2='

	# remove sudo in generate_mo.py
	sed -e 's/sudo cp/cp/'  -i tools/generate_mo.py || die "sed failed"
	
}

src_compile(){
	deepin-generate-mo tools/locale_config.ini
}

src_install() {
	emake DESTDIR=${D} PREFIX=/usr install
}
