# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit xdg qmake-utils
MY_PV=v${PV}
DESCRIPTION="A lightweight yet powerful C/C++/GNU Assembly IDE."
HOMEPAGE="https://royqh.net/redpandacpp"
SRC_URI="https://github.com/royqh1979/RedPanda-CPP/archive/refs/tags/${MY_PV}.tar.gz -> redpanda-cpp-${PV}.tar.gz"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	dev-qt/qtsvg:5
	dev-qt/qtnetwork:5
	dev-qt/qtxml:5
	dev-qt/qtprintsupport:5
"
RDEPEND="${DEPEND}"
S="${WORKDIR}/RedPanda-CPP-${PV}"
src_configure(){
	OPTIONS="PREFIX=/usr LIBEXECDIR=/usr/libexec XDG_ADAPTIVE_ICON=ON"
	eqmake5 ${OPTIONS} Red_Panda_CPP.pro
}

src_install(){
	emake INSTALL_ROOT="${ED}" install
}
