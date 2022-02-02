# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CMAKE_MAKEFILE_GENERATOR="emake"
inherit cmake

if [[ ${PV} == 9999* ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/cutefishos/launcher.git"
	EGIT_CHECKOUT_DIR=cutefish-launcher-${PV}
	KEYWORDS=""
else
	SRC_URI="https://github.com/cutefishos/launcher/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm64 ~riscv"
	S="${WORKDIR}/launcher-${PV}"
fi

DESCRIPTION="CutefishOS's full-screen application launcher"
HOMEPAGE="https://github.com/cutefishos/launcher"
LICENSE="GPL-3"
SLOT="0"
IUSE=""
RDEPEND="
	sys-libs/fishui
	sys-libs/libcutefish
"
DEPEND="
	dev-qt/qtcore
	dev-qt/qtwidgets
	dev-qt/qtdbus
	dev-qt/qtquickcontrols2
	dev-qt/linguist-tools
	dev-qt/qtconcurrent
	kde-frameworks/kwindowsystem
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
