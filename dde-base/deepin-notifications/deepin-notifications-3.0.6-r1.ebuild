# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit qmake-utils

DESCRIPTION="System notifications for Deepin Desktop Environment"
HOMEPAGE="https://github.com/linuxdeepin/deepin-notifications"
SRC_URI="https://github.com/linuxdeepin/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+dtk1"

RDEPEND="x11-libs/gtk+:2
		 dev-qt/qtsvg:5
		 dev-qt/qtdeclarative:5
		 dev-qt/qtsql:5[sqlite]
	     "
DEPEND="${RDEPEND}
        dtk1? ( >=dde-base/deepin-tool-kit-0.3.4:= )
        !dtk1? ( >=dde-base/dtkwidget-0.3.3:= )
	     "

src_prepare() {
    if use dtk1; then
        sed -i "s|dtkwidget|dtkwidget1|g" ${PN}.pro 
    fi   
	LIBDIR=$(get_libdir)
	sed -i "s|{PREFIX}/lib/|{PREFIX}/${LIBDIR}/|g" ${PN}.pro
	eqmake5	PREFIX=/usr
	default_src_prepare
}

src_install() {
	emake INSTALL_ROOT=${D} install
}
