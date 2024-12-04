# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LUA_COMPAT=( lua5-{3,4} )

inherit cmake lua xdg git-r3

EGIT_REPO_URI="https://github.com/fcitx/fcitx5-lua.git"
DESCRIPTION="Lua support for fcitx"
HOMEPAGE="https://github.com/fcitx/fcitx5-lua"

LICENSE="LGPL-2.1+"
SLOT="5"
IUSE="+dlopen test"
REQUIRED_USE="${LUA_REQUIRED_USE}"
RESTRICT="!test? ( test )"

RDEPEND="
	${LUA_DEPS}
	app-i18n/fcitx:5
"

DEPEND="
	${RDEPEND}
"

BDEPEND="
	kde-frameworks/extra-cmake-modules:0
	virtual/pkgconfig
"

src_configure() {
	local mycmakeargs=(
		-DCMAKE_INSTALL_LIBDIR="${EPREFIX}/usr/$(get_libdir)"
		-DCMAKE_INSTALL_SYSCONFDIR="${EPREFIX}/etc"
		-DUSE_DLOPEN=$(usex dlopen)
		-DENABLE_TEST=$(usex test)
	)
	cmake_src_configure
}
