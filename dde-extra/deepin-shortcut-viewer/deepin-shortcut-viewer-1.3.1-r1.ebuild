# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit qmake-utils

DESCRIPTION="Deepin shortcut Viewer"
HOMEPAGE="https://github.com/linuxdeepin/deepin-shortcut-viewer"
SRC_URI="https://github.com/linuxdeepin/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+dtk1"

RDEPEND="dev-qt/qtcore:5
		dev-qt/qtgui:5
		dev-qt/qtwidgets:5
		dev-qt/qtnetwork:5
		media-libs/mesa
		x11-libs/libxcb
		"

DEPEND="${RDEPEND}
        dtk1? ( >=dde-base/deepin-tool-kit-0.3.4:= )
		!dtk1? ( >=dde-base/dtkwidget-0.3.3:= )
	    "

src_prepare() {
    if use dtk1; then
        sed -i "s|dtkwidget|dtkwidget1|g" ${PN}.pro 
    fi   

	eqmake5
}

src_install() {
	emake INSTALL_ROOT=${D} install
}
