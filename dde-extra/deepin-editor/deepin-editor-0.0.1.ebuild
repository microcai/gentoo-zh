# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit qmake-utils

DESCRIPTION="Simple editor for Deepin"
HOMEPAGE="https://github.com/linuxdeepin/deepin-editor"
SRC_URI="https://github.com/linuxdeepin/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-qt/qtcore:5
		 dev-qt/qtwidgets:5
		 dev-qt/qtgui:5
		 dev-qt/qtnetwork:5
		 dev-qt/qtx11extras:5
		 dev-qt/qtdbus:5
		 dev-qt/qtsvg:5
		 x11-libs/libX11
		 x11-libs/libXext 
		 x11-libs/libXtst
		 x11-libs/xcb-util
		 x11-libs/libxcb
		 "

DEPEND="${RDEPEND}
		>=dde-base/dtkwidget-2.0.6:=
		dev-qt/linguist-tools
		dev-qt/qtchooser
		virtual/pkgconfig
		"

src_prepare() {
	QT_SELECT=qt5 eqmake5 PREFIX=/usr
}

src_install() {
	emake INSTALL_ROOT=${D} install
}
