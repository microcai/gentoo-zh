# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LUA_COMPAT=( lua5-3 )

inherit cmake lua-single xdg

if [[ "${PV}" == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/fcitx/fcitx5-lua.git"
else
	SRC_URI="https://github.com/fcitx/fcitx5-lua/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="Lua support for fcitx"
HOMEPAGE="https://github.com/fcitx/fcitx5-lua"

LICENSE="LGPL-2+"
SLOT="5"
IUSE="test"
REQUIRED_USE=""
RESTRICT="!test? ( test )"

RDEPEND="
	${LUA_DEPS}
	app-i18n/fcitx5
"

DEPEND="
	${RDEPEND}
"

BDEPEND="
	virtual/pkgconfig
"

src_configure() {
	local mycmakeargs=(
		-DCMAKE_INSTALL_LIBDIR="${EPREFIX}/usr/$(get_libdir)"
		-DCMAKE_INSTALL_SYSCONFDIR="${EPREFIX}/etc"
	)
	cmake_src_configure
}
