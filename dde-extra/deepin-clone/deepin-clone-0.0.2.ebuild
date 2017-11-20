# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit qmake-utils

DESCRIPTION="Deepin Disk and Partition Backup/Restore Tool"
HOMEPAGE="https://github.com/linuxdeepin/deepin-clone"
SRC_URI="https://github.com/linuxdeepin/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+gui"

RDEPEND="dev-qt/qtcore:5
		dev-qt/qtconcurrent:5
		gui? ( dev-qt/qtgui:5 
			   dev-qt/qtwidgets:5
			   dev-qt/qtnetwork:5
			   dev-qt/qtmultimedia:5[widgets] )
		"

DEPEND="${RDEPEND}
		>=dde-base/dtkwidget-2.0.1:=
		virtual/pkgconfig
	    "

src_prepare() {
	sed -i "s|QT\ +=|QT\ +=\ multimediawidgets|g" src/widgets/widgets.pri
	export QT_SELECT=qt5
	eqmake5 $(use gui || echo DISABLE_GUI=1)
}

src_install() {
	emake INSTALL_ROOT=${D} install
}
