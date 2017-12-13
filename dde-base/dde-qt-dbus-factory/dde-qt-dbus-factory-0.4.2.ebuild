# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit qmake-utils

DESCRIPTION="A repository stores auto-generated Qt5 D-Bus code used by DDE"
HOMEPAGE="https://github.com/linuxdeepin/dde-qt-dbus-factory"
SRC_URI="https://github.com/linuxdeepin/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-qt/qtdbus:5
		 dev-qt/qtcore:5"

DEPEND="${RDEPEND}
		dev-qt/qtgui:5
		dev-lang/python"

src_prepare() {
	QT_SELECT=qt5 eqmake5	PREFIX=/usr LIB_INSTALL_DIR=/usr/$(get_libdir)
	default_src_prepare
}

src_install() {
		emake INSTALL_ROOT=${D} install
}
