# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit qmake-utils

DESCRIPTION="Base development tool of all C++/Qt Developer work on Deepin - Widget modules"
HOMEPAGE="https://github.com/linuxdeepin/dtkwidget"

if [[ "${PV}" == *9999* ]] ; then
     inherit git-r3
     EGIT_REPO_URI="https://github.com/linuxdeepin/${PN}.git"
else
     SRC_URI="https://github.com/linuxdeepin/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	 KEYWORDS="~amd64 ~x86"
fi
LICENSE="GPL-3"
SLOT="0/${PV}"
IUSE=""

RDEPEND="dev-qt/qtmultimedia:5[widgets]
		 dev-qt/qtdbus:5
		 dev-qt/qtgui:5
		 dev-qt/qtnetwork:5
		 dev-qt/qtwidgets:5
		 dev-qt/qtconcurrent:5
		 dev-qt/qtx11extras:5
		 dev-qt/qtsvg:5
		 >=dev-qt/qtcore-5.5:5
		 x11-libs/libXrender
		 x11-libs/libxcb
		 x11-libs/libXext
		 x11-libs/xcb-util
		 x11-libs/startup-notification
		 x11-libs/gsettings-qt
		 x11-proto/xextproto
		 sys-libs/mtdev
		 gnome-base/librsvg:2
		 media-libs/freetype
		 media-libs/fontconfig
		 media-libs/mesa
		 virtual/libudev
		 !<=dde-base/deepin-tool-kit-0.3.3
		"
DEPEND="${RDEPEND}
		dev-libs/glib:2
		dde-base/dtkcore
		dde-base/dde-qt-dbus-factory
		dev-qt/linguist-tools:5
		"

src_prepare() {
	LIBDIR=$(get_libdir)
	sed -i "s|{PREFIX}/lib/|{PREFIX}/${LIBDIR}/|g" tools/svgc/svgc.pro
	QT_SELECT=qt5 eqmake5 PREFIX=/usr LIB_INSTALL_DIR=/usr/$(get_libdir)
	default_src_prepare
}

src_install() {
	emake INSTALL_ROOT=${D} install
}

