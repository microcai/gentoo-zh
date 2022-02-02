# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CMAKE_MAKEFILE_GENERATOR="emake"
inherit cmake

if [[ ${PV} == 9999* ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/cutefishos/gtk-themes.git"
	EGIT_CHECKOUT_DIR=cutefish-gtk-themes-${PV}
	KEYWORDS=""
else
	EGIT_COMMIT="91f762fc2b069c4754d7e5741e07613bfea049a4"
	SRC_URI="https://github.com/cutefishos/gtk-themes/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm64 ~riscv"
	S="${WORKDIR}/gtk-themes-${EGIT_COMMIT}"
fi

DESCRIPTION="CutefishOS GTK Themes"
HOMEPAGE="https://github.com/cutefishos/gtk-themes"
LICENSE="GPL-3"
SLOT="0"
IUSE=""
RDEPEND=""
DEPEND=""
BDEPEND=""

src_configure(){
	mycmakeargs=(
		-DCMAKE_INSTALL_PREFIX="/usr"
	)
	cmake_src_configure
}
