# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LUA_COMPAT=( lua5-{3,4} )

MY_PN="fcitx5-lua"

inherit cmake lua-single git-r3 xdg

DESCRIPTION="Lua support for fcitx"
HOMEPAGE="https://github.com/fcitx/fcitx5-lua"
EGIT_REPO_URI="https://github.com/fcitx/fcitx5-lua.git"

LICENSE="LGPL-2.1+"
SLOT="5"
KEYWORDS=""
IUSE="+dlopen test"
REQUIRED_USE="${LUA_REQUIRED_USE}"
RESTRICT="!test? ( test )"

RDEPEND="
	${LUA_DEPS}
	>=app-i18n/fcitx-5.1.13:5
"
DEPEND="${RDEPEND}"
BDEPEND="
	kde-frameworks/extra-cmake-modules:0
	sys-devel/gettext
	virtual/pkgconfig
"

pkg_setup() {
	lua-single_pkg_setup
}

src_configure() {
	local mycmakeargs=(
		-DUSE_DLOPEN=$(usex dlopen)
		-DENABLE_TEST=$(usex test)
	)
	cmake_src_configure
}
