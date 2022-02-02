# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CMAKE_MAKEFILE_GENERATOR="emake"
inherit cmake

if [[ ${PV} == 9999* ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/cutefishos/core.git"
	EGIT_CHECKOUT_DIR=cutefish-core-${PV}
	KEYWORDS=""
else
	SRC_URI="https://github.com/cutefishos/core/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm64 ~riscv"
	S="${WORKDIR}/core-${PV}"
fi

DESCRIPTION="System components and backend of CutefishOS"
HOMEPAGE="https://github.com/cutefishos/core"
LICENSE="GPL-3"
SLOT="0"
IUSE=""
RDEPEND="
	sys-libs/fishui
"
DEPEND="
	dev-qt/qtcore
	dev-qt/qtgui
	dev-qt/qtquickcontrols2
	dev-qt/qtdbus
	dev-qt/qtxml
	dev-qt/qtx11extras
	dev-qt/linguist-tools
	sys-auth/polkit-qt
	kde-frameworks/kwindowsystem
	kde-frameworks/kcoreaddons
	kde-frameworks/kidletime
	x11-drivers/xf86-input-libinput
	x11-drivers/xf86-input-synaptics
	x11-misc/appmenu-gtk-module
	x11-libs/libXinerama
	x11-libs/libXcursor
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
