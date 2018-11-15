# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit cmake-utils gnome2-utils xdg-utils git-r3
EGIT_REPO_URI="https://gitlab.com/fcitx/libime.git"

SRC_URI="https://download.fcitx-im.org/data/lm_sc.3gm.arpa-20140820.tar.bz2 -> fcitx5-lm_sc.3gm.arpa-20140820.tar.bz2
https://download.fcitx-im.org/data/dict.utf8-20170423.tar.xz -> fcitx5-dict.utf8-20170423.tar.xz
https://download.fcitx-im.org/data/table.tar.gz -> fcitx5-table.tar.gz
"

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
	ln -s "${DISTDIR}/fcitx5-lm_sc.3gm.arpa-20140820.tar.bz2" data/lm_sc.3gm.arpa-20140820.tar.bz2 || die
	ln -s "${DISTDIR}/fcitx5-dict.utf8-20170423.tar.xz" data/dict.utf8-20170423.tar.xz || die
	ln -s "${DISTDIR}/fcitx5-table.tar.gz" data/table.tar.gz || die
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
