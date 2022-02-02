# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

if [[ ${PV} == 9999* ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/cutefishos/icons.git"
	EGIT_CHECKOUT_DIR=cutefish-icons-${PV}
	KEYWORDS=""
else
	EGIT_COMMIT="aa0422ffbd201ee7da3670b27eccc11b6c799d62"
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
	dev-util/ninja
"

src_configure(){
	mycmakeargs=(
		-DCMAKE_INSTALL_PREFIX="/usr"
	)
	cmake_src_configure
}
