# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit qmake-utils

DESCRIPTION="PolicyKit agent for DDE"
HOMEPAGE="https://github.com/linuxdeepin/dde-polkit-agent"
SRC_URI="https://github.com/linuxdeepin/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-qt/qtcore:5
		 dev-qt/qtgui:5
	   	 dev-qt/qtdbus:5
		 dev-qt/qtwidgets:5
		 sys-auth/polkit-qt[qt5(-)]
	     "
DEPEND="${RDEPEND}
		 dde-base/deepin-tool-kit:=
	     "

src_prepare() {
	LIBDIR=$(get_libdir)
	sed -i "s|/usr/lib/|/usr/${LIBDIR}/|g" ${PN}.pro
	eqmake5	PREFIX=/usr
	default_src_prepare
}

src_install() {
		emake INSTALL_ROOT=${D} install
}
