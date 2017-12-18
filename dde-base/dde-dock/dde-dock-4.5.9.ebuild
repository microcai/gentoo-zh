# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit qmake-utils

DESCRIPTION="Deepin desktop environment - Dock module"
HOMEPAGE="https://github.com/linuxdeepin/dde-dock"
SRC_URI="https://github.com/linuxdeepin/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0/4.4.0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-qt/qtsvg:5
		 dev-qt/qtx11extras:5
		 >dde-base/deepin-menu-2.90.1
		 dde-base/dde-daemon
		 dde-base/dde-qt5integration
	     "
DEPEND="${RDEPEND}
		virtual/pkgconfig
		x11-libs/xcb-util-image
		x11-libs/libxcb
		x11-libs/xcb-util-wm
		x11-libs/libXtst
		dde-base/dde-qt-dbus-factory
		x11-libs/gsettings-qt
        >=dde-base/dtkwidget-2.0.1:=
	    "

src_prepare() {
	LIBDIR=$(get_libdir)
	sed -i "s|{PREFIX}/lib/|{PREFIX}/${LIBDIR}/|g" plugins/*/*.pro
	export QT_SELECT=qt5
	eqmake5	PREFIX=/usr
	default_src_prepare
}

src_install() {
		emake INSTALL_ROOT=${D} install
}
