# Copyright 1999-2021 Gentoo Authors
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
	EGIT_COMMIT="460f94c00402bc1fab0b13d51ee4b82d108259d2"
	SRC_URI="https://github.com/cutefishos/statusbar/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm64 ~riscv"
	S="${WORKDIR}/statusbar-${EGIT_COMMIT}"
fi

DESCRIPTION="Status of the system, such as time, system tray"
HOMEPAGE="https://github.com/cutefishos/statusbar"
LICENSE="GPL-3"
SLOT="0"
IUSE=""
RDEPEND=""
DEPEND="
	sys-libs/fishui
	sys-libs/libcutefish
	dev-libs/libdbusmenu-qt
	dev-qt/qtsvg
"
BDEPEND="${DEPEND}
	kde-frameworks/extra-cmake-modules
	dev-util/ninja
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
