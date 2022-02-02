# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

if [[ ${PV} == 9999* ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/cutefishos/wallpapers.git"
	EGIT_CHECKOUT_DIR=cutefish-wallpapers-${PV}
	KEYWORDS=""
else
	EGIT_COMMIT="9acd305776a88e2a6c497c8e9b719c0f39a65c97"
	SRC_URI="https://github.com/cutefishos/wallpapers/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm64 ~riscv"
	S="${WORKDIR}/wallpapers-${EGIT_COMMIT}"
fi

DESCRIPTION="CutefishOS's system wallpaper"
HOMEPAGE="https://github.com/cutefishos/wallpapers"
LICENSE="GPL-3"
SLOT="0"
IUSE=""
RDEPEND=""
DEPEND=""
BDEPEND="${DEPEND}"

src_configure(){
	mycmakeargs=(
		-DCMAKE_INSTALL_PREFIX="/usr"
	)
	cmake_src_configure
}
