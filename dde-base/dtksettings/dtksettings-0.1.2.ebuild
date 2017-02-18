# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit qmake-utils

DESCRIPTION="DtkSettings is a powerfull tool to generation config form json."
HOMEPAGE="https://github.com/linuxdeepin/dtksettings"
SRC_URI="https://github.com/linuxdeepin/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-qt/qtmultimedia:5[widgets]
		 dev-qt/qtgui:5
		 dev-qt/qtwidgets:5
		 dev-qt/qttest:5
		 >=dev-qt/qtcore-5.5:5
	     "
DEPEND="${RDEPEND}
	     "

src_prepare() {
		eqmake5	
}

src_install() {
		emake INSTALL_ROOT=${D} install
}

