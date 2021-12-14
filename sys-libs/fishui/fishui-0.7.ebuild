# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

if [[ ${PV} == 9999* ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/cutefishos/fishui.git"
	EGIT_CHECKOUT_DIR=${PN}-${PV}
	KEYWORDS=""
else
	EGIT_COMMIT="1d37a00d0aba69076f179c6dcdfd2f17e55b9516"
	SRC_URI="https://github.com/cutefishos/fishui/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm64 ~riscv"
	S="${WORKDIR}/${PN}-${EGIT_COMMIT}"
fi

DESCRIPTION="GUI library based on QQC2 for Cutefish applications"
HOMEPAGE="https://github.com/cutefishos/fishui"
LICENSE="GPL-3"
SLOT="0"
IUSE=""
RDEPEND=""
DEPEND="
	kde-frameworks/kwindowsystem
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
