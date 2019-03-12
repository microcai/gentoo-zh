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

RDEPEND="dev-qt/qtsvg:5
		 dev-qt/qtx11extras:5
		 >=dde-base/deepin-menu-3.0.0
		 dde-base/dde-daemon
		 >=dde-base/deepin-desktop-schemas-3.1.11
		 x11-libs/gsettings-qt
	     "
DEPEND="${RDEPEND}
		x11-libs/xcb-util-wm
		x11-libs/libxcb
        >=dde-base/dtkwidget-2.0.0:=
		dde-base/dde-qt-dbus-factory:=
	    "

src_prepare() {
	QT_SELECT=qt5 eqmake5	PREFIX=/usr WITHOUT_UNINSTALL_APP=YES
}

src_install() {
		emake INSTALL_ROOT=${D} install
}
