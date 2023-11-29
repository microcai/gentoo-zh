# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit cmake

DESCRIPTION="m17n-provided input methods for Fcitx5"
HOMEPAGE="https://github.com/fcitx/fcitx5-m17n"
MY_PN="fcitx5-m17n"
S="${WORKDIR}/${MY_PN}-${PV}"
SRC_URI="https://download.fcitx-im.org/fcitx5/${MY_PN}/${MY_PN}-${PV}.tar.xz -> ${P}.tar.xz"
KEYWORDS="~amd64 ~arm64 ~riscv"

LICENSE="LGPL-2.1+"
SLOT="5"
IUSE="coverage test"
RESTRICT="!test? ( test )"

# m17n-gui>=1.6.3
RDEPEND="
	>=app-i18n/fcitx-5.1.5:5
	>=dev-libs/m17n-lib-1.6.3[X]
	dev-db/m17n-db
	dev-libs/libfmt
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
	virtual/pkgconfig
	kde-frameworks/extra-cmake-modules:0
"

src_configure() {
	local mycmakeargs=(
		-DENABLE_TEST=$(usex test)
		-DENABLE_COVERAGE=$(usex coverage)
	)
	cmake_src_configure
}
