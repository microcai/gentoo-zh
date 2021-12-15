# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

if [[ ${PV} == 9999* ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/cutefishos/icons.git"
	EGIT_CHECKOUT_DIR=cutefish-icons-${PV}
	KEYWORDS=""
else
	EGIT_COMMIT="119feb59404f329eb2f1ebe14d63f3d53f8bd96c"
	SRC_URI="https://github.com/cutefishos/icons/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm64 ~riscv"
	S="${WORKDIR}/icons-${EGIT_COMMIT}"
fi

DESCRIPTION="System default icon theme of CutefishOS"
HOMEPAGE="https://github.com/cutefishos/icons"
LICENSE="GPL-3"
SLOT="0"
IUSE=""
RDEPEND=""
DEPEND=""
BDEPEND="${DEPEND}
	kde-frameworks/extra-cmake-modules
	dev-util/ninja
"

src_configure(){
	mycmakeargs=(
		-DCMAKE_INSTALL_PREFIX="/usr"
	)
	cmake_src_configure
}
