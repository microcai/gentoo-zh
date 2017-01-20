# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit qmake-utils

DESCRIPTION="Base development tool of all C++/Qt Developer work on Deepin"
HOMEPAGE="https://github.com/linuxdeepin/deepin-tool-kit"
SRC_URI="https://github.com/linuxdeepin/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-qt/qtmultimedia:5[widgets]
		 dev-qt/qtdbus:5
		 dev-qt/qtgui:5
		 dev-qt/qtnetwork:5
		 dev-qt/qtwidgets:5
		 dev-qt/qtx11extras:5
		 >=dev-qt/qtcore-5.5:5
		 x11-libs/libxcb
		 x11-libs/xcb-util
		 x11-libs/startup-notification
	     "
DEPEND="${RDEPEND}
	     "

src_prepare() {
		eqmake5	
}

src_install() {
		emake INSTALL_ROOT=${D} install
		rm -r ${D}/usr/share
}

