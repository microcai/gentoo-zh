# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit cmake

DESCRIPTION="m17n-provided input methods for Fcitx5"
HOMEPAGE="
	https://fcitx-im.org
	https://github.com/fcitx/fcitx5-m17n
"

if [[ "${PV}" == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/fcitx/fcitx5-m17n.git"
else
	MY_PN="fcitx5-m17n"
	SRC_URI="https://github.com/fcitx/fcitx5-m17n/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${MY_PN}-${PV}"
	KEYWORDS="~amd64"
fi

LICENSE="LGPL-2.1+"
SLOT="5"
IUSE="coverage test"
REQUIRED_USE="
	coverage? ( test )
"
RESTRICT="!test? ( test )"

# m17n-gui>=1.6.3
DEPEND="
	dev-db/m17n-db
	>=dev-libs/m17n-lib-1.6.3[X]
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
