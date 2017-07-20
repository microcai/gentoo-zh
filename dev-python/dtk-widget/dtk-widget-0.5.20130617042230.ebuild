# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v3
# $Header: $

EAPI=5
PYTHON_COMPAT=( python2_7 )
inherit fdo-mime versionator eutils python-single-r1

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
		dev-libs/dtk-widget
		dev-python/pygobject:2[${PYTHON_USEDEP}]
		dev-python/pygtk:2[${PYTHON_USEDEP}]
		${PYTHON_DEPS}"
DEPEND="${RDEPEND}
		dev-python/setuptools"
S="${WORKDIR}/${PN}-${MY_VER}"

src_install() {
	"${PYTHON}" setup.py install --root=${D}
}
