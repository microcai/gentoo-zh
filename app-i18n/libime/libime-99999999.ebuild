# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit cmake-utils xdg-utils git-r3
EGIT_REPO_URI="https://gitlab.com/fcitx/libime.git"

SRC_URI=""

DESCRIPTION="Fcitx5 Next generation of fcitx "
HOMEPAGE="https://fcitx-im.org/ https://gitlab.com/fcitx/libime"

LICENSE="BSD-1 GPL-2+ LGPL-2+ MIT"
SLOT="5"
KEYWORDS=""
IUSE=""
REQUIRED_USE=""

RDEPEND="app-i18n/fcitx5"
DEPEND="${RDEPEND}
	kde-frameworks/extra-cmake-modules:5
	virtual/pkgconfig"

src_prepare() {
	cmake-utils_src_prepare
	xdg_environment_reset
}

src_configure() {
	local mycmakeargs=(
		-DLIB_INSTALL_DIR="${EPREFIX}/usr/$(get_libdir)"
		-DSYSCONFDIR="${EPREFIX}/etc"
	)
	cmake-utils_src_configure
}

src_install(){
	cmake-utils_src_install
}
