# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CMAKE_MAKEFILE_GENERATOR="emake"
inherit cmake
if [[ ${PV} == 9999* ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/cutefishos/calculator.git"
	EGIT_CHECKOUT_DIR=cutefish-calculator-${PV}
	KEYWORDS=""
else
	EGIT_COMMIT="6cce31e310ae68fa5aafa9b9e92f542c37db19ae"
	SRC_URI="https://github.com/cutefishos/calculator/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm64 ~riscv"
	S="${WORKDIR}/calculator-${EGIT_COMMIT}"
fi

DESCRIPTION="CutefishOS Calculator"
HOMEPAGE="https://github.com/cutefishos/calculator"
LICENSE="GPL-3"
SLOT="0"
IUSE=""
RDEPEND="
	sys-libs/fishui
	sys-libs/libcutefish
"
DEPEND="
	dev-qt/qtcore
	dev-qt/qtgui
	dev-qt/qtquickcontrols2
	dev-qt/linguist-tools
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
