# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CMAKE_MAKEFILE_GENERATOR="emake"
inherit cmake

if [[ ${PV} = 9999* ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/cutefishos/screenshot.git"
	EGIT_CHECKOUT_DIR=cutefish-screenshot-${PV}
	KEYWORDS=""
else
	SRC_URI="https://github.com/cutefishos/screenshot/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm64 ~riscv"
	S="${WORKDIR}/screenshot-${PV}"
fi

DESCRIPTION="Screenshot tool for CutefishOS"
HOMEPAGE="https://github.com/cutefishos/screenshot"
LICENSE="GPL-3"
SLOT="0"
IUSE=""
RDEPEND=""
DEPEND="
	dev-qt/qtcore
	dev-qt/qtdbus
	dev-qt/qtgui
	dev-qt/qtwidgets
	dev-qt/qtdeclarative
	dev-qt/linguist-tools
"
BDEPEND="${DEPEND}"

src_configure(){
	mycmakeargs=(
		-DCMAKE_INSTALL_PREFIX="/usr"
	)
	cmake_src_configure
}
