# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit qmake-utils

DESCRIPTION="Deepin desktop environment - Launcher module"
HOMEPAGE="https://github.com/linuxdeepin/dde-launcher"
SRC_URI="https://github.com/linuxdeepin/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="x11-libs/gtk+:2
		 dev-qt/qtsvg:5
		 dev-qt/qtx11extras:5
		 >dde-base/deepin-menu-2.90.1
		 dde-base/dde-daemon
		 x11-libs/gsettings-qt
	     "
DEPEND="${RDEPEND}
		 dde-base/deepin-tool-kit:=
		 dde-base/dde-qt-dbus-factory:=
	     "

src_prepare() {
		eqmake5	PREFIX=/usr WITHOUT_UNINSTALL_APP=YES
}

src_install() {
		emake INSTALL_ROOT=${D} install
}
