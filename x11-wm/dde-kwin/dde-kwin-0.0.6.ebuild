# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit qmake-utils

DESCRIPTION="KWin configures on DDE"
HOMEPAGE="https://github.com/linuxdeepin/dde-kwin"

SRC_URI="https://github.com/linuxdeepin/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64 ~x86"

LICENSE="GPL-3"
SLOT="0"
IUSE=""

RDEPEND="
		 x11-libs/gsettings-qt
		 dev-qt/qtcore:5
		 dev-qt/qtgui:5
		 dev-qt/qtwidgets:5
		 dev-qt/qtdbus:5
		 dev-qt/qtx11extras:5
		 kde-frameworks/kconfig:5
		 kde-frameworks/kcoreaddons:5
		 kde-frameworks/kwindowsystem:5
		 kde-frameworks/kglobalaccel:5
		 x11-libs/libxcb
		 media-libs/fontconfig
		 media-libs/freetype
		 dev-libs/glib
		 x11-libs/libXrender
		 sys-libs/mtdev
		 kde-plasma/kwin:5
		 dde-base/dde-qt5integration
		 >=dde-base/dtkcore-2.0.9
	     "
DEPEND="${RDEPEND}
		"

src_prepare() {

	export QT_SELECT=qt5
	eqmake5 PREFIX=/usr VERSION=${PV}
	default_src_prepare
}

src_install() {
	emake INSTALL_ROOT=${D} install
}

