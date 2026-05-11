# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit xdg qmake-utils
DESCRIPTION="A lightweight yet powerful C/C++/GNU Assembly IDE."
HOMEPAGE="http://royqh.net/redpandacpp"
SRC_URI="https://github.com/royqh1979/RedPanda-CPP/archive/refs/tags/v${PV}.tar.gz -> redpanda-cpp-${PV}.tar.gz"
S="${WORKDIR}/RedPanda-CPP-${PV}"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-qt/qtbase:6=[gui,network,widgets,xml]
	dev-qt/qtsvg:6
"
RDEPEND="${DEPEND}"
src_configure(){
	OPTIONS="PREFIX=/usr LIBEXECDIR=/usr/libexec XDG_ADAPTIVE_ICON=ON"
	eqmake6 ${OPTIONS} Red_Panda_CPP.pro
}

src_install(){
	emake INSTALL_ROOT="${ED}" install
}
