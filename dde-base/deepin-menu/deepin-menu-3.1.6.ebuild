# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

PYTHON_COMPAT=( python2_7 )

inherit qmake-utils distutils-r1

DESCRIPTION="Deepin menu service for building beautiful menus"
HOMEPAGE="https://github.com/linuxdeepin/deepin-menu"
SRC_URI="https://github.com/linuxdeepin/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-lang/python:2.7
	      "
DEPEND="${RDEPEND}
		x11-libs/libX11
		x11-libs/libxcb
		>=dde-base/dtkwidget-2.0.0:=
		dde-base/dde-qt-dbus-factory
		dev-qt/qtx11extras:5
		dev-qt/qtdeclarative:5
	    "
src_prepare() {
	distutils-r1_python_prepare_all
	QT_SELECT=qt5 eqmake5
	default_src_prepare
}
src_compile() {
	emake
}

src_install() {
	distutils-r1_src_install
	emake INSTALL_ROOT=${D} install

	insinto /etc/xdg/autostart
	doins ${PN}.desktop

	insinto /usr/share/dbus-1/services
	doins data/com.deepin.menu.service

	rm -r ${D}/usr/deepin_menu
}
