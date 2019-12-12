# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit cmake-utils

DESCRIPTION="Deepin desktop environment - Dock module"
HOMEPAGE="https://github.com/linuxdeepin/dde-dock"
SRC_URI="https://github.com/linuxdeepin/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-qt/qtsvg:5
		 dev-qt/qtx11extras:5
		 >=dde-base/deepin-menu-3.2.0
		 dde-base/dde-daemon
		 dde-base/dde-network-utils
		 dde-base/dde-qt5integration
		 app-accessibility/onboard
       	 >=dde-base/dtkwidget-2.0.9.5:=
	     "
DEPEND="${RDEPEND}
		virtual/pkgconfig
		x11-libs/xcb-util-image
		x11-libs/libxcb
		x11-libs/xcb-util-wm
		x11-libs/libXtst
		dde-base/dde-qt-dbus-factory
		x11-libs/gsettings-qt
		dev-libs/libdbusmenu-qt
	    "

src_prepare() {
	LIBDIR=$(get_libdir)
	sed -i "s|lib/|${LIBDIR}/|g" plugins/*/CMakeLists.txt
	sed -i "s|/usr/lib/|/usr/${LIBDIR}/|g" \
		frame/item/showdesktopitem.cpp \
		frame/controller/dockpluginscontroller.cpp \
		plugins/tray/system-trays/systemtrayscontroller.cpp || die

	cmake-utils_src_prepare
}

