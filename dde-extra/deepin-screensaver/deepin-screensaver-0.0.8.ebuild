# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=7

inherit qmake-utils

DESCRIPTION="Deepin ScreenSaver"
HOMEPAGE="https://github.com/linuxdeepin/deepin-screensaver"
SRC_URI="https://github.com/linuxdeepin/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+bubbles"

DEPEND="dev-qt/qtgui:5
		dev-qt/qtx11extras:5
		dev-qt/qtcore:5
		dev-qt/qtdbus:5
		dev-qt/qtdeclarative:5
		dev-qt/qtwidgets:5
		x11-libs/libX11
		x11-libs/libXScrnSaver
		x11-libs/libXext
		"
RDEPEND="${DEPEND}
		x11-misc/xscreensaver
		bubbles? ( dde-extra/screensaver-pp )
		"

src_prepare() {
	eapply_user
	LIBDIR=$(get_libdir)
	sed -i "s|lib/|${LIBDIR}/|g" common.pri
	sed -i "s|lib/|${LIBDIR}/misc/|g" xscreensaver/xscreensaver.pro
	QT_SELECT=qt5 eqmake5
}

src_install() {
	emake INSTALL_ROOT=${D} install
}
