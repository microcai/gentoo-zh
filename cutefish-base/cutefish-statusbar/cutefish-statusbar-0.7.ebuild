# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CMAKE_MAKEFILE_GENERATOR="emake"
inherit cmake

if [[ ${PV} == 9999* ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/cutefishos/statusbar.git"
	EGIT_CHECKOUT_DIR=cutefish-statusbar-${PV}
	KEYWORDS=""
else
	EGIT_COMMIT="078a55144ef56166529de6ee4c9091af0bb2818b"
	SRC_URI="https://github.com/cutefishos/statusbar/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm64 ~riscv"
	S="${WORKDIR}/statusbar-${EGIT_COMMIT}"
fi

DESCRIPTION="Status of the system, such as time, system tray"
HOMEPAGE="https://github.com/cutefishos/statusbar"
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
	dev-qt/qtx11extras
	dev-qt/qtconcurrent
	dev-qt/linguist-tools
	dev-qt/qtquickcontrols2
	kde-frameworks/kwindowsystem
"
BDEPEND="${DEPEND}"

src_configure(){
	mycmakeargs=(
		-DCMAKE_INSTALL_PREFIX="/usr"
	)
	cmake_src_configure
}
