# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit cmake

DESCRIPTION="m17n-provided input methods for Fcitx5"
HOMEPAGE="https://github.com/fcitx/fcitx5-m17n"

MY_PN="fcitx5-m17n"
SRC_URI="https://github.com/fcitx/fcitx5-m17n/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_PN}-${PV}"
KEYWORDS="~amd64"

LICENSE="LGPL-2.1+"
SLOT="5"
IUSE="coverage test"
REQUIRED_USE="
	coverage? ( test )
"
RESTRICT="!test? ( test )"

# m17n-gui>=1.6.3
DEPEND="
	>=app-i18n/fcitx-5.1.5:5
	>=dev-libs/m17n-lib-1.6.3[X]
	dev-db/m17n-db
"
RDEPEND="
	${DEPEND}
	test? (
		coverage? (
			dev-util/lcov
		)
	)
"

src_configure() {
	local mycmakeargs=(
		-DENABLE_TEST=$(usex test)
		-DENABLE_COVERAGE=$(usex coverage)
	)
	cmake_src_configure
}
