# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg-utils flag-o-matic toolchain-funcs

KEYWORDS="~amd64 ~arm64 ~loong ~riscv ~x86"
SRC_URI="https://download.fcitx-im.org/fcitx5/libime/libime-${PV}_dict.tar.xz"
DESCRIPTION="Fcitx5 Next generation of fcitx "
HOMEPAGE="https://fcitx-im.org/ https://gitlab.com/fcitx/libime"
LICENSE="BSD-1 GPL-2+ LGPL-2+ MIT"
SLOT="5"
IUSE="coverage doc test"
REQUIRED_USE="
	coverage? ( test )
"
RESTRICT="!test? ( test )"
RDEPEND="
	>=app-i18n/fcitx-5.1.5:5
	test? (
		coverage? (
			dev-util/lcov
		)
	)
	doc? ( app-doc/doxygen )
"
DEPEND="${RDEPEND}
	app-arch/zstd:=
	dev-libs/boost:=
	kde-frameworks/extra-cmake-modules:0
	virtual/pkgconfig
"

src_prepare() {
	cmake_src_prepare
	xdg_environment_reset
}

src_configure() {
	if [[ $(tc-get-cxx-stdlib) == libc++ ]]; then
		append-cxxflags -D_LIBCPP_ENABLE_CXX17_REMOVED_FEATURES
	fi

	local mycmakeargs=(
		-DCMAKE_INSTALL_LIBDIR="${EPREFIX}/usr/$(get_libdir)"
		-DCMAKE_INSTALL_SYSCONFDIR="${EPREFIX}/etc"
		-DENABLE_COVERAGE=$(usex coverage)
		-DENABLE_DOC=$(usex doc)
		-DENABLE_TEST=$(usex test)
	)
	cmake_src_configure
}

src_install(){
	cmake_src_install
}
