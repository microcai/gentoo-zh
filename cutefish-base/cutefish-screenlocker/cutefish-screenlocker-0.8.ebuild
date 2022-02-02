# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CMAKE_MAKEFILE_GENERATOR="emake"
inherit cmake

if [[ ${PV} = 9999* ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/cutefishos/screenlocker.git"
	EGIT_CHECKOUT_DIR=cutefish-screenlocker-${PV}
	KEYWORDS=""
else
	EGIT_COMMIT="fe2dacebfc9993ee32fdcf0680c0919359b55316"
	SRC_URI="https://github.com/cutefishos/screenlocker/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm64 ~riscv"
	S="${WORKDIR}/screenlocker-${EGIT_COMMIT}"
fi

DESCRIPTION="CutefishOS system screen locker"
HOMEPAGE="https://github.com/cutefishos/core"
LICENSE="GPL-3"
SLOT="0"
IUSE=""
RDEPEND="
	sys-libs/fishui
	sys-libs/libcutefish
"
DEPEND="
	dev-qt/qtcore
	dev-qt/qtdbus
	dev-qt/qtwidgets
	dev-qt/qtx11extras
	dev-qt/linguist-tools
"
BDEPEND="${DEPEND}"

src_configure(){
	mycmakeargs=(
		-DCMAKE_INSTALL_PREFIX="/usr"
	)
	cmake_src_configure
}
