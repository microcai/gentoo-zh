# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LUA_COMPAT=( lua5-{3,4} )

inherit cmake lua xdg

if [[ "${PV}" == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/fcitx/fcitx5-lua.git"
else
	MY_PN="fcitx5-lua"
	MY_P="${MY_PN}-${PV}"
	S="${WORKDIR}/${MY_PN}-${PV}"
	SRC_URI="https://github.com/fcitx/${MY_PN}/archive/refs/tags/${PV}.tar.gz -> ${MY_P}.tar.gz"
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
	app-i18n/fcitx:5
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
