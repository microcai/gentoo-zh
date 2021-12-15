# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

if [[ ${PV} = 9999* ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/cutefishos/qt-plugins.git"
	EGIT_CHECKOUT_DIR=cutefish-qt-plugins-${PV}
	KEYWORDS=""
else
	EGIT_COMMIT="b60cdd4c0cf185f538c9746ef321582cbab9568c"
	SRC_URI="https://github.com/cutefishos/qt-plugins/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm64 ~riscv"
	S="${WORKDIR}/qt-plugins-${EGIT_COMMIT}"
fi

DESCRIPTION="Unify Qt application style of CutefishOS"
HOMEPAGE="https://github.com/cutefishos/qt-plugins"
LICENSE="GPL-3"
SLOT="0"
IUSE=""
RDEPEND=""
DEPEND="
	kde-frameworks/kwindowsystem
	dev-libs/libdbusmenu-qt
	dev-libs/libqtxdg
	dev-qt/qtquickcontrols2[widgets]
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
