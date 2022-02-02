# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CMAKE_MAKEFILE_GENERATOR="emake"
inherit cmake
if [[ ${PV} == 9999* ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/cutefishos/appmotor.git"
	EGIT_CHECKOUT_DIR=cutefish-appmotor-${PV}
	KEYWORDS=""
else
	EGIT_COMMIT="c332dbac831ba3050513bd340ec25ab84f781750"
	SRC_URI="https://github.com/cutefishos/appmotor/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm64 ~riscv"
	S="${WORKDIR}/appmotor-${EGIT_COMMIT}"
fi

DESCRIPTION="Optimize the speed of starting cutefish apps"
HOMEPAGE="https://github.com/cutefishos/appmotor"
LICENSE="GPL-3"
SLOT="0"
IUSE=""
RDEPEND=""
DEPEND="
	kde-frameworks/extra-cmake-modules
	dev-libs/glib
	dev-qt/qtcore
	dev-qt/qtwidgets
	dev-qt/qtdeclarative
	dev-qt/qtquickcontrols2
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
