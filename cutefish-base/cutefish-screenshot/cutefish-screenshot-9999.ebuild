# Copyright 1999-2021 Gentoo Authors
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
	EGIT_COMMIT="1ab2dd3e6e94a7ec722afd02bc63beae9cb28b97"
	SRC_URI="https://github.com/cutefishos/screenshot/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm64 ~riscv"
	S="${WORKDIR}/screenshot-${EGIT_COMMIT}"
fi

DESCRIPTION="Screenshot tool for CutefishOS"
HOMEPAGE="https://github.com/cutefishos/screenshot"
LICENSE="GPL-3"
SLOT="0"
IUSE=""
RDEPEND=""
DEPEND=""
BDEPEND="${DEPEND}
	kde-frameworks/extra-cmake-modules
	dev-qt/linguist-tools[qml]
	dev-qt/assistant
	dev-qt/designer
	dev-qt/qdbusviewer
"

src_configure(){
	mycmakeargs=(
		-DCMAKE_INSTALL_PREFIX="/usr"
	)
	cmake_src_configure
}
