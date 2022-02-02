# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

if [[ ${PV} == 9999* ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/cutefishos/kwin-plugins.git"
	EGIT_CHECKOUT_DIR=cutefish-kwin-plugins-${PV}
	KEYWORDS=""
else
	SRC_URI="https://github.com/cutefishos/kwin-plugins/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm64 ~riscv"
	S="${WORKDIR}/kwin-plugins-${PV}"
fi

DESCRIPTION="CutefishOS KWin Plugins"
HOMEPAGE="https://github.com/cutefishos/kwin-plugins"
LICENSE="GPL-3"
SLOT="0"
IUSE=""
RDEPEND=""
DEPEND="
	dev-qt/qtcore
	dev-qt/qtgui
	kde-frameworks/kcoreaddons
	kde-frameworks/kwindowsystem
	kde-frameworks/kconfig
	kde-plasma/kdecoration
	kde-plasma/kwin
"
BDEPEND="${DEPEND}"

src_configure(){
	mycmakeargs=(
		-DCMAKE_INSTALL_PREFIX="/usr"
	)
	cmake_src_configure
}
