# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake git-r3

DESCRIPTION="Fcitx5 Next generation of fcitx"
HOMEPAGE="https://fcitx-im.org/"
EGIT_REPO_URI="https://github.com/fcitx/libime.git"

LM_VER="20250113"
DICT_VER="20250327"
TABLE_VER="20240108"

SRC_URI="
	data? (
		https://download.fcitx-im.org/data/lm_sc.arpa-${LM_VER}.tar.zst
		https://download.fcitx-im.org/data/dict-${DICT_VER}.tar.zst
		https://download.fcitx-im.org/data/table-${TABLE_VER}.tar.zst
	)
"

LICENSE="LGPL-2+"
SLOT="5"
KEYWORDS=""
IUSE="+data doc test"
RESTRICT="!test? ( test )"
RDEPEND="
	>=app-i18n/fcitx-5.1.13:5
	app-arch/zstd:=
	dev-libs/boost:=
"
DEPEND="${RDEPEND}"
BDEPEND="
	kde-frameworks/extra-cmake-modules:0
	virtual/pkgconfig
	app-arch/zstd
	doc? (
		app-text/doxygen
		dev-texlive/texlive-fontutils
	)
"

src_unpack() {
	git-r3_src_unpack

	if use data; then
		mkdir -p "${S}/data" || die
		cp "${DISTDIR}/lm_sc.arpa-${LM_VER}.tar.zst" "${S}/data/" || die
		cp "${DISTDIR}/dict-${DICT_VER}.tar.zst" "${S}/data/" || die
		cp "${DISTDIR}/table-${TABLE_VER}.tar.zst" "${S}/data/" || die
	fi
}

src_configure() {
	# 957570 : remove unused kenlm CMakeLists.txt
	rm src/libime/core/kenlm/CMakeLists.txt || die

	local mycmakeargs=(
		-DENABLE_DATA=$(usex data)
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
