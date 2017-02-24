# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

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
		>=dde-base/deepin-tool-kit-0.2.2:=
		dde-base/dde-qt-dbus-factory
		dev-qt/qtx11extras:5
		dev-qt/qtdeclarative:5
	    "
src_prepare() {
		distutils-r1_python_prepare_all
		eqmake5
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
