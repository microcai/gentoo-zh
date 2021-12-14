# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CMAKE_MAKEFILE_GENERATOR="emake"
inherit cmake

if [[ ${PV} == 9999* ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/cutefishos/texteditor.git"
	EGIT_CHECKOUT_DIR=cutefish-texteditor-${PV}
	KEYWORDS=""
else
	EGIT_COMMIT="7967442827911ed8faf2a8faa6fea3fdc1907381"
	SRC_URI="https://github.com/cutefishos/texteditor/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm64 ~riscv"
	S="${WORKDIR}/texteditor-${EGIT_COMMIT}"
fi

DESCRIPTION="Elegant text editor for Cutefish"
HOMEPAGE="https://github.com/cutefishos/texteditor"
LICENSE="GPL-3"
SLOT="0"
IUSE=""
RDEPEND=""
DEPEND="
	sys-libs/fishui
"
BDEPEND="${DEPEND}
	dev-util/cmake
	dev-qt/qtcore
	dev-qt/qtgui
	dev-qt/qtnetwork
	dev-qt/qtdeclarative
	kde-plasma/kdeplasma-addons
	kde-frameworks/syntax-highlighting
"

src_configure(){
	mycmakeargs=(
		-DCMAKE_INSTALL_PREFIX="/usr"
	)
	cmake_src_configure
}

src_install() {
	default
}
