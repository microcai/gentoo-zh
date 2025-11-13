# Copyright 2023-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="fcitx5-m17n"

inherit cmake git-r3

DESCRIPTION="m17n-provided input methods for Fcitx5"
HOMEPAGE="https://github.com/fcitx/fcitx5-m17n"
EGIT_REPO_URI="https://github.com/fcitx/fcitx5-m17n.git"

LICENSE="LGPL-2.1+"
SLOT="5"
KEYWORDS=""
IUSE="test"
RESTRICT="!test? ( test )"

# m17n-gui>=1.6.3
RDEPEND="
	>=app-i18n/fcitx-5.1.13:5
	dev-db/m17n-db
	>=dev-libs/m17n-lib-1.6.3[X]
"
DEPEND="${RDEPEND}"
BDEPEND="
	virtual/pkgconfig
	kde-frameworks/extra-cmake-modules:0
"

src_configure() {
	local mycmakeargs=(
		-DENABLE_TEST=$(usex test)
	)
	cmake_src_configure
}
