# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CMAKE_MAKEFILE_GENERATOR="emake"
inherit cmake

if [[ ${PV} == 9999* ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/cutefishos/sddm-theme.git"
	EGIT_CHECKOUT_DIR=cutefish-sddm-theme-${PV}
	KEYWORDS=""
else
	EGIT_COMMIT="d3722b62c5b87b8bb88a7e2d75dbdefaadc7d1a2"
	SRC_URI="https://github.com/cutefishos/sddm-theme/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm64 ~riscv"
	S="${WORKDIR}/sddm-theme-${EGIT_COMMIT}"
fi

DESCRIPTION="CutefishOS SDDM Theme"
HOMEPAGE="https://github.com/cutefishos/sddm-theme"
LICENSE="GPL-3"
SLOT="0"
IUSE=""
RDEPEND=""
DEPEND=""
BDEPEND=""

src_configure(){
	mycmakeargs=(
		-DCMAKE_INSTALL_PREFIX="/usr"
	)
	cmake_src_configure
}
