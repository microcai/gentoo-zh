# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake gnome2-utils xdg-utils git-r3
EGIT_REPO_URI="https://github.com/fcitx/libime.git"

if [[ "${PV}" == 9999* ]]; then
	KEYWORDS=""
else
	KEYWORDS="~amd64"
	EGIT_COMMIT="${PV}"
fi
_kenlmcommit="01c49fe86714276f77be9278d00906fc994256c1"

SRC_URI="https://download.fcitx-im.org/data/lm_sc.3gm.arpa-20140820.tar.bz2 -> fcitx5-lm_sc.3gm.arpa-20140820.tar.bz2
https://download.fcitx-im.org/data/dict.utf8-20210402.tar.xz -> fcitx5-dict.utf8-20210402.tar.xz
https://download.fcitx-im.org/data/table.tar.gz -> fcitx5-table.tar.gz
https://github.com/kpu/kenlm/archive/${_kenlmcommit}.tar.gz -> kenlm.tar.gz
"

DESCRIPTION="Fcitx5 Next generation of fcitx "
HOMEPAGE="https://fcitx-im.org/ https://gitlab.com/fcitx/libime"

LICENSE="BSD-1 GPL-2+ LGPL-2+ MIT"
SLOT="5"
IUSE=""
REQUIRED_USE=""

RDEPEND="app-i18n/fcitx5"
DEPEND="${RDEPEND}
	dev-libs/boost
	kde-frameworks/extra-cmake-modules:5
	virtual/pkgconfig"

src_prepare() {
	ln -s "${DISTDIR}/fcitx5-lm_sc.3gm.arpa-20140820.tar.bz2" data/lm_sc.3gm.arpa-20140820.tar.bz2 || die
	ln -s "${DISTDIR}/fcitx5-dict.utf8-20210402.tar.xz" data/dict.utf8-20210402.tar.xz || die
	ln -s "${DISTDIR}/fcitx5-table.tar.gz" data/table.tar.gz || die
	tar -xvzf "${DISTDIR}/kenlm.tar.gz" -C src/libime/core/kenlm  || die
	cmake_src_prepare
	xdg_environment_reset
}

src_configure() {
	local mycmakeargs=(
		-DCMAKE_INSTALL_LIBDIR="${EPREFIX}/usr/$(get_libdir)"
		-DCMAKE_INSTALL_SYSCONFDIR="${EPREFIX}/etc"
	)
	cmake_src_configure
}

src_install(){
	cmake_src_install
}
