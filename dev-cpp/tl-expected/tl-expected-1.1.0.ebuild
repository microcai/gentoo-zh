# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Guideline Support Library implementation by Microsoft"
HOMEPAGE="https://github.com/TartanLlama/expected"
SRC_URI="https://github.com/TartanLlama/expected/archive/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN##tl-}-${PV}"
LICENSE="CC0-1.0"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~ppc64 ~riscv ~x86"
IUSE="test"
RESTRICT="!test? ( test )"

# header only library
BDEPEND="test? ( dev-cpp/catch:1 )"

PATCHES=("${FILESDIR}/1.0.0-use_system_catch.patch")

src_configure() {
	local mycmakeargs=(
		-DEXPECTED_BUILD_TESTS=$(usex test)
	)
	use test && mycmakeargs+=( -DFORCE_SYSTEM_CATCH=ON )
	cmake_src_configure
}
