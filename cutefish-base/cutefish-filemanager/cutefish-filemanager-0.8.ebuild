# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CMAKE_MAKEFILE_GENERATOR="emake"
inherit cmake

if [[ ${PV} == 9999* ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/cutefishos/filemanager.git"
	EGIT_CHECKOUT_DIR=cutefish-filemanager-${PV}
	KEYWORDS=""
else
	SRC_URI="https://github.com/cutefishos/filemanager/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm64 ~riscv"
	S="${WORKDIR}/filemanager-${PV}"
fi

DESCRIPTION="Cutefish File Manager"
HOMEPAGE="https://github.com/cutefishos/filemanager"
LICENSE="GPL-3"
SLOT="0"
IUSE=""
RDEPEND="
	sys-libs/fishui
	sys-libs/libcutefish
"
DEPEND="
	dev-qt/qtcore[icu]
	dev-qt/qtdbus
	dev-qt/qtdeclarative
	dev-qt/linguist-tools
	kde-frameworks/kio
	kde-frameworks/solid
"
BDEPEND="${DEPEND}
	dev-util/ninja
"

src_configure(){
	mycmakeargs=(
		-DCMAKE_INSTALL_PREFIX="/usr"
	)
	cmake_src_configure
}
