# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake git-r3

DESCRIPTION="Fcitx5 Next generation of fcitx "
HOMEPAGE="https://fcitx-im.org/"
EGIT_REPO_URI="https://github.com/fcitx/libime.git"
EGIT_SUBMODULES=( 'src/libime/kenlm' )
SRC_URI="
	https://download.fcitx-im.org/data/lm_sc.arpa-20230712.tar.xz -> ${PN}-lm_sc.arpa-20230712.tar.xz
	https://download.fcitx-im.org/data/dict-20230412.tar.xz -> ${PN}-dict-20230412.tar.xz
	https://download.fcitx-im.org/data/table.tar.gz -> ${PN}-table.tar.gz
"
LICENSE="LGPL-2+"
SLOT="5"
IUSE="doc test"
RESTRICT="!test? ( test )"

RDEPEND="
	>=app-i18n/fcitx-5.1.5:5
	app-arch/zstd:=
	dev-libs/boost:=
"
DEPEND="${RDEPEND}"
BDEPEND="
	kde-frameworks/extra-cmake-modules:0
	virtual/pkgconfig
	doc? (
		app-text/doxygen
		media-gfx/graphviz[svg]
	)
"

src_prepare() {
	ln -sv "${DISTDIR}/${PN}-lm_sc.arpa-20230712.tar.xz" "${S}/data/lm_sc.arpa-20230712.tar.xz" || die
	ln -sv "${DISTDIR}/${PN}-dict-20230412.tar.xz" "${S}/data/dict-20230412.tar.xz" || die
	ln -sv "${DISTDIR}/${PN}-table.tar.gz" "${S}/data/table.tar.gz" || die
	default
}

src_configure() {
	local mycmakeargs=(
		-DENABLE_DOC=$(usex doc)
		-DENABLE_TEST=$(usex test)
	)
	cmake_src_configure
}

src_compile() {
	cmake_src_compile
	use doc && cmake_src_compile doc
}

src_install() {
	cmake_src_install
	use doc && dodoc -r "${BUILD_DIR}"/doc/*
}
