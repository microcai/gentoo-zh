# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit qmake-utils

DESCRIPTION="Deepin graphical user interface library"
HOMEPAGE="https://github.com/linuxdeepin/dtkwm"

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
		 dev-qt/qtx11extras:5
		 >=dev-qt/qtcore-5.5:5
		 x11-libs/libXrender
		 x11-libs/libxcb
		 x11-libs/libXext
		 x11-libs/xcb-util
		 x11-proto/xextproto
		 media-libs/fontconfig
		 media-libs/freetype
		 sys-libs/mtdev
		 media-libs/mesa
		 virtual/libudev
		 dev-libs/glib
		"
DEPEND="${RDEPEND}
		dde-base/dtkcore
		"

src_prepare() {
	QT_SELECT=qt5 eqmake5 PREFIX=/usr LIB_INSTALL_DIR=/usr/$(get_libdir)
	default_src_prepare
}

src_install() {
	emake INSTALL_ROOT=${D} install
}

