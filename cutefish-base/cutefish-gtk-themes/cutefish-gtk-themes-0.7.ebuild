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
	SRC_URI="https://github.com/cutefishos/gtk-themes/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm64 ~riscv"
	S="${WORKDIR}/gtk-themes-${PV}"
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
