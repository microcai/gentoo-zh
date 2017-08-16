# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
inherit qmake-utils

DESCRIPTION="DDE system integration plugin for Qt5"
HOMEPAGE="https://github.com/linuxdeepin/qt5integration"
MY_PN=${PN#*-}
MY_P=${MY_PN}-${PV}

if [[ ${PV} = *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/linuxdeepin/${MY_PN}.git"
else
	SRC_URI="https://github.com/linuxdeepin/${MY_PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-2+"
SLOT="0"
IUSE="+dtk1"

RDEPEND="
	>=dev-libs/libqtxdg-2.0.0
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	x11-libs/libxcb
	x11-libs/xcb-util-renderutil
	x11-libs/xcb-util-image
	x11-libs/xcb-util-wm
	x11-libs/xcb-util-keysyms
	x11-libs/gtk+:2
	"
DEPEND="${RDEPEND}
        dtk1? ( >=dde-base/deepin-tool-kit-0.3.4:= )
        !dtk1? ( >=dde-base/dtkwidget-0.3.3:= )
	"

S=${WORKDIR}/${MY_P}

src_prepare() {
    if use dtk1; then
        sed -i "s|dtkwidget|dtkwidget1|g" dstyleplugin/dstyleplugin.pro
    fi   
	eqmake5 ${MY_PN}.pro
	sed -i "s|cr\.deepin\.io|github\.com\/linuxdeepin|g" platformplugin/linux.pri
}

src_install() {
	emake INSTALL_ROOT=${D} install
}
