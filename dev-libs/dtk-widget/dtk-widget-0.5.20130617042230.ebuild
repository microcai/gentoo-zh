# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v3
# $Header: $

EAPI="4"

inherit fdo-mime versionator eutils python

PYTHON_DEPEND=2:2.7
MY_VER="$(get_version_component_range 1-2)+git$(get_version_component_range 3)~2491552186"
SRC_URI="http://packages.linuxdeepin.com/deepin/pool/main/d/${PN}/${PN}_${MY_VER}.tar.gz"

DESCRIPTION="Deepin widget of Chinese Lunar library"
HOMEPAGE="http://www.linuxdeepin.com"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-libs/gobject-introspection
		dev-libs/glib:2
		x11-libs/gdk-pixbuf:2
		x11-libs/gtk+:2
		dev-lang/python:2.7
		dev-python/pygobject:2
		dev-python/pygtk:2"
DEPEND="${RDEPEND}
		dev-util/gtk-doc"
S="${WORKDIR}/${PN}-${MY_VER}"

pkg_setup() {
	python_set_active_version 2.7
}

src_prepare() {
	./autogen.sh --prefix=/usr
}
