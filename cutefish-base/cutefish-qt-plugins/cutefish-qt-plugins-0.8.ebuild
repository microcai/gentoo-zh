# Copyright 1999-2022 Gentoo Authors
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
	dev-qt/qtcore
	dev-qt/qtwidgets
	dev-qt/qtquickcontrols2
	dev-qt/qtdbus
	dev-qt/qtx11extras
	dev-libs/libqtxdg
	dev-libs/libdbusmenu-qt
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
