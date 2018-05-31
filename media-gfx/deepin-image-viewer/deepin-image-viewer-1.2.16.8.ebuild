# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit qmake-utils

DESCRIPTION="Deepin Image Viewer"
HOMEPAGE="https://github.com/linuxdeepin/deepin-image-viewer"
SRC_URI="https://github.com/linuxdeepin/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+jpeg +png +tiff raw mng jpeg2k"

RDEPEND="dev-qt/qtsvg:5
		dev-qt/qtconcurrent:5
		dev-qt/qtgui:5
		dev-qt/qtdbus:5
		dev-qt/qtprintsupport:5
		dev-qt/qtx11extras:5
		media-libs/libraw
		media-libs/libexif
		media-libs/freeimage[jpeg?,png?,tiff?,raw?,mng?,jpeg2k?]
		"

DEPEND="${RDEPEND}
		>=dde-base/dtkwidget-2.0.0:=
	    "

src_prepare() {
	export QT_SELECT=qt5
	eqmake5
}

src_install() {
	emake INSTALL_ROOT=${D} install
}
