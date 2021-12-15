# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CMAKE_MAKEFILE_GENERATOR="emake"
inherit cmake

if [[ ${PV} == 9999* ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/cutefishos/filemanager.git"
	EGIT_CHECKOUT_DIR=cutefish-filemanager-${PV}
	KEYWORDS=""
else
	EGIT_COMMIT="94ecc5661736bf50440c150e06cb3266ddb10f48"
	SRC_URI="https://github.com/cutefishos/filemanager/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm64 ~riscv"
	S="${WORKDIR}/filemanager-${EGIT_COMMIT}"
fi

DESCRIPTION="Cutefish File Manager"
HOMEPAGE="https://github.com/cutefishos/filemanager"
LICENSE="GPL-3"
SLOT="0"
IUSE=""
RDEPEND=""
DEPEND="
	sys-libs/fishui
	sys-libs/libcutefish
	kde-frameworks/kio
	kde-frameworks/solid
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
