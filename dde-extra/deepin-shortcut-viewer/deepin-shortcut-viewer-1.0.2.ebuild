# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit qmake-utils

DESCRIPTION="Deepin shortcut Viewer"
HOMEPAGE="https://github.com/linuxdeepin/deepin-shortcut-viewer"
SRC_URI="https://github.com/linuxdeepin/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-qt/qtcore:5
		dev-qt/qtgui:5
		"

DEPEND="${RDEPEND}
	    "

src_prepare() {
	eqmake5
}

src_install() {
	emake INSTALL_ROOT=${D} install
}
