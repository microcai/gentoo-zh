# Copyright 1999-2022 Gentoo Authors
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
	EGIT_COMMIT="1f208792b7e8a863bf6ea624340288856976f180"
	SRC_URI="https://github.com/cutefishos/texteditor/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm64 ~riscv"
	S="${WORKDIR}/texteditor-${EGIT_COMMIT}"
fi

DESCRIPTION="Elegant text editor for Cutefish"
HOMEPAGE="https://github.com/cutefishos/texteditor"
LICENSE="GPL-3"
SLOT="0"
IUSE=""
RDEPEND="
	sys-libs/fishui
"
DEPEND="
	dev-qt/qtcore
	dev-qt/qtdeclarative
	kde-frameworks/syntax-highlighting
"
BDEPEND="${DEPEND}"

src_configure(){
	mycmakeargs=(
		-DCMAKE_INSTALL_PREFIX="/usr"
	)
	cmake_src_configure
}

src_install() {
	default
}
