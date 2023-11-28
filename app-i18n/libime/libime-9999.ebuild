# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg-utils git-r3 flag-o-matic toolchain-funcs
EGIT_REPO_URI="https://github.com/fcitx/libime.git"
EGIT_SUBMODULES=( 'src/libime/kenlm' )
SRC_URI="
	https://download.fcitx-im.org/data/lm_sc.arpa-20230712.tar.xz -> ${PN}-lm_sc.arpa-20230712.tar.xz
	https://download.fcitx-im.org/data/dict-20230412.tar.xz -> ${PN}-dict-20230412.tar.xz
	https://download.fcitx-im.org/data/table.tar.gz -> ${PN}-table.tar.gz
"
DESCRIPTION="Fcitx5 Next generation of fcitx "
HOMEPAGE="https://fcitx-im.org/"
LICENSE="LGPL-2+"
SLOT="5"
IUSE="coverage doc test"
REQUIRED_USE="
	coverage? ( test )
"
RESTRICT="!test? ( test )"
RDEPEND="
	>=app-i18n/fcitx-5.1.5:5
	app-arch/zstd:=
	dev-libs/boost:=
	doc? ( app-doc/doxygen )
"
DEPEND="
	${RDEPEND}
	test? (
		coverage? (
			dev-util/lcov
		)
	)
"
BDEPEND="
	kde-frameworks/extra-cmake-modules:0
	virtual/pkgconfig
"

src_prepare() {
	ln -sv "${DISTDIR}/${PN}-lm_sc.arpa-20230712.tar.xz" "${S}/data/lm_sc.arpa-20230712.tar.xz" || die
	ln -sv "${DISTDIR}/${PN}-dict-20230412.tar.xz" "${S}/data/dict-20230412.tar.xz" || die
	ln -sv "${DISTDIR}/${PN}-table.tar.gz" "${S}/data/table.tar.gz" || die
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
